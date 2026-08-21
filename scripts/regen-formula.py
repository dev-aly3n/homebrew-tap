#!/usr/bin/env python3
"""Regenerate Formula/aipager.rb against a chosen aipager release.

Why: Homebrew's `virtualenv_install_with_resources` installs an OFFLINE venv
from `resource` blocks — every runtime dep (including transitives) must be
listed there. Hand-editing the formula on each release missed `PyYAML` for
five releases (0.4.0–0.4.4), shipping a broken brew install. This script
rebuilds the whole resource list from a single source of truth — PyPI — so
the formula can't drift again.

Usage:
    scripts/regen-formula.py 0.4.4 > Formula/aipager.rb
    scripts/regen-formula.py             # uses latest stable on PyPI

It:
  1. Reads aipager's published `requires_dist` from PyPI for that version
     and drops `dtach-bin` (the brew formula uses the system dtach).
  2. Resolves the FULL transitive tree with `pip install --dry-run --report`
     (no install — just resolution).
  3. Fetches the sdist URL + sha256 for every resolved package from PyPI.
  4. Emits a complete formula on stdout.

Run with any Python 3.10+; needs only the stdlib and `pip` (already
bundled). Pin the calling Python to match the formula's `depends_on
"python@3.12"` for the most accurate marker evaluation.
"""

from __future__ import annotations

import json
import re
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.request
from pathlib import Path

PYPI = "https://pypi.org/pypi"
# These come from Homebrew, not PyPI, so they must NOT appear as resources.
EXCLUDED = {"dtach-bin", "aipager"}


def _pypi(name: str, ver: str | None = None, *, attempts: int = 8) -> dict:
    """Fetch PyPI's JSON metadata, retrying a 404 for a version we expect.

    PyPI's JSON API is eventually consistent across CDN edges. The
    publish workflow already waits for `pypi.org/pypi/aipager/<v>/json`
    to answer before running this script — and on the v0.7.1 release it
    DID answer 200 to that curl, then returned 404 to this urlopen
    seconds later, failing the release's tap bump. Same URL, different
    edge. Retrying here rather than in the workflow covers the
    dependency lookups below too, which have the same exposure.

    Only 404 and 5xx are retried: a 403 or a malformed URL will not fix
    itself, and spinning for a minute on those would just hide the real
    error.
    """
    url = f"{PYPI}/{name}/{ver}/json" if ver else f"{PYPI}/{name}/json"
    delay = 2.0
    for attempt in range(1, attempts + 1):
        try:
            with urllib.request.urlopen(url) as r:
                return json.load(r)
        except urllib.error.HTTPError as e:
            retryable = e.code == 404 or 500 <= e.code < 600
            if not retryable or attempt == attempts:
                raise
            print(f"  {url} -> HTTP {e.code}, retrying in {delay:.0f}s "
                  f"({attempt}/{attempts})", file=sys.stderr)
        except urllib.error.URLError as e:
            if attempt == attempts:
                raise
            print(f"  {url} -> {e.reason}, retrying in {delay:.0f}s "
                  f"({attempt}/{attempts})", file=sys.stderr)
        time.sleep(delay)
        delay = min(delay * 2, 30.0)
    raise AssertionError("unreachable")   # pragma: no cover


def _sdist(name: str, ver: str) -> tuple[str, str]:
    data = _pypi(name, ver)
    for u in data["urls"]:
        if u["packagetype"] == "sdist":
            return u["url"], u["digests"]["sha256"]
    raise SystemExit(f"no sdist for {name}=={ver} on PyPI")


def _direct_runtime_deps(meta: dict) -> list[str]:
    """Pull aipager's runtime deps from PyPI metadata, dropping extras + dtach-bin."""
    out: list[str] = []
    for req in meta["info"]["requires_dist"] or []:
        name_spec, _, marker = req.partition(";")
        if "extra ==" in marker:
            continue  # optional extras like [voice] don't ship via brew
        name = re.split(r"[<>=!~ ]", name_spec.strip(), maxsplit=1)[0]
        if name.lower() in EXCLUDED:
            continue
        out.append(name_spec.strip())
    return out


def _resolve_tree(direct: list[str]) -> dict[str, str]:
    """Use pip's resolver in dry-run mode to enumerate the full transitive tree."""
    with tempfile.NamedTemporaryFile(suffix=".json", delete=False) as f:
        rep = Path(f.name)
    cmd = [
        sys.executable, "-m", "pip", "install",
        "--quiet", "--dry-run", "--ignore-installed",
        "--disable-pip-version-check",
        "--report", str(rep),
        *direct,
    ]
    subprocess.run(cmd, check=True)
    report = json.loads(rep.read_text())
    rep.unlink(missing_ok=True)
    tree: dict[str, str] = {}
    for item in report.get("install", []):
        m = item["metadata"]
        tree[m["name"]] = m["version"]
    return tree


_TEMPLATE = """\
class Aipager < Formula
  include Language::Python::Virtualenv

  desc "Telegram remote-control daemon for Claude Code CLI sessions"
  homepage "https://github.com/dev-aly3n/aipager"
  url "{aipager_url}"
  sha256 "{aipager_sha}"
  license "MIT"

  depends_on "python@3.12"
  depends_on "dtach"

{resources}

  def install
    # Homebrew supplies dtach via the `dtach` formula dep; the bundled
    # `dtach-bin` PyPI package is therefore unneeded and has no sdist
    # available. Strip it from the dependency list before installing.
    inreplace "pyproject.toml", /\\s*"dtach-bin[^"]*",?\\n/, "\\n"

    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{{bin}}/aipager --version")
    assert_match "claude code", shell_output("#{{bin}}/aipager --help").downcase

    # dtach should resolve to Homebrew's, not the venv's
    dtach_path = Formula["dtach"].opt_bin/"dtach"
    assert_predicate dtach_path, :exist?

    # Import smoke: pulls in the modules whose deps the resource list must
    # supply (yaml, telegram, rich, questionary, …). Catches a missing
    # `resource` block at brew-test time instead of at runtime on a user's
    # machine.
    system libexec/"bin/python", "-c",
      "import aipager.cli, aipager.config, aipager.policy, aipager.bot.notify"
  end
end
"""


def main(argv: list[str]) -> int:
    version = argv[1] if len(argv) > 1 else _pypi("aipager")["info"]["version"]
    meta = _pypi("aipager", version)
    aipager_url, aipager_sha = _sdist("aipager", version)

    direct = _direct_runtime_deps(meta)
    tree = _resolve_tree(direct)
    # Drop self if pip resolved it in (it shouldn't, but be safe).
    tree.pop("aipager", None)

    blocks: list[str] = []
    for name in sorted(tree, key=str.lower):
        ver = tree[name]
        url, sha = _sdist(name, ver)
        # PyPI canonicalises distribution names with hyphens; pip's report
        # surfaces them with underscores. Brew convention is hyphens.
        canonical = name.lower().replace("_", "-")
        blocks.append(
            f'  resource "{canonical}" do\n'
            f'    url "{url}"\n'
            f'    sha256 "{sha}"\n'
            f'  end'
        )
    sys.stdout.write(_TEMPLATE.format(
        aipager_url=aipager_url,
        aipager_sha=aipager_sha,
        resources="\n\n".join(blocks),
    ))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
