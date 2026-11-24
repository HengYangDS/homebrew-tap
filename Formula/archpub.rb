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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.19.0/archpub-0.19.0-macos-arm64.tar.gz"
      sha256 "4b08b32e292c8c1e0e7f40afadb305ae34a942ee599533b4a64e1ba79d24f5a8"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.19.0/archpub-0.19.0-macos-arm64.tar.gz"
      sha256 "4b08b32e292c8c1e0e7f40afadb305ae34a942ee599533b4a64e1ba79d24f5a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.19.0/archpub-0.19.0-linux-arm64.tar.gz"
      sha256 "fdbb6a563aa989ff0a7620dfca3a0f1ea8a26896b910efc0671a5f00f580aa20"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.19.0/archpub-0.19.0-linux-x64.tar.gz"
      sha256 "dfb5618d8d6b99e3510e906aa8f805aecaafc3c7dd3fa9138c7b669e2021493a"
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
