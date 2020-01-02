vimrc
-----

You will need git installed to bootstrap the vim startup.

Put the skeleton files in place:

	cp .vimrc ~/
	mkdir -p ~/.vim/{bundle,doc}

Check out vundle from git before bootstrapping:

	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Then bootstrap the bundle setup:

	vim +PluginInstall

Restart vim and your environment should be ready.
