# here be skellingtons

editor configs, shell profiles, etc.

enough to get my shell & software setup on a dev environment.

## aptitude

copy `aptitude/apt.conf.d/99aptitude-colours` to `/etc/apt/apt.conf.d` in order to subtly change the `aptitude` colours. in particular, it changes the background from black to 'default' so you can benefit from non-opaque terminals.

## neovim

see [neovim/README.md](neovim/README.md) for installation instructions.

## newt

darkens the usually white-on-blue used frequently by debian for dialogs in console sessions. copy `debian/etc/newt/palette` to `/etc/newt/palette`.

## tmux

see [tmux/README.md](tmux/README.md) for installation instructions.

## windows terminal

copy [windowsterminal/profiles.json](windowsterminal/profiles.json) over the default configuration; this might not be a great idea if you've installed shells (e.g. powershell 7), so consider careful merging instead. you're on your own.

## zsh

see [zsh/README.md](zsh/README.md) for installation instructions.
