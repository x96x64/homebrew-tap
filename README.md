# iLyrics Homebrew Tap

Homebrew formulae for [iLyrics](https://github.com/x96x64/ilyrics), a macOS command that renders lyrics videos reproducing the Lyrics screen of the Music app on iPhone and synchronizes plain lyrics to a recording on device.

## Installation

```bash
brew install x96x64/tap/ilyrics
```

This one command adds the tap and installs iLyrics. The alignment models are downloaded and installed on first use; to check the environment and install them in advance, run `ilyric doctor` and `ilyric models install`.

## Formulae

| Formula | Description | Version |
| --- | --- | --- |
| [`ilyrics`](Formula/ilyrics.rb) | Lyrics videos of the iPhone Music Lyrics screen, with on-device synchronization | 1.0.0 |

## Requirements

- macOS 14 or later on Apple silicon
- The Xcode Command Line Tools or Xcode, which provide the Swift toolchain; the formula builds iLyrics from the tagged source

## Updating and Removing

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

## Notes

- The formula installs the weightless model templates into `$(brew --prefix)/share/ilyrics/templates`. The alignment models themselves are downloaded from their publishers and rebuilt on first use; no model weights are distributed through Homebrew.
- The project was renamed from iLyric to iLyrics in version 0.2.0. `brew upgrade` migrates an installed `ilyric` formula to `ilyrics`; afterwards run `ilyrics models install` once, because the model cache moved.
- iLyrics is a public preview. See the [README](https://github.com/x96x64/ilyrics#readme) for usage, limitations, and the SF Symbols rights statement.
- Report problems with iLyrics in the [iLyrics issue tracker](https://github.com/x96x64/ilyrics/issues), and problems specific to the formula in this repository's issues.

## License

The formulae in this repository are licensed under the [Apache License, Version 2.0](LICENSE), the license of iLyrics.
