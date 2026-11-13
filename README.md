# Homebrew Tap

Homebrew distribution for verified [HengYangDS](https://github.com/HengYangDS)
release artifacts.

## AIGW

Install AIGW with one fully qualified command:

```sh
brew install --cask HengYangDS/tap/aigw
```

Upgrade or remove the package through Homebrew:

```sh
brew upgrade --cask HengYangDS/tap/aigw
brew uninstall --cask HengYangDS/tap/aigw
```

Before removal, disable each enabled AIGW client adapter. Configuration and
credentials remain available for a later reinstall. See the
[AIGW project](https://github.com/HengYangDS/aigw-cli) for setup, verification,
and portable installation.

Recipes are generated from the corresponding release inventory. Versions,
architecture-specific download URLs and SHA-256 checksums must match published
artifacts; this repository does not rebuild or re-sign executables.

## Architecture Publisher

Install `archpub` with one fully qualified command:

```sh
brew install HengYangDS/tap/archpub
```

Upgrade or remove the package through Homebrew:

```sh
brew upgrade HengYangDS/tap/archpub
brew uninstall HengYangDS/tap/archpub
```

The formula installs the release archive for your machine: macOS on ARM64, or
Linux on ARM64 or x86-64. Homebrew refuses it on an Intel Mac, because no
release holds an archive for one. The archive carries its own Node.js and
Typst, so `archpub` needs only Git. Nothing is compiled, but the formula has no
bottle, so Homebrew asks for its usual developer tools before it installs: the
Xcode Command Line Tools on macOS, or a C compiler on Linux.

The formula's version, download URLs and SHA-256 checksums are those of the
release's `SHA256SUMS`; this repository does not rebuild or re-sign the archive.
See the
[Architecture Publisher project](https://github.com/HengYangDS/architecture-publisher)
for its other install channels and a first work.
