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
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" other bundles to load

" ctrl-p plugin: load a file with ctrl-p, completing paths and filenames
Plugin 'kien/ctrlp.vim'

" tabman - use \mt to switch between active tabs
Plugin 'kien/tabman.vim'

" new DBGp plugin for vim, supports multiple debug protocols, replacing joonty/vim-xdebug
Plugin 'joonty/vdebug'

" php integration for vim
"Plugin 'spf13/PIV'

" colour theme
Plugin 'tomasr/molokai'

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
if filereadable(expand("~/.config/nvim/bundle/molokai/colors/molokai.vim"))
	colorscheme molokai
	highlight Normal ctermbg=none
endif

" airline settings
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='dark'

" nerdtree settings
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.localized', '\.DS_Store']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

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

" {{{ file association settings and macro functions for file types
autocmd BufRead,BufNewFile,BufAdd,BufCreate mutt-* call ModeMsgEdit()
autocmd BufRead,BufNewFile,BufAdd,BufCreate *.{php,phtml,php,inc} call ModePHP()
autocmd BufRead,BufNewFile,BufAdd,BufCreate *.{htm,html,xhtml,xml,wsdl,xsl,xslt,dtd} call ModeXML()
autocmd BufRead,BufNewFile,BufAdd,BufCreate *.js call ModeJS()

" {{{ ModeMsgEdit() - for editing email/news
function ModeMsgEdit()
	" folding
	set foldmethod=syntax

	" tabbing
	set tabstop=4
	set expandtab

	" indenting
	set shiftwidth=4

	" wrapping
	set textwidth=76

	"echon " - welcome to email editing mode."
endfunction
" }}}

" {{{ ModePHP() - edit PHP
function ModePHP()
	set tabstop=4
	set shiftwidth=4
"	set syntax=php
	set nowrap
	set expandtab
	echon " - welcome to PHP mode."
endfunction
" }}}

" {{{ ModeXML() - edit XML and similar formats
function ModeXML()
	set tabstop=4
	set shiftwidth=4
	set nowrap
	vmap t		:!tidy -xml -indent -wrap 0 -quiet<CR>
	echon " - welcome to XML mode."
endfunction
" }}}

" {{{ ModeJS() - edit Javascript
function ModeJS()
	set tabstop=4
	set shiftwidth=4
	set nowrap
	echon " - welcome to Javascript mode."
endfunction
" }}}

" }}}
