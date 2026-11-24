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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.18.0/archpub-0.18.0-macos-arm64.tar.gz"
      sha256 "de14e897e54472686b475ea52ebeac1a97dd9f7a4787457f99970c7b7fb9699e"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.18.0/archpub-0.18.0-macos-arm64.tar.gz"
      sha256 "de14e897e54472686b475ea52ebeac1a97dd9f7a4787457f99970c7b7fb9699e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.18.0/archpub-0.18.0-linux-arm64.tar.gz"
      sha256 "c847397d3b34ed19ddcb07969615db2db3b7a0feda38ffee7e449ecbe80f06e3"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.18.0/archpub-0.18.0-linux-x64.tar.gz"
      sha256 "6bff38fc82d4d3a3e0e161683f579c9a305f01bc0c0080fd7f7f8b4ac09d3550"
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
