# dev-aly3n/homebrew-tap

Homebrew formulas for [aipager](https://github.com/dev-aly3n/aipager) and
related projects.

## Install

```sh
brew install dev-aly3n/tap/aipager
```

Or tap first, then install whatever:

```sh
brew tap dev-aly3n/tap
brew install aipager
```

This installs `aipager` plus its Telegram bot dependency stack into an
isolated Homebrew Python venv, and pulls `dtach` from the standard
Homebrew formula. After install:

```sh
aipager config        # interactive setup wizard
aipager start         # run the daemon (foreground)
claude-dtach demo     # launch a Claude Code session under dtach
```

See the [aipager README](https://github.com/dev-aly3n/aipager) for the
full UX.

## Formulas

| Formula | Description |
|---|---|
| [`aipager`](Formula/aipager.rb) | Telegram remote-control daemon for Claude Code CLI sessions |

## Maintaining a formula

Bumping a formula to a new aipager release:

1. Get the new sdist URL + sha256 from PyPI (`curl -s https://pypi.org/pypi/aipager/X.Y.Z/json | jq -r '.urls[] \| select(.packagetype=="sdist") \| "\(.url) \(.digests.sha256)"'`)
2. Regenerate the resource stanzas if any Python dep tree changed: `pipx install homebrew-pypi-poet && poet -f aipager`
3. Update `Formula/aipager.rb` and commit.
4. (Optional) `brew install --build-from-source Formula/aipager.rb` to verify locally.

There is no PyPI account or Trusted Publisher to set up — Homebrew reads
this repo directly when users tap it.
