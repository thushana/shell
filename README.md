# Shell 🐚

This repository contains my shell configuration files, including my `.zshrc`, and a script to sync it with GitHub.

## 📜 Overview

- **`shell.sh`**: A script that copies my `.zshrc` file to this repo and commits the changes automatically.
- **`.zshrc`**: My personal Zsh configuration file.

## 🚀 Usage

To manually sync `.zshrc` to GitHub, run:

```sh
./shell.sh
```
You can also set up a cron job for automatic syncing:

```sh
crontab -e
```

Add the following line:

```sh
*/30 * * * * ~/Code/shell/shell.sh >> ~/.shell_sync.log 2>&1
```

This will sync .zshrc every 30 minutes.
