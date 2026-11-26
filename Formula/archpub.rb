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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.20.0/archpub-0.20.0-macos-arm64.tar.gz"
      sha256 "59f2755fe47cdef53ba5b69bdedfb00f09fedfe1ca7157af15567db90066e5c6"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.20.0/archpub-0.20.0-macos-arm64.tar.gz"
      sha256 "59f2755fe47cdef53ba5b69bdedfb00f09fedfe1ca7157af15567db90066e5c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.20.0/archpub-0.20.0-linux-arm64.tar.gz"
      sha256 "dc6033f2086d0dc889c7882dbf8bc2ddbe22ea6b2db8b98c1ac6dc685a223782"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.20.0/archpub-0.20.0-linux-x64.tar.gz"
      sha256 "13a7d2d646e8467c41bb51acef3a0217264ce0138be4051b39c9cfa5abcffe86"
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
