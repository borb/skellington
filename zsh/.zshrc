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
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	_colourterm="yes"
fi

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

	# gcc likes colours too
	export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
fi

# use emacs line editing
bindkey -e

# setup command line completion
zstyle :compinstall filename ~/.zshrc
autoload -Uz compinit
compinit

# style the completion with a menu highlight
zstyle ':completion:*' menu select

# load antigen
if [ -r ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-antigen.git/antigen.zsh ]; then
	source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-antigen.git/antigen.zsh
	_antigen_present=yes
elif [ -r ~/bin/antigen.zsh ]; then
	source ~/bin/antigen.zsh
	_antigen_present=yes
fi

# if antigen was loaded, use it
if [ -n "$_antigen_present" ]; then
	# use the antigen bundle: it can self update
	antigen bundle zsh-users/antigen

	# set our theme and syntax highlighting
	[ "x$_colourterm" = "xyes" ] && {
		antigen theme aphlor/planet-zsh planet
		antigen bundle zsh-users/zsh-syntax-highlighting
	}

	# finish with antigen
	antigen apply
	unset _antigen_present
fi

# clean up
unset _colourterm
unset _system
