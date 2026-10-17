# Homebrew Tap for iLyrics and iLibrary

Homebrew formulae for [iLyrics](https://github.com/x96x64/ilyrics), a macOS command that renders lyrics videos reproducing the Lyrics screen of the Music app on iPhone and synchronizes plain lyrics to a recording on device.

<p align="center">
  <img src="https://raw.githubusercontent.com/x96x64/ilyrics/main/docs/media/demo.png" alt="Three full-width frames of a rendered Lyrics video: the first line filling while the playback controls are visible, the next line filling word by word, and the instrumental-gap indicator" width="720">
</p>

## iLibrary

iLibrary prepares music through a JSON catalog and adds albums to a local Apple Music library in a controlled order. Version 0.1.0 is experimental; start with copies and a separate test library.

```bash
brew install x96x64/tap/ilibrary
ilibrary --version
```

See the [iLibrary README](https://github.com/x96x64/ilibrary#readme), [command reference](https://github.com/x96x64/ilibrary/blob/main/docs/command-line-interface.md), and [recovery guidance](https://github.com/x96x64/ilibrary/blob/main/docs/library-operations.md). The formula requires macOS 14 or later on Apple silicon and Swift 6. It builds from the verified release source archive and does not install a background service.

Use `brew upgrade ilibrary` to update and `brew uninstall ilibrary` to remove the command. Removing the command does not undo file or Music changes; keep catalogs and addition journals needed for recovery. Do not untap this repository while another formula from it is still installed.

## iLyrics Installation

```bash
brew install x96x64/tap/ilyrics
```

This one command adds the tap and installs iLyrics. The alignment models are downloaded and installed on first use; to check the environment and install them in advance, run `ilyrics doctor` and `ilyrics models install`.

To install iLyrics from a [Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile) with `brew bundle`, add this line:

```ruby
brew "x96x64/tap/ilyrics"
```

## iLyrics Quick Start

```bash
ilyrics doctor
ilyrics render "Paper Skies.m4a" paper-skies.txt -o paper-skies.mp4
```

The first command checks the environment; the second renders a video from a recording and plain lyrics, one sung line per line. See [Usage](https://github.com/x96x64/ilyrics#usage) in the iLyrics README for every option.

## Formulae

| Formula | Description | Version |
| --- | --- | --- |
| [`ilibrary`](Formula/ilibrary.rb) | Catalog-driven music tagging and ordered import into Apple Music | 0.1.0 |
| [`ilyrics`](Formula/ilyrics.rb) | Lyrics videos of the iPhone Music Lyrics screen, with on-device synchronization | 1.3.1 |

## iLyrics Requirements

- macOS 14 or later on Apple silicon
- Swift 6, provided by Xcode 16 or the Command Line Tools 16 or later; the formula builds iLyrics from the tagged source

## Updating and Removing iLyrics

```bash
brew update
brew upgrade ilyrics
```

```bash
ilyrics models remove
brew uninstall ilyrics
brew untap x96x64/tap
```

Remove the alignment models before uninstalling; they are stored in `~/Library/Application Support/iLyrics/Models`, outside the Homebrew prefix.

## iLyrics Notes

- The formula installs the weightless model templates into `$(brew --prefix)/share/ilyrics/templates`. The alignment models themselves are downloaded from their publishers and rebuilt on first use; no model weights are distributed through Homebrew.
- The project was renamed from iLyric to iLyrics in version 0.2.0. `brew upgrade` migrates an installed `ilyric` formula to `ilyrics`; afterwards run `ilyrics models install` once, because the model cache moved.
- See the [iLyrics README](https://github.com/x96x64/ilyrics#readme) for usage, limitations, and the SF Symbols rights statement, and the [changelog](https://github.com/x96x64/ilyrics/blob/main/CHANGELOG.md) for what changed in each version.
- Report problems with iLyrics in the [iLyrics issue tracker](https://github.com/x96x64/ilyrics/issues), and problems specific to the formula in this repository's issues.

## License

The formulae in this repository are licensed under the [Apache License, Version 2.0](LICENSE), the license of iLyrics and iLibrary.
