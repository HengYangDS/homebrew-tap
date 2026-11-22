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
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.17.0/archpub-0.17.0-macos-arm64.tar.gz"
      sha256 "d5f195b7c87f325f08c459d9f95af711d3586603e2e469a3e101a4c2bcded5ae"
    end
    on_intel do
      # A formula must name a URL on every platform to load at all, so an
      # Intel Mac names the ARM64 archive that the requirement above refuses.
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.17.0/archpub-0.17.0-macos-arm64.tar.gz"
      sha256 "d5f195b7c87f325f08c459d9f95af711d3586603e2e469a3e101a4c2bcded5ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.17.0/archpub-0.17.0-linux-arm64.tar.gz"
      sha256 "1b32816aee1dd0a73e1d659170016c5dae375937ed918f1c146b8946be7166e3"
    end
    on_intel do
      url "https://github.com/HengYangDS/architecture-publisher/releases/download/v0.17.0/archpub-0.17.0-linux-x64.tar.gz"
      sha256 "102533f17680cbee986e82dc9a466173a4f6c9fe108a7ee4fc10f1afdb1a43e7"
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
