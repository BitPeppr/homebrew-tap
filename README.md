# BitPeppr's Homebrew tap

```sh
brew install BitPeppr/tap/pseudocopy
brew services start pseudocopy
```

## pseudocopy

Watches a folder, copies every new finished file to the macOS clipboard
(text, image, PDF or file reference) and moves files older than an hour to
the Trash. A launchd agent runs one cycle every five seconds.

The tap formula installs the universal release binary and runs it through
`brew services`; it watches `~/Temp`. See
[pseudocopy](https://github.com/BitPeppr/pseudocopy) for the manual, the
caveats and the source install (which supports any folder and TTL).
