# Homebrew Tap

Homebrew distribution for verified [HengYangDS](https://github.com/HengYangDS)
release artifacts.

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
