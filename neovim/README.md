nvim
----

You will need git installed to bootstrap the vim startup.

Put the skeleton files in place:

	mkdir -p ~/.config/nvim/{bundle,doc}
	cp .config/nvim/init.vim ~/.config/nvim/

Check out vundle from git before bootstrapping:

	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

Then bootstrap the bundle setup:

	nvim +PluginInstall

Restart vim and your environment should be ready.
