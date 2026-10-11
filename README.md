# x96x64 Homebrew Tap

Homebrew formulae for [iLyric](https://github.com/x96x64/ilyric), a macOS command that renders lyrics videos reproducing the Lyrics screen of the Music app on iPhone and synchronizes plain lyrics to a recording on device.

## Installation

```bash
brew install x96x64/tap/ilyric
```

The shorthand taps this repository automatically. Equivalently:

```bash
brew tap x96x64/tap
brew install ilyric
```

Then check the environment and install the alignment models:

```bash
ilyric doctor
ilyric models install
```

## Formulae

| Formula | Description | Version |
| --- | --- | --- |
| [`ilyric`](Formula/ilyric.rb) | Lyrics videos of the iPhone Music Lyrics screen, with on-device synchronization | 0.1.0 |

## Requirements

- macOS 14 or later on Apple silicon
- The Xcode Command Line Tools or Xcode, which provide the Swift toolchain; the formula builds iLyric from the tagged source

## Updating and Removing

```bash
brew update
brew upgrade ilyric
```

```bash
ilyric models remove
brew uninstall ilyric
brew untap x96x64/tap
```

Remove the alignment models before uninstalling; they are stored in `~/Library/Application Support/iLyric/Models`, outside the Homebrew prefix.

## Notes

- The formula installs the weightless model templates into `$(brew --prefix)/share/ilyric/templates`. The alignment models themselves are downloaded from their publishers and rebuilt on first use; no model weights are distributed through Homebrew.
- iLyric is an experimental release. See the [README](https://github.com/x96x64/ilyric#readme) for usage, limitations, and the SF Symbols rights statement.
- Report problems with iLyric in the [iLyric issue tracker](https://github.com/x96x64/ilyric/issues), and problems specific to the formula in this repository's issues.

## License

The formulae in this repository are licensed under the [Apache License, Version 2.0](LICENSE), the license of iLyric.
