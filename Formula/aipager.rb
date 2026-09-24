class Aipager < Formula
  include Language::Python::Virtualenv

  desc "Telegram remote-control daemon for Claude Code CLI sessions"
  homepage "https://github.com/dev-aly3n/aipager"
  url "https://files.pythonhosted.org/packages/8b/da/93367951fe9a71fc4b746f455ce1fcba46df76d83160d3308d15272c9389/aipager-0.7.15.tar.gz"
  sha256 "87852f0ff9ba150c162054f86ea081cb4ccab3a57bb7d345fd475ec65984e2ee"
  license "MIT"

  depends_on "python@3.12"
  depends_on "dtach"

  resource "aiohappyeyeballs" do
    url "https://files.pythonhosted.org/packages/ce/f4/eec0465c2f67b2664688d0240b3212d5196fd89e741df67ddb81f8d35658/aiohappyeyeballs-2.7.1.tar.gz"
    sha256 "065665c041c42a5938ed220bdcd7230f22527fbec085e1853d2402c8a3615d9d"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/58/d9/22ce5786ac0c1653ae8b6c23bded02c1686d11f0dbb45b31ce128e0df985/aiohttp-3.14.3.tar.gz"
    sha256 "9491196535a88924a60afd5b5f434b5b203b6cc616250878dbdb223a8f7844bc"
  end

  resource "aiolimiter" do
    url "https://files.pythonhosted.org/packages/f1/23/b52debf471f7a1e42e362d959a3982bdcb4fe13a5d46e63d28868807a79c/aiolimiter-1.2.1.tar.gz"
    sha256 "e02a37ea1a855d9e832252a105420ad4d15011505512a1a1d814647451b5cca9"
  end

  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/61/62/06741b579156360248d1ec624842ad0edf697050bbaf7c3e46394e106ad1/aiosignal-1.4.0.tar.gz"
    sha256 "f47eecd9468083c2029cc99945502cb7708b082c232f9aca65da147157b251c7"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/a9/d2/f4d173e22df740bc37b1db102b386ba719b66e95b0f0d751f556b387e6d2/anyio-4.15.1.tar.gz"
    sha256 "9f28306018cbd6d329e64a36d58256edff76dd996fe423bc957326e578b82a94"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/9a/8e/82a0fe20a541c03148528be8cac2408564a6c9a0cc7e9171802bc1d26985/attrs-26.1.0.tar.gz"
    sha256 "d03ceb89cb322a8fd706d4fb91940737b6642aa36998fe130a9bc96c985eff32"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a3/c2/24167ea9858356b47a87a50d39908bfdb72ceeefe0041586e704e5376b3a/certifi-2026.7.22.tar.gz"
    sha256 "741e2c3b351ddf169a738da9f2c048608ff7f2c5cc02f1ebc6b118bb090d5d55"
  end

  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/2d/f5/c831fac6cc817d26fd54c7eaccd04ef7e0288806943f7cc5bbf69f3ac1f0/frozenlist-1.8.0.tar.gz"
    sha256 "3ede829ed8d842f6cd48fc7081d7a41001a56f1f38603f9d49bf3020d59a31ad"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/d6/99/1d4d69c3512d0ddbfa3a1b69cfd9a151012ab2eb4eabbb096201b1f0b7d8/multidict-6.9.1.tar.gz"
    sha256 "0f06e60fa190aa7abd0914c2a766736fdc8e9f34878c4346338534b73d1b20e2"
  end

  resource "prompt-toolkit" do
    url "https://files.pythonhosted.org/packages/7d/ea/39b988c938f75cb75d7045b5c69f8bfed47ee2152c8837fb403de29d6fb8/prompt_toolkit-3.0.53.tar.gz"
    sha256 "9ec8a0ad96d5c56148b3f914aa79c1564c3fde5d2e6b876e7bc327e353cf8fa6"
  end

  resource "propcache" do
    url "https://files.pythonhosted.org/packages/b3/9a/9fbf4e4ec0c2d7f1c32519fff782ef467859b8faa9fbc5331a96f6395d43/propcache-0.5.4.tar.gz"
    sha256 "ff6b113f50bc066a698db5d944d2c6dc7507168dd3341e255a8892fd0715a558"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "python-telegram-bot" do
    url "https://files.pythonhosted.org/packages/ba/77/153517bb1ac1bba670c6fb1dbf09e1fd0730494b1705934e715391413a0d/python_telegram_bot-22.8.tar.gz"
    sha256 "f9d3847fcb23ee603477e442800b33bb4adf851a73e0619d2050be879decf1ef"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "questionary" do
    url "https://files.pythonhosted.org/packages/f6/45/eafb0bba0f9988f6a2520f9ca2df2c82ddfa8d67c95d6625452e97b204a5/questionary-2.1.1.tar.gz"
    sha256 "3d7e980292bb0107abaa79c68dd3eee3c561b83a0f89ae482860b181c8bd412d"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/dc/ac/3a943d2792c9bb368aaa8b50121c0f778460ba2d7fbdc0a0366201d9e761/wcwidth-0.9.1.tar.gz"
    sha256 "5823209b0d43af322ce698c689380d7c15ca31fa8e6e3be8459f27031bef0af5"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/75/16/e8be8e2fb175bbf41a0680381a319f1199fae256588241a2ac8677eafb49/yarl-1.25.1.tar.gz"
    sha256 "03dd38de09bc213e9a8b29761eec33ee1d5318dac0e49d8af36e4d27830e23a7"
  end

  def install
    # Homebrew supplies dtach via the `dtach` formula dep; the bundled
    # `dtach-bin` PyPI package is therefore unneeded and has no sdist
    # available. Strip it from the dependency list before installing.
    inreplace "pyproject.toml", /\s*"dtach-bin[^"]*",?\n/, "\n"

    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aipager --version")
    assert_match "claude code", shell_output("#{bin}/aipager --help").downcase

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
