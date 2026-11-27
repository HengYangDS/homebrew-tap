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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.21.0/archpub-0.21.0-macos-arm64.tar.gz"
      sha256 "2c395ee2ceaed77a2d1a83743d33ba4123cc229f12457ad73d98f39c55cb3ea0"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.21.0/archpub-0.21.0-macos-arm64.tar.gz"
      sha256 "2c395ee2ceaed77a2d1a83743d33ba4123cc229f12457ad73d98f39c55cb3ea0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.21.0/archpub-0.21.0-linux-arm64.tar.gz"
      sha256 "844b55da9920ceacbdf3b7b4f76cc61fcea0bce4f123e43e753f9640860ab5ee"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.21.0/archpub-0.21.0-linux-x64.tar.gz"
      sha256 "1231332b70bb95cf268e54c733f8defb1937f83ebfaa1389232ec360c3cfe8cc"
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
