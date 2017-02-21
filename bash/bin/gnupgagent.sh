# gnupg agent setup and operation
# use 'source gnupgagent.sh' in your .profile to start

VERBOSE=0
AGENT_BINARY=/usr/bin/gpg-agent
HOSTNAME_BINARY=/bin/hostname
GNUPGHOME=$HOME/.gnupg

# if agent doesn't exist, don't run
[ -x "$AGENT_BINARY" ] || return

if grep -qs '^[[:space:]]*use-agent' "$GNUPGHOME/gpg.conf" "$GNUPGHOME/options"
then
	# agent is enabled in config
	_startagent=1

	SYSTEM_HOSTNAME="$($HOSTNAME_BINARY -s)"
	if [ -f "$GNUPGHOME/persistent_agent_$SYSTEM_HOSTNAME" ]
	then
		# found a persistency file, read it
		PERS_INFO="$(cat $GNUPGHOME/persistent_agent_$SYSTEM_HOSTNAME)"
		eval "$PERS_INFO"
		unset PERS_INFO

		# check that the persistency info is still, err, persistent!
		AGENT_SOCKET="$(echo $GPG_AGENT_INFO | sed 's/:.*$//')"
		if [ ! -S "$AGENT_SOCKET" ]
		then
			# bugger, that socket doesn't exist
			[ "$VERBOSE" == "1" ] && echo "Clearing dead gpg-agent data."
			unset GPG_AGENT_INFO
			rm -f "$GNUPGHOME/persistent_agent_$SYSTEM_HOSTNAME"
			_startagent=1
		else
			# socket exists, we're good to go
			[ "$VERBOSE" == "1" ] && echo "Connected to existing gpg-agent."
			_startagent=0
		fi
	fi

	# do we need to start the agent now?
	if [ "$_startagent" == "1" ]
	then
		[ "$VERBOSE" == "1" ] && echo "Starting gpg-agent session."
		PERS_INFO="$($AGENT_BINARY --daemon --sh)"
		if [ ! -z "$PERS_INFO" ]
		then
			eval "$PERS_INFO"
			echo "$PERS_INFO" > "$GNUPGHOME/persistent_agent_$SYSTEM_HOSTNAME"
		fi
	fi

	unset _startagent
	unset AGENT_SOCKET
	unset SYSTEM_HOSTNAME
	unset PERS_INFO
fi

unset AGENT_BINARY
unset HOSTNAME_BINARY
unset GNUPGHOME
unset VERBOSE
