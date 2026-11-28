class Archpub < Formula
  desc "Turns a model of a repository's architecture into a print edition and a page"
  homepage "https://github.com/HengYangDS/architecture-publisher"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    # The release holds no Intel macOS archive, and this requirement refuses
    # an Intel Mac before anything is downloaded.
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.22.0/archpub-0.22.0-macos-arm64.tar.gz"
      sha256 "85200cd02e6228850fd923a2c56b5811b7f94f5e91c6b616cc2d62b58c369beb"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.22.0/archpub-0.22.0-macos-arm64.tar.gz"
      sha256 "85200cd02e6228850fd923a2c56b5811b7f94f5e91c6b616cc2d62b58c369beb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.22.0/archpub-0.22.0-linux-arm64.tar.gz"
      sha256 "f7858efc53484445ea0038da3c02c6dd28bbf59164edd098227e079224848cfa"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.22.0/archpub-0.22.0-linux-x64.tar.gz"
      sha256 "850cb884dd9a4d00ed35fa9a752c966e8b4fe298276fa380c04e2e7e1aadf967"
    end
  end

  def install
    # The archive is self-contained: bin/archpub resolves symlinks to find the
    # Node.js and Typst beside it, so the tree stays whole under libexec.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/archpub"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/archpub --version")
    assert_match "name: architecture-publisher", shell_output("#{bin}/archpub skill")
  end
end
