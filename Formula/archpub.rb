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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.16.0/archpub-0.16.0-macos-arm64.tar.gz"
      sha256 "189f53248053338ebefd79d6074a07cf638840065b0636f93d5f9df7d015b141"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.16.0/archpub-0.16.0-macos-arm64.tar.gz"
      sha256 "189f53248053338ebefd79d6074a07cf638840065b0636f93d5f9df7d015b141"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.16.0/archpub-0.16.0-linux-arm64.tar.gz"
      sha256 "9f77bf798a1078073a52b3d1b95992d2579bbcac692bceb26ed82c8c43c8294d"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.16.0/archpub-0.16.0-linux-x64.tar.gz"
      sha256 "aa26db0553b3b72b7c1ed99f27d6cd793223aacd7496c08a7dda3e9137de819b"
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
