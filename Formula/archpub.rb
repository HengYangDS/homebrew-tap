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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.15.0/archpub-0.15.0-macos-arm64.tar.gz"
      sha256 "e00a0520209fbdc11dd70db675475564c9f2d607b5321a47277b8860ac72c498"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.15.0/archpub-0.15.0-macos-arm64.tar.gz"
      sha256 "e00a0520209fbdc11dd70db675475564c9f2d607b5321a47277b8860ac72c498"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.15.0/archpub-0.15.0-linux-arm64.tar.gz"
      sha256 "f08283f62c0406d33c7d05ed5d453779c37be8343eeb5d40be5ad1a806b81155"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.15.0/archpub-0.15.0-linux-x64.tar.gz"
      sha256 "ded2d12b98663218e4b457f2b228b51e3de5dd18d5db25a378aa1f02da3b07c4"
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
