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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.13.1/archpub-0.13.1-macos-arm64.tar.gz"
      sha256 "4d0a612d03ebf931b6db9d821cc78660e4d792dcf1b0985b00c244851441f669"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.13.1/archpub-0.13.1-macos-arm64.tar.gz"
      sha256 "4d0a612d03ebf931b6db9d821cc78660e4d792dcf1b0985b00c244851441f669"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.13.1/archpub-0.13.1-linux-arm64.tar.gz"
      sha256 "23973fef25bc65a56225ccb49bcc07fb1cbc16c97303715ba1c928d3b06465b0"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.13.1/archpub-0.13.1-linux-x64.tar.gz"
      sha256 "f328161a1b193e584785841a310abf73f1b0e3c395fbccaa5e96d020b5927086"
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
