" rob's vim configuration
" vim:fdm=marker:fmr={{{,}}}:ts=8:sw=8:noet:

" {{{ editor personal preferences, tab size, indentation settings
set nocompatible

" tabs
set tabstop=8
set noexpandtab

" indentation
set noautoindent
set smartindent
set shiftwidth=8
inoremap # X#

" file handling
set backupcopy=auto,breakhardlink

" backspace can do what it wants, don't mimic old behaviour
set backspace=indent,eol,start

" line numbering
set number

" give a 5-line scrolloff
set scrolloff=5

" highlight end of lines, tabs, trailing space white space
set list
set listchars=eol:¬,tab:‣\ ,trail:∙,extends:>,precedes:<
" }}}

" {{{ editor appearance, verbosity
set background=dark
set hlsearch
set ruler
set showmatch
set showmode
set showcmd
set equalalways
set laststatus=2
set showtabline=2
syntax on

" gui font and default size
if has("gui_running")
	set guifont=Monaco\ 10
	set columns=112
	set lines=40
endif
" }}}

" {{{ searching and highlighting
set ignorecase

" highlighting crap
highlight eolwhitespace ctermbg=red
match eolwhitespace /\s\+$/
" }}}

" {{{ enable syntax completion
filetype plugin on
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
		\if &omnifunc == "" |
			\setlocal omnifunc=syntaxcomplete#Complete |
		\endif
endif
" }}}

" {{{ bundles and plugins (HINT: EXTENSIONS TO VIM ARE HERE)
filetype off			" apparently vundle requires this, odd
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" other bundles to load

" updated php syntax
Plugin 'StanAngeloff/php.vim'

" ctrl-p plugin: load a file with ctrl-p, completing paths and filenames
Plugin 'kien/ctrlp.vim'

" tabman - use \mt to switch between active tabs
Plugin 'kien/tabman.vim'

" new DBGp plugin for vim, supports multiple debug protocols, replacing joonty/vim-xdebug
Plugin 'joonty/vdebug'

" php integration for vim
"Plugin 'spf13/PIV'

" colour theme
Plugin 'joshdick/onedark.vim'

" vim-airline, a swish statusline and tabline for vim
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" a filetree plugin
Plugin 'scrooloose/nerdtree'

" php syntax checking
"Plugin 'scrooloose/syntastic'

" cvs conflict resolution
Plugin 'CVSconflict'

" open, save, close gnupg encrypted files
Plugin 'gnupg.vim'

" laravel blade support
Plugin 'xsbeats/vim-blade'

" sudo support for vim
Plugin 'sudo.vim'

" load gitgutter
Plugin 'airblade/vim-gitgutter'

" ack plugin
Plugin 'mileszs/ack.vim'

" end of plugin setup
call vundle#end()
filetype on
" Vundle recommends the following, but indent plugin can be crazy and irritating
"filetype plugin indent on
" }}}

" {{{ settings for bundles and plugins
" tabman
" no line numbering
let g:tabman_number=0

" colours
if filereadable(expand("~/.config/nvim/bundle/onedark.vim/colors/onedark.vim"))
	colorscheme onedark
	highlight Normal ctermbg=none
	highlight LineNr ctermbg=234
endif

" airline settings
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='dark'

" nerdtree settings
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" keys for next/prev tabs
map <leader>, :tabprevious<CR>
map <leader>. :tabnext<CR>

" keys for next/prev buffers in a tab
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>

" vdebug keys
"let g:vdebug_keymap['get_context']='<leader>c'
"let g:vdebug_options={
"\	'server': 'xxxx',
"\	'path_maps': {
"\		'/remote/loc': '/local/loc'
"\	}
"\}

" syntastic!
"let g:syntastic_check_on_wq=0
" }}}

" {{{ syntax specific settings
autocmd BufRead,BufNewFile,BufAdd,BufCreate mutt-* 
	\setlocal foldmethod=syntax tabstop=4 expandtab shiftwidth=4 textwidth=76

" remap .inc as php files (also set the php options)
autocmd BufRead,BufNewFile,BufAdd,BufCreate *.inc
	\setlocal syntax=php tabstop=4 shiftwidth=4 nowrap expandtab

autocmd Filetype php setlocal tabstop=4 shiftwidth=4 nowrap expandtab

autocmd Filetype xml setlocal tabstop=4 shiftwidth=4 nowrap
autocmd Filetype xml vmap t :!tidy -xml -indent -wrap 0 -quiet<CR>

autocmd Filetype json,javascript setlocal tabstop=2 shiftwidth=2 expandtab nowrap

autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab
" }}}
