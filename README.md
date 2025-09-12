# mokey-alert.nvim

[![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-blue.svg)](https://github.com/dqnid/monkey-alert.nvim/releases)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-yellow.svg)](https://www.wtfpl.net/about/)

Git line blame by mail.

## 🔧 Options

- `blame_text_color_hex`: hex color to use as foreground.
- `monkey_mail_list`: list of github account emails separated by a single comma ",".
- `blame_text`: string with the text that will appear on the blame.
- `blame_position`: 'eol' or 'overlay' or 'right_align'.
- `auto_attach`: whether or not create an autocmd to blame the current line automatically.

## 🐾 Usage

### 💤 Lazyvim

```lua
{
    "dqnid/monkey-alert.nvim",
    name = "monkey-alert",
    opts = {
        monkey_mail_list = "john@doe.org,another@dude.me",
        blame_text_color_hex = "#c0ffee",
        blame_text = "- Monkey alert 🐒",
        blame_position = "eol",
        auto_attach = false
    },
},
```

## 🎬 Example

<img width="715" height="291" alt="monkey-alert" src="https://github.com/user-attachments/assets/f979954e-53b7-473b-a55e-7b8c722825e7" />

## 🚨 Known issues

- [ ] Error on non-git files.
