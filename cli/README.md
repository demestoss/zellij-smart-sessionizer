<h1 align="center">Zellij Smart Sessionizer CLI</h1>

<div align="center">
    This is bash script that works almost the same way. You can use it instead of installing sessionizer via Cargo
</div>

## Table of Contents

-   [Installation](#installation)
-   [Usage](#usage)

## Installation

1. Install all dependencies

    - [Zoxide](https://github.com/ajeetdsouza/zoxide)
    - [skim](https://github.com/lotabout/skim) or [fzf](https://github.com/junegunn/fzf) - fuzzy finders, `skim` has higher priority
    - [bat](https://github.com/junegunn/fzf) - optional dependency

2. Clone the repo

```
git clone https://github.com/demestoss/zellij-smart-sessionizer
cd zellij-smart-sessionizer
```

3. Place [zellij-smart-sessionizer](https://github.com/demestoss/zellij-smart-sessionizer/blob/master/zellij-smart-sessionizer) script in your `PATH`. One of the ways:

```
sudo chmod +x ./cli/zellij-smart-sessionizer
sudo ln -s $(echo "$(pwd)/cli/zellij-smart-sessionizer") /usr/bin/zellij-smart-sessionizer
```

4. Populate your `Zoxide` database by simply going into the directories that you want to start the session from. Check [`Zoxide`](https://github.com/ajeetdsouza/zoxide) docs for more info.

5. **(Recommended)** I like to create alias for the script to have an ability to easily execute it. Place it into your shell's `.rc` file:

```sh
alias zs="zellij-smart-sessionizer"
```

6. **(Optional)** Create an alias to call this script in your shells `.rs` config

```sh
bindkey -s ^f "zellij-smart-sessionizer^M"
```

## Usage

Please refer to the [Usage section](../README.md#usage) inside root README 