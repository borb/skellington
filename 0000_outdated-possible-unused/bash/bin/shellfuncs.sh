# useful shell snippets

mkcd() {
	mkdir -v "$@" && cd "$@"
}

lc()
{
	for _file in "$@"
	do
		_newname="$(echo $_file | tr [A-Z] [a-z])"
		if [ "$_file" == "$_newname" ]
		then
			echo "\`$_file' [skipping, already lowercase]"
		else
			echo -n "\`$_file' -> \`$_newname'... "
			if mv "$_file" "$_newname"
			then
				echo "done."
			else
				echo "failed."
			fi
		fi
	done
}
