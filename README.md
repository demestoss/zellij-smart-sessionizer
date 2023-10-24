<h1 align="center">Zellij SessionizerZ</h1>

<div align="center">
  <strong>Zellij sessionizer with layout selection capability</strong>
</div>

<div align="center">
    Instant Zellij session startup powered by Zoxide and fzf
</div>

## Table of Contents

- [Key Features](#key-features)
- [Installation](#installation)
- [Usage](#usage)
- [Inspirations](#inspirations)

## Key Features

- **Easy to use:** Run `zs` select your project from [`Zoxide`](https://github.com/ajeetdsouza/zoxide) list using [`fzf`](https://github.com/junegunn/fzf), select preferable layout;
- **Usage inside zellij session:** It will create a new tab with selected layout;
- **Attach to the session:** Will not ask for layout when the session was previously created;
- **Layout config preview:** Layout config preview will be shown using [`bat`](https://github.com/sharkdp/bat) if installed or `cat` as a fallback

## Installation

1. Install all dependencies

   - [Zoxide](https://github.com/ajeetdsouza/zoxide)
   - [fzf](https://github.com/junegunn/fzf)
   - [bat](https://github.com/junegunn/fzf) - optional dependency

2. Clone the repo

```
git clone https://github.com/demestoss/zellij-sessionizerz
cd zellij-sessionizerz
```

3. Place [zs](https://github.com/demestoss/zellij-sessionizerz/blob/master/zs) script in your `PATH`. One of the ways:

```
sudo chmod +x ./zs
sudo ln -s $(echo "$(pwd)/zs") /usr/bin/zs
```

3. Populate your `Zoxide` database by simply going into directories that you want to start session from.

### Quick tip

If you want to remove some paths from your `Zoxide` DB you can use this simple command:

```sh
zoxide remove $(zoxide query -l | fzf -m)
```

Select options that you want to remove by pression `Tab` and they will be deleted from DB

4. (Optional) Create an alias to call this script in your shells `.rs` config

```sh
bindkey -s ^f "zs"
```

## Usage

You just need to type this command in your shell to start a new session

```sh
zs
```

Or `^f` if you've setted up optional keybinding step

Next will be provided different types of scenatios of the script execution.

### Outside of Zellij (session doesn't exists)

You will be offered with paths from `Zoxide`. After selection it will give you a layout selection for the session if your layout directory is not empty. It uses `LAYOUT DIR` path that is provided to `Zellij` setup.

After that it will open session with a zoxide path's `basename` and selected layout.

### Outside of Zellij (session exists)

You will be offered with paths from `Zoxide`. After seleting the layout step will be skipped and you will be attached to `Zellij` session.

### Inside Zellij

If you run this script inside `Zellij` you will be offered with the same selection steps. But after selection it will open new tab with the selected session `basename` and Layout

_Feature_: Not all layouts will be provided in this case, It's kinda smart and will not provide layouts that contains `tabs` options inside it, because you cannot create tabs inside tab.

### Passing session name argument

Also you can provide optional argument to the script

```sh
zs some-name
```

It will pick up this argument and will init session with this name instead of path's `basename`. It's very usefull if you want to have several different sessions that was initialized from the same directory

## Inspirations

Special thanks to this repos:

- [zellij-sessionizer](https://github.com/silicakes/zellij-sessionizer/tree/main)
- [tmux-session-wizard](https://github.com/27medkamal/tmux-session-wizard)

## License

[MIT](https://tldrlegal.com/license/mit-license)
