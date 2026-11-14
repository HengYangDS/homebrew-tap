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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.14.0/archpub-0.14.0-macos-arm64.tar.gz"
      sha256 "b3b0f9abd9ceb90246226b5b4a51663ca049771bbea37039c8963c2eef47812f"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.14.0/archpub-0.14.0-macos-arm64.tar.gz"
      sha256 "b3b0f9abd9ceb90246226b5b4a51663ca049771bbea37039c8963c2eef47812f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.14.0/archpub-0.14.0-linux-arm64.tar.gz"
      sha256 "5e28c2af71eb7e7fb2b9b2115ce17452b64344121b2f5552c0690c89ef7f3340"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.14.0/archpub-0.14.0-linux-x64.tar.gz"
      sha256 "1dc12ad29933eb781de74141c17ff29544d8a11648654172e3c1a9be09c8b16d"
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
