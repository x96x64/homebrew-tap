# Homebrew Tap for iLyrics and iLibrary

This tap distributes two independent command-line tools for music on macOS. [iLyrics](https://github.com/x96x64/ilyrics) renders lyrics videos that reproduce the Lyrics screen of the Music app on iPhone and synchronizes plain lyrics to a recording on your Mac. [iLibrary](https://github.com/x96x64/ilibrary) prepares music files through a reviewed JSON catalog and adds them, album by album and in a chosen order, to a local Apple Music library.

Neither formula depends on the other, and you can install only the one you need. This README explains how to install, update, and remove the formulae and summarizes what each tool does and where its verification stops. The authoritative documentation of each product is in its own repository, linked under Documentation and Support.

```bash
brew install x96x64/tap/ilyrics
brew install x96x64/tap/ilibrary
```

## Formulae

| Formula | Command | Description | Version | Source |
| --- | --- | --- | --- | --- |
| [`ilyrics`](Formula/ilyrics.rb) | `ilyrics` | Lyrics videos of the iPhone Music Lyrics screen, with on-device synchronization | 1.3.2 | Tagged source archive |
| [`ilibrary`](Formula/ilibrary.rb) | `ilibrary` | Catalog-driven music tagging and ordered import into Apple Music | 1.0.2 | Verified release source archive |

Both formulae build their command from source on your Mac with Swift 6 and install no background service. Each formula declares Apple silicon and macOS 14 (Sonoma) or later, and each is licensed under the Apache License, Version 2.0.

## Features

The two tools share a platform and a distribution channel but not a purpose. The summaries below describe what each currently does, and the linked product documentation remains the authoritative description of every option and behavior.

### iLyrics

iLyrics turns a recording and its lyrics into a portrait video of the Lyrics screen of the Music app on iPhone. Plain lyrics are synchronized automatically, line by line and word by word; lyrics that already carry timing are rendered as supplied. Vocal separation and speech recognition run through Core ML on your Mac, and no network service is involved after the one-time model installation.

- **Automatic synchronization:** Plain text lyrics are aligned line by line and word by word against a separated vocal stem. English is supported; Japanese with `--language ja` is experimental. Lines without reliable timing are placed rather than aligned and are reported.
- **A faithful Lyrics screen:** Focus motion, word fill, instrumental-gap indicators, a scrolling title, an artwork-derived background, and controls that hide after playback starts follow reference recordings of the Music app on iPhone.
- **Supplied timing:** Supported subsets of TTML, LRC, and Enhanced LRC are rendered without automatic realignment.
- **Reviewable alignment:** `align` writes word-timed TTML and an optional JSON report, so that timing can be inspected and corrected before rendering.
- **Local models:** `ilyrics models` installs, reports, and removes the alignment models, which are downloaded from their publishers, verified, and rebuilt on your Mac.
- **Diagnostics:** `ilyrics doctor` shows the installed version and where it was installed from, checks each requirement, and gives a recovery step for each problem.

### iLibrary

iLibrary prepares downloaded music for a local Apple Music library. It works on files first and touches Music only in the final stages, and every mutating command offers `--dry-run`, lists its changes before making them, and checks its result afterwards. Begin with copies and keep independent backups of your library.

- **Verified import:** `import` converts FLAC, WAV, and AIFF downloads to Apple Lossless through AudioToolbox and verifies each output by decoded PCM equality. It copies iTunes Store M4A files without re-encoding and removes their purchase metadata. With `--delete-originals`, originals are moved to the Trash only after every output has been verified.
- **Catalog workflow:** `export` drafts an `ilibrary-catalog-1` JSON catalog from existing tags, and `prompt` prints it with authoring rules so that an AI agent or chat can complete it. `validate` checks the catalog and its correspondence with the files, and `apply` writes it to the files without re-encoding the audio, honoring the catalog's title rules.
- **Music-style names and dates:** `apply --rename` arranges files as `Album Artist/Album/NN Song.m4a`, or `D-NN Song.m4a` on multi-disc albums. `apply --timestamps` and `timestamps` set file and folder dates to release dates.
- **Ordered addition:** `add` moves each album into the Music media folder and adds it in place, in one of four orders: `release`, `artist`, `artist-desc`, or `artist-release`. Each album is added after the previous album's addition second has passed and been confirmed, so that the addition times are separated and Recently Added can show the intended order. It stops when the library already holds a matching track and resumes an interrupted run from its journal.
- **Checks and diagnostics:** `check` reports missing tags, duplicate tracks, and incorrect dates in files, and `check --library` compares the files with Music and reports every difference. `doctor` reports environment problems with a recovery step for each, without launching Music or reading its library.
- **Library rebuilding:** `rebuild prepare` inventories the selected files and every Music registration, verifies a backup on separate storage with a restoration test, and writes a private recovery record. `rebuild stage`, `clear`, `apply`, and `add` then move the files out of the media folder, remove exactly the recorded registrations, write the catalog to the files while Music is closed, and add the albums again in the recorded order, and `rebuild status` reports the progress.

## Requirements

Both formulae require macOS 14 or later on Apple silicon and a Swift 6 toolchain, because Homebrew builds each command from source. The toolchain comes from Xcode or from the Command Line Tools, and each formula stops with a message if Swift 6 is missing.

### iLyrics

- Swift 6, provided by Xcode 16 or the Command Line Tools 16 or later
- About 600 MB of disk space for the alignment models, and 8 GB of memory or more for complete songs
- Network access to download the alignment models on first use

### iLibrary

- Swift 6 or later, provided by Xcode or the Command Line Tools
- The Music app and Automation permission for the commands that use Music: `add`, `check --library`, and the rebuilding stages that read or change the library
- No Apple Music subscription or Apple Account for the file commands: `import`, `export`, `prompt`, `validate`, `apply`, `timestamps`, and `check` without `--library`

## Installation

Each formula is installed by name from this tap, and `brew` adds the tap automatically on the first installation. Installation compiles the command on your Mac, which takes some minutes and needs the Swift 6 toolchain described under Requirements.

### iLyrics

```bash
brew install x96x64/tap/ilyrics
```

This command adds the tap and installs `ilyrics`, together with the weightless model templates in `$(brew --prefix)/share/ilyrics/templates`. The first `render` or `align` of plain lyrics installs the alignment models automatically; to install them in advance, run `ilyrics models install`. Installation downloads about 460 MB from the publishers, verifies each file against a pinned SHA-256 digest, and rebuilds the models in `~/Library/Application Support/iLyrics/Models`, where they occupy about 590 MB. No model weights are distributed through Homebrew. The first Japanese alignment with `--language ja` adds a Japanese recognition model: about 1.3 GB downloaded and 1.2 GB installed.

### iLibrary

```bash
brew install x96x64/tap/ilibrary
```

This command adds the tap and installs `ilibrary`, built from the verified 1.0.2 release source archive. The formula installs the executable only; the catalog schema is built in and printed by `ilibrary schema`. iLibrary has no separate model or data installation step, and installation does not access Music. Run `ilibrary --version` to confirm the installation, then `ilibrary doctor`, which reports the installed Music version, the media folder, available capacity, and the stored Automation permission with a recovery step for each problem. `doctor` does not launch Music, request permission, or read library tracks.

### Installing with a Brewfile

To install with [`brew bundle`](https://docs.brew.sh/Brew-Bundle-and-Brewfile), add the line for each formula you need to your `Brewfile`:

```ruby
brew "x96x64/tap/ilyrics"
brew "x96x64/tap/ilibrary"
```

Both projects are also distributed through npm and PyPI. iLyrics is `ilyrics` on both registries. iLibrary is `@x96_64/ilibrary` on npm and `x96_64-ilibrary` on PyPI, because the plain name `ilibrary` on both registries belongs to other projects, as the [iLibrary README](https://github.com/x96x64/ilibrary#readme) states. Install each tool through one channel only, so that updating that channel updates the command you run.

## Quick Start

The sequences below show a first use of each tool. They are summaries, not a replacement for the product documentation, and they use placeholder file names that you replace with your own. Run each tool's `doctor` command first, because it reports a missing requirement before any work is done.

### iLyrics

Prepare an unprotected recording and a UTF-8 `lyrics.txt` with the lead lyrics in sung order, one sung line per line. Replace the example paths with your files.

```bash
# 1. Check the environment
ilyrics doctor

# 2. Optionally install the alignment models in advance
ilyrics models install

# 3. Render a video from the recording and plain lyrics
ilyrics render song.m4a lyrics.txt -o video.mp4
```

The result is a 1080 × 1920 H.264 video at 60 frames per second with AAC audio. To review timing first, run `ilyrics align song.m4a lyrics.txt -o lyrics.ttml --report report.json`, correct `lyrics.ttml` if necessary, and render it with `ilyrics render song.m4a lyrics.ttml -o video.mp4`. For a rendering check without a recording of your own, use the [supplied-timing example](https://github.com/x96x64/ilyrics/blob/main/docs/rendering-example.md).

### iLibrary

Begin with copies in a dedicated workspace. The following commands prepare files and do not change any Music library. Replace `./downloads` with the selected copies, and review each dry run before writing:

```bash
# 1. Check the environment
ilibrary doctor

# 2. Convert downloads and copy purchases into a staging folder
ilibrary import ./downloads -o ./staging --dry-run
ilibrary import ./downloads -o ./staging

# 3. Draft a catalog from the files' tags, then print the authoring prompt
ilibrary export ./staging -o catalog.json
ilibrary prompt catalog.json > prompt.md

# 4. Complete the catalog by hand or with an AI agent, then validate and preview
ilibrary validate catalog.json ./staging
ilibrary apply catalog.json ./staging --rename --timestamps --dry-run

# 5. Apply the catalog and inspect the files
ilibrary apply catalog.json ./staging --rename --timestamps
ilibrary check ./staging
```

The staged files then appear as `Album Artist/Album/NN Song.m4a`, with `D-NN Song.m4a` on multi-disc albums. Adding albums with `ilibrary add` changes a Music library and moves the selected files out of staging. Keep independent backups of the library, preview `ilibrary add ./staging --order release --dry-run`, and keep the staging folder and its journal.

## Usage

The synopses below list the commands of each tool at the versions the formulae currently install. Run `ilyrics help` or `ilibrary help` for the installed command's own usage text, which is the reference for the version you have.

### iLyrics

```
ilyrics render AUDIO LYRICS -o VIDEO.mp4 [options]
ilyrics align  AUDIO LYRICS -o LYRICS.ttml [options]
ilyrics models install | status | remove
ilyrics doctor
```

`render` produces a video; plain text lyrics are aligned first, and TTML and LRC lyrics are used as supplied. `align` stops after synchronization and writes word-timed TTML. The title, artist, and artwork are read from the audio file and can be overridden with `--title`, `--artist`, and `--artwork`. Exit status is 0 on success, 1 on a runtime failure, 2 on a usage error, and 128 plus the signal number when interrupted. See the [iLyrics command reference](https://github.com/x96x64/ilyrics/blob/main/docs/command-line-interface.md) for every option.

### iLibrary

```
ilibrary export PATH... -o CATALOG.json [--artwork DIR] [--strict] [--dry-run]
ilibrary prompt CATALOG.json
ilibrary schema
ilibrary validate CATALOG.json [PATH...]
ilibrary apply CATALOG.json PATH... [--dry-run] [--rename] [--timestamps]
ilibrary import SOURCE... -o DIR [--from mora|itunes|auto] [--delete-originals] [--dry-run]
ilibrary add PATH... [--order release|artist|artist-desc|artist-release] [--dry-run]
ilibrary rebuild prepare CATALOG.json SOURCE --workspace DIR --backup DIR --restore-test DIR --staging DIR [--dry-run]
ilibrary rebuild stage|clear --workspace DIR [--dry-run]
ilibrary rebuild apply|add --workspace DIR [--timestamps] [--dry-run]
ilibrary rebuild status --workspace DIR
ilibrary timestamps CATALOG.json PATH... [--dry-run] [--script FILE]
ilibrary check [PATH...] [--library]
ilibrary doctor
```

Every mutating command offers `--dry-run`, states what it will change before changing it, and verifies its result afterwards. `export --strict` refuses, without writing, an export that is not a complete inventory. The `rebuild` stages run in the order `prepare`, `stage`, `clear`, `apply`, and `add`, each refusing to run out of order. Exit status is 0 on success, 1 on a failure or a finding from `check` or `doctor`, and 2 on a usage error. See the [iLibrary command reference](https://github.com/x96x64/ilibrary/blob/main/docs/command-line-interface.md) for every option and [Catalogs](https://github.com/x96x64/ilibrary/blob/main/docs/catalogs.md) for the catalog format and title rules.

## Updating

```bash
brew update
brew upgrade ilyrics     # iLyrics
brew upgrade ilibrary    # iLibrary
```

### iLyrics

Only the latest release receives fixes. `brew upgrade ilyrics` rebuilds the command from the new tagged source archive, which needs the same Swift 6 toolchain as installation, and `ilyrics doctor` shows the installed version and the command that updates it. The installed models remain valid across updates unless the [changelog](https://github.com/x96x64/ilyrics/blob/main/CHANGELOG.md) states otherwise.

### iLibrary

Before adopting a new version, read the [changelog](https://github.com/x96x64/ilibrary/blob/main/CHANGELOG.md) and the [roadmap](https://github.com/x96x64/ilibrary/blob/main/docs/roadmap.md). Updating replaces the executable only; catalogs, staging folders, and addition journals remain unchanged. If an `add` run was interrupted, keep its staging folder and journal and read the [recovery guidance](https://github.com/x96x64/ilibrary/blob/main/docs/library-operations.md#interrupted-addition) before resuming.

## Uninstalling

Removing a formula removes the command and nothing else that the tool created. Follow the steps for each tool you installed, and untap the repository last. Files that you created with the tools, such as videos, catalogs, and converted albums, are your own and are never deleted by uninstalling.

### iLyrics

The alignment models are stored outside the Homebrew prefix. Remove them first, then uninstall the formula:

```bash
ilyrics models remove
brew uninstall ilyrics
```

`ilyrics models status` shows the model location, `~/Library/Application Support/iLyrics/Models` by default, and its state. Rendered videos, lyrics, and reports remain where you saved them.

### iLibrary

```bash
brew uninstall ilibrary
```

Uninstalling removes only the command; iLibrary installs no models and runs no background service. Uninstalling does not undo file or Music changes. Catalogs, artwork, staging folders, and `.ilibrary-add.json` journals remain; keep them until their recovery purpose is complete.

### Removing the Tap

Untap this repository only after uninstalling every formula from it. While either `ilyrics` or `ilibrary` remains installed, keep the tap so that the remaining formula can still be updated.

```bash
brew untap x96x64/tap
```

## Troubleshooting

Run `ilyrics doctor` or `ilibrary doctor` first; each reports the problems it finds with a recovery step. The tables below list the failures that occur most often during installation and first use, with the next step for each. If a failure persists, include the output of `brew config` and of the tool's `doctor` command in a report, after removing personal paths.

### iLyrics

| Symptom | Next Step |
| --- | --- |
| The build stops because Swift 6 is missing | Install Xcode 16 or the Command Line Tools 16 or later, then run `brew install x96x64/tap/ilyrics` again. |
| `model download failed` | Check the network connection and run `ilyrics models install` again; verified downloads are reused. |
| `model templates were not found` | Run the installed command, or set `ILYRICS_TEMPLATES` to the directory of the model templates. |
| `line N of FILE contains "…"` | Write the number or symbol as it is sung, or remove it. For Japanese lyrics, add `--language ja`. |
| `Protected audio is unsupported` | Use a file without DRM; streamed Apple Music downloads cannot be read. |
| `... already exists` | Choose another output, or pass `--force` to replace it. |

### iLibrary

| Symptom | Next Step |
| --- | --- |
| The build stops because Swift 6 is missing | Install Xcode or the Command Line Tools with Swift 6 or later, then run `brew install x96x64/tap/ilibrary` again. |
| Music cannot be controlled | Run `ilibrary doctor` and follow its Automation permission instructions. |
| A matching track already exists | Stop and inspect the duplicate. iLibrary never removes the existing entry automatically. |
| A run stopped while adding an album | Keep the staging folder and journal, and preview the same `add` command before resuming; see the [recovery guidance](https://github.com/x96x64/ilibrary/blob/main/docs/library-operations.md#interrupted-addition). |
| A catalog does not match every file | Run `validate` with the selected paths and correct the catalog or the selection before applying. |
| `check --library` reports differences | Review them; `check` does not refresh, relink, rename, or delete Music entries. |
| Space is insufficient or a destination exists | Free space or choose a new destination. Do not delete an unverified original to make the command succeed. |

## Limitations

The limits below are summaries. Each product README states them in full, with the measurements and reports behind them, and a statement that a behavior was not measured means that it is unknown and not that it works.

### iLyrics

- Automatic synchronization supports English and may require manual correction. Japanese synchronization with `--language ja` is experimental, and other languages are not supported.
- Backing choruses are experimental, unverified, and unsupported; exclude them from `lyrics.txt`.
- Rendering targets the iPhone portrait screen at 1080 × 1920 and 60 frames per second. Known visual differences from the Music app are listed in the iLyrics README; translations, the Sing mode, and landscape layouts are not rendered.
- Control icons are SF Symbols resolved from your Mac at render time. Apple's license does not expressly permit their use in exported videos, so you are responsible for how you publish the videos you create.

### iLibrary

- File processing is verified with synthetic files, and Music operations are tested with a substitute library. The forms of the requests that iLibrary sends to Music were measured on macOS 27.0.1 with Music 1.7. Behavior with iCloud Music Library and on other macOS and Music versions is unknown.
- The rebuilding stages are tested with a substitute library and have not been run against the Music application. `rebuild prepare` was exercised once on a synthetic library of 12 tracks with one external HFS+ backup drive; a successful run shows only that the checks it reports passed at that time, and it does not guarantee that a library or backup medium can be recovered. Keep independent backups.
- The expected order in Recently Added is judged from the addition times that Music exposes, which were measured to be separated and increasing, and not by observing the display. An empty library after `rebuild clear` means that Music reports no tracks.
- Albums added to a library with iCloud Music Library may be matched with albums in the Apple Music catalog. iLibrary removes store identifiers and reports the cloud statuses that Music exposes; it does not claim to prevent cloud matching, and the effect on matching has not been measured.
- Conversion supports mono and stereo only and refuses floating-point PCM; FLAC fields outside the standard set are not carried. Catalogs are exported from `.m4a` files only.
- Mutating batches are not transactions: a later failure can leave earlier files or albums completed. Keep backups and the addition journal.
- Protected audio (`.m4p`) is out of scope, and iLibrary does not download audio.

Neither project is affiliated with, endorsed by, or sponsored by Apple.

## Documentation and Support

The product documentation lives in the two source repositories, and problems with a product belong in that product's issue tracker. Problems with installing or building through Homebrew belong in this repository's issues.

### iLyrics

- [README](https://github.com/x96x64/ilyrics#readme): features, usage, lyrics input, limitations, and rights
- [Command-Line Interface](https://github.com/x96x64/ilyrics/blob/main/docs/command-line-interface.md) and [Lyrics Input Formats](https://github.com/x96x64/ilyrics/blob/main/docs/input-formats.md)
- [Reviewing and Correcting an Alignment](https://github.com/x96x64/ilyrics/blob/main/docs/reviewing-alignment.md) and [Rendering a Supplied-Timing Example](https://github.com/x96x64/ilyrics/blob/main/docs/rendering-example.md)
- [Changelog](https://github.com/x96x64/ilyrics/blob/main/CHANGELOG.md): changes in each version
- [Support](https://github.com/x96x64/ilyrics/blob/main/SUPPORT.md) and the [issue tracker](https://github.com/x96x64/ilyrics/issues)

### iLibrary

- [README](https://github.com/x96x64/ilibrary#readme): features, installation channels, rebuilding, Apple Music and cloud matching, and limitations
- [Command-Line Interface](https://github.com/x96x64/ilibrary/blob/main/docs/command-line-interface.md) and [Catalogs](https://github.com/x96x64/ilibrary/blob/main/docs/catalogs.md): the catalog format, title rules, and authoring with AI agents
- [Library Operations and Recovery](https://github.com/x96x64/ilibrary/blob/main/docs/library-operations.md): dry runs, interrupted runs, rebuilding, and measured Music behavior
- [Changelog](https://github.com/x96x64/ilibrary/blob/main/CHANGELOG.md) and [Roadmap](https://github.com/x96x64/ilibrary/blob/main/docs/roadmap.md): changes and verification limits
- [Security Policy](https://github.com/x96x64/ilibrary/blob/main/SECURITY.md) and the [issue tracker](https://github.com/x96x64/ilibrary/issues)

Report problems specific to a formula, such as a failed build or a stale checksum, in this repository's [issues](https://github.com/x96x64/homebrew-tap/issues).

## License

The formulae in this repository, iLyrics, and iLibrary are each licensed under the [Apache License, Version 2.0](LICENSE), and so is the software that the formulae build. The license permits you to use, modify, and redistribute the software, including in modified form, provided that you give recipients a copy of the license, retain the copyright, patent, and attribution notices, and mark the files you changed. The software is provided "as is", without warranty of any kind, and the license limits the liability of its authors; the license text itself is the binding statement of these terms.

The Apache License covers the source code, documentation, and executables of these projects. It does not grant rights in the material that the tools process or refer to: music recordings, lyrics, artwork, and images remain subject to the terms of their rights holders, and you are responsible for holding the rights to what you convert, tag, add to a library, or render into a video. Apple, Apple Music, Music, and macOS are trademarks of Apple Inc., and nothing in the license permits their use; the SF Symbols that iLyrics resolves from your Mac at render time are likewise governed by Apple's own license.

The alignment models that iLyrics downloads are not part of this tap and remain under their publishers' licenses. Homebrew itself and the Swift toolchain are separate software under their own terms. This section summarizes the licensing for convenience and is not legal advice; consult the license text and, where your use depends on it, a qualified adviser.
