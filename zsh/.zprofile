# ~/.zprofile, executed for login shells for zsh

# the default umask is set in /etc/login.defs
#umask 022

# check and add local sbin to the path
if [ -d /usr/local/sbin -a ${path[(i)/usr/local/sbin]} -gt ${#path} ]; then
	path+=(/usr/local/sbin)
fi

# check and add sbin to the path
if [ -d /usr/sbin -a ${path[(i)/usr/sbin]} -gt ${#path} ]; then
	path+=(/usr/sbin)
fi
if [ -d /sbin -a ${path[(i)/sbin]} -gt ${#path} ]; then
	path+=(/sbin)
fi

# check and add local bin to the path
if [ -d /usr/local/bin -a ${path[(i)/usr/local/bin]} -gt ${#path} ]; then
	path+=(/usr/local/bin)
fi

# check and add user bin to the path
if [ -d ~/bin ]; then 
	# zsh will expand ~/bin to $HOME/bin, so we need to cope with this
	_homebin=~/bin
	if [ ${path[(i)$_homebin]} -gt ${#path} ]; then
		path+=(~/bin)
	fi
	unset _homebin
fi

# check and add homebrew paths to the path
if [ -d /opt/homebrew -a ${path[(i)/opt/homebrew/bin]} -gt ${#path} ]; then
	# working on the assumption that if /opt/homebrew/bin isn't in the path, then /opt/homebrew/sbin isn't either
	path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
fi

# if /usr/local/{bin,sbin} is in the path, move it to the front
if [ ${path[(i)/usr/local/sbin]} -le ${#path} ]; then
	_idx=${path[(i)/usr/local/sbin]}
	path[$_idx]=()
	path=(/usr/local/sbin $path)
	unset _idx
fi
if [ ${path[(i)/usr/local/bin]} -le ${#path} ]; then
	_idx=${path[(i)/usr/local/bin]}
	path[$_idx]=()
	path=(/usr/local/bin $path)
	unset _idx
fi

# run any local additions in ~/.zprofile.local
if [ -r ~/.zprofile.local ]; then
	source ~/.zprofile.local
fi
