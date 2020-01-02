# here be skellingtons

editor configs, shell profiles, etc.

enough to get my shell & software setup on a dev environment.

## aptitude

copy `aptitude/apt.conf.d/99aptitude-colours` to `/etc/apt/apt.conf.d` in order to subtly change the `aptitude` colours. in particular, it changes the background from black to 'default' so you can benefit from non-opaque terminals.

## neovim

see [neovim/README.md](neovim/README.md) for installation instructions.

## tmux

copy `tmux/.tmux` and its contents, and `tmux/.tmux.conf` to `$HOME` and it should work. some options are incompatible with some installations of tmux; i haven't had time to work out which.

## vscode

from a console, run `for i in $(cat extensions.txt); do code --install-extension $i; done`. paste `vscode/settings.json` into your settings file, and `vscode/keybindings.json` into your keybindings file. some paths require alteration to be compatible with remotes. defaults paths are for Windows using a self-built arch linux wsl rootfs.

## zsh

see [zsh/README.md](zsh/README.md) for installation instructions.
