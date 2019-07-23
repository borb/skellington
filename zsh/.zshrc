# ~/.zshrc - configuration for z shell

# are we running interactively?
case $- in
	*i*)
		;;
	*)
		return
		;;
esac

# we need the system type in various places
_system="$(uname -s)"

# Setup history; log to ~/.histfile, 1000 lines in memory and on disk
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Enable color support in supporting tools
_colourterm="no"

# Determine how to check for colours. Linux & macOS use ncurses to provide tput,
# which differs from the BSD tput
case "$_system" in
	FreeBSD|NetBSD|OpenBSD)
		_console_colours="$(tput Co)"
		[ "x$_console_colours" = "x" ] && _console_colours="0"
		;;
	*)
		_console_colours="$(tput colors)"
		;;
esac

# Check how many colours tput said we can handle
if [ $_console_colours -gt 2 ]; then
	_colourterm="yes"
fi
unset _console_colours

# Force colour?
#_colourterm="yes"

if [ "x$_colourterm" = "xyes" ]; then
	case "$_system" in
		Darwin|FreeBSD)
			# darwin and freebsd use the same core utilities set. these hinge on the CLICOLOR env
			# colour prompts are also supported
			export CLICOLOR=yes

			# improve ls' colour readability on dark terminals with these setting
			export LSCOLORS="ExFxCxDxBxEgEdAbAgAcAd"
			;;
		Linux)
			# most linux distros use coreutils, which come with a 'dircolors' command. this sets up
			# LS_COLORS colour prompts supported
			if [ -x /usr/bin/dircolors ]; then
				test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
				alias ls="ls --color=auto"
			fi
			;;
	esac

	# let grep decide when to colourise and when not to
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias pcregrep='pcregrep --color=auto'

	# gcc likes colours too
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# use emacs line editing
bindkey -e

# setup command line completion
zstyle :compinstall filename ~/.zshrc
[ -d ~/.zsh/completion ] && fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
compinit -i

# style the completion with a menu highlight
zstyle ':completion:*' menu select

# load antigen and bundles
if [ -r ~/.antigen/antigen/antigen.zsh ]; then
	source ~/.antigen/antigen/antigen.zsh

	# set our theme and syntax highlighting
	[ "x$_colourterm" = "xyes" ] && {
		antigen theme aphlor/planet-zsh planet
		antigen bundle zsh-users/zsh-syntax-highlighting
	}

	# more completion
	antigen bundle zsh-users/zsh-completions src

	# finish with antigen
	antigen apply
fi

# lastly; load our customisations (if present)
if [ -r ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi

if [ -r ~/bin/shellfuncs.sh ]; then
	source ~/bin/shellfuncs.sh
fi

# clean up
unset _colourterm
unset _system
