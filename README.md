<h1 align="center">Zellij Smart Sessionizer</h1>

<div align="center">
  <strong>Zellij sessionizer with layout selection capability</strong>
</div>

<div align="center">
    Instant Zellij session startup powered by Zoxide and fuzzy finder
</div>

[![zellij smart sessionizer demo](https://asciinema.org/a/617601.svg)](https://asciinema.org/a/617601)

## Table of Contents

-   [Key Features](#key-features)
-   [Installation](#installation)
-   [Usage](#usage)
-   [Usage inside Neovim](#usage-inside-neovim)
-   [Quick Tips](#quick-tips)
-   [Inspirations](#inspirations)

## Key Features

-   **Easy to use:** Run `zs` or `Ctrl+f` in your shell select your project from [`Zoxide`](https://github.com/ajeetdsouza/zoxide) list using [`fzf`](https://github.com/junegunn/fzf) or [`skim`](https://github.com/lotabout/skim), select preferable layout;
-   **Usage inside zellij session:** It will create a new tab with the selected layout;
-   **Attach to the session:** Will not ask for layout when the session was previously created;
-   **Layout config preview:** Layout config preview will be shown using [`bat`](https://github.com/sharkdp/bat) if installed or `cat` as a fallback

## Installation as a bash script **(the old way)**

You can use the steps from [Bash CLI Readme](./cli/README.md) to install it as a bash CLI command

## Installation

1. Install the dependencies

    - [Zoxide](https://github.com/ajeetdsouza/zoxide)
    - [bat](https://github.com/junegunn/fzf) - optional dependency

2. Install sessionizer using Cargo

```
cargo install zellij-smart-sessionizer --locked
```

3. Populate your `Zoxide` database by simply going into the directories that you want to start the session from. Check [`Zoxide`](https://github.com/ajeetdsouza/zoxide) docs for more info.

4. **(Optional)** Create an alias to call this script in your shells `.rs` config

```sh
bindkey -s ^f "zellij-smart-sessionizer^M"
```

## Usage

You just need to type this command in your shell to start a new session

```sh
zs
```

Or `Ctrl+f` if you've set up an optional keybinding step

Next will be provided different types of scenarios of the script execution.

### Outside of Zellij (session doesn't exist)

You will be offered paths from `Zoxide`. After selection, it will give you a layout selection for the session if your layout directory is not empty. It uses the `LAYOUT DIR` path provided to `Zellij` setup.

After that, it will open a session with a zoxide path's `basename` and selected layout.

### Outside of Zellij (session exists)

You will be offered paths from `Zoxide`. After selecting a path, the layout step will be skipped and you will be attached to `Zellij` session.

### Inside Zellij

If you run this script inside `Zellij` you will be offered the same selection steps. But after selection, it will open a new tab with the selected session `basename` and Layout

_Note_: Not all layouts will be provided in this case, It's kinda smart and will not provide layouts that contain `tabs` options inside it, because you cannot create tabs inside the tab.

## Usage inside Neovim

I like to have this keymap in my Neovim config to run sessionizer inside floating pane:

```lua
vim.keymap.set("n", "<C-f>", ":silent !zellij action new-pane -f -c -- zellij-smart-sessionizer<CR>", { silent = true })
```

By pressing `Ctrl+f` inside Neovim you will open floting window with sessionizer script

## Passing session name argument

Also, you can provide optional arguments to the script

```sh
zellij-smart-sessionizer session-name

# or

zs session-name
```

It will pick up this argument and will init session with this name instead of the path's `basename`. It's very useful if you want to have several different sessions that were initialized from the same directory

## Quick Tips

I was always strugling with removing directories from Zoxide DB, so I finally found the right solution and want to share it here :)

If you want to remove some paths from your `Zoxide` DB you can use this simple command:

```sh
zoxide remove $(zoxide query -l | fzf -m)
```

Select options that you want to remove by pressing `Tab` and they will be deleted from DB

## Inspirations

Special thanks to this repos:

-   [zellij-sessionizer](https://github.com/silicakes/zellij-sessionizer/tree/main)
-   [t](https://github.com/joshmedeski/t-smart-tmux-session-manager)

## License

[MIT](https://tldrlegal.com/license/mit-license)
