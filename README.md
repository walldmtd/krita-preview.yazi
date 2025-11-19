# krita-preview.yazi

A [Yazi](https://github.com/sxyazi/yazi) plugin to preview Krita's .kra and
.kra~ files.

## Requirements

Either `unzip` or `7z` need to be installed and available in the PATH.

## Installation

```sh
ya pkg add walldmtd/krita-preview
```

## Usage

Add this to `yazi.toml`:

```toml
[plugin]
prepend_preloaders = [
    { name = "*.kra", run = "krita-preview" },
    { name = "*.kra~", run = "krita-preview" },
]
prepend_previewers = [
    { name = "*.kra", run = "krita-preview" },
    { name = "*.kra~", run = "krita-preview" },
]
```

## Acknowledgements

- [Yazi](https://github.com/sxyazi/yazi), for
[magick.lua](https://github.com/sxyazi/yazi/blob/main/yazi-plugin/preset/plugins/magick.lua)
(used as a base for this plugin)
