" ========== $MYVIMRC (Unix & Windows) ===========================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2014-10-21
" ================================================================


" Useful variables & functions
" {
	let s:hasUnix = has('unix')
	let s:hasWin = has('win32') || has('win64')

	function! s:PlugInOs(link, param, os)
		if has(a:os)
			if !empty(a:param)
				execute "Plug '".a:link."', ".a:param.""
			else
				execute "Plug '".a:link."'"
			endif
		endif
	endfunction
" }
" Stock the Location of vim's folder in a global variable.
" {
	if s:hasWin
		let s:vimDir = "$HOME/vimfiles"
	else
		let s:vimDir = "$HOME/.vim"
	endif
" }


" ========== VIM-PLUG ==============================================
if s:hasWin
	call plug#begin($HOME.'/vimfiles/plugged')
else
	call plug#begin('~/.vim/plugged')
endif

" Plugins:
" " {
	" For PHP
		Plug 'PHP-correct-Indenting'
		Plug 'StanAngeloff/php.vim'
	" For HTML/CSS & markdown
		Plug 'gorodinskiy/vim-coloresque', { 'for': ['css', 'scss', 'html', 'php'] }
		Plug 'mattn/emmet-vim'
		Plug 'othree/html5.vim'
		Plug 'plasticboy/vim-markdown'
		Plug 'tpope/vim-haml'
		call s:PlugInOs('suan/vim-instant-markdown', '', 'unix')
	" For JavaScript
		Plug 'pangloss/vim-javascript'
	" For Python
		Plug 'hdima/python-syntax'
	" For Java
		Plug 'javacomplete'
	" For Git
		Plug 'airblade/vim-gitgutter'
		Plug 'idanarye/vim-merginal'
		Plug 'tpope/vim-fugitive'
	" For (( fuzzyfinder ))
		Plug 'L9'
		Plug 'FuzzyFinder'
	" For (( ultisnips ))
		Plug 'SirVer/ultisnips'
		Plug 'honza/vim-snippets'
	" For (( airline ))
		Plug 'bling/vim-airline'
	" For (( nerdtree ))
		Plug 'scrooloose/nerdtree'
	" For (( ctrlp ))
		" Plug 'kien/ctrlp.vim'
		Plug 'ctrlpvim/ctrlp.vim'		" A fork of CtrlP, more active repo.
		Plug 'mattn/ctrlp-mark'
		Plug 'tacahiroy/ctrlp-funky'
	" (( syntastic )) & linters
		Plug 'scrooloose/syntastic'
		Plug 'syngan/vim-vimlint', {'for': 'vim'}
		Plug 'ynkdir/vim-vimlparser', {'for': 'vim'}
	" Various
		Plug 'AndrewRadev/splitjoin.vim'
		Plug 'Lokaltog/vim-easymotion'
		Plug 'Raimondi/delimitMate'
		Plug 'godlygeek/tabular'
		Plug 'kshenoy/vim-signature'
		Plug 'majutsushi/tagbar'
		Plug 'matchit.zip'
		Plug 'matze/vim-move'
		Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
		Plug 'rhysd/clever-f.vim'
		Plug 'sk1418/Join'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'tommcdo/vim-exchange'
		Plug 'tomtom/tcomment_vim'
		Plug 'tpope/vim-surround'
		call s:PlugInOs('Valloric/YouCompleteMe', '', 'unix')
	" Colorschemes
		Plug 'chriskempson/base16-vim'
		Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
		Plug 'nanotech/jellybeans.vim'
		Plug 'reedes/vim-colors-pencil'
		Plug 'sjl/badwolf'
		Plug 'w0ng/vim-hybrid'
	" My Plugins
		" Plug 'KabbAmine/vCoolor.vim'
		" Plug 'KabbAmine/vullScreen.vim'
		" Plug 'KabbAmine/zeavim.vim'
		call s:PlugInOs('~/Projects/pluginsVim/vCoolor', '', 'unix')
		call s:PlugInOs('~/Projects/pluginsVim/zeavim', '', 'unix')
		call s:PlugInOs('~/Projects/pluginsVim/vullScreen', '', 'unix')
		call s:PlugInOs('~/Projects/pluginsVim/termivator', '', 'unix')
		call s:PlugInOs('Z:\k-bag\Projects\pluginsVim\vCoolor', '', 'win32')
		call s:PlugInOs('Z:\k-bag\Projects\pluginsVim\zeavim', '', 'win32')
		call s:PlugInOs('Z:\k-bag\Projects\pluginsVim\vullScreen', '', 'win32')
		call s:PlugInOs('Z:\k-bag\Projects\pluginsVim\termivator', '', 'win32')
 " }

call plug#end()


" ========== VARIOUS  ===========================================
set nocompatible		" No compatible with Vi.

" Load indentation rules and plugins according to the detected filetype.
" {
	if has("autocmd")
		filetype plugin indent on
	endif
"}

" Enables syntax highlighting.
" {
	if has("syntax")
		syntax on
	endif
" }

" What to write in Viminfo and his location.
execute "set vi='100,<50,s10,h,n".s:vimDir."/various/viminfo"

" Add the file systags to the tags option.
execute "set tags+=".s:vimDir."/various/systags"

" Using a dark background.
set background=dark

" Theme & number of colors.
" {
	if s:hasWin
		colorscheme hybrid
	elseif !empty($TERM)
		colorscheme Tomorrow-Night
	else
		colorscheme Tomorrow-Night
	endif
" }

" Disable Background Color Erase (BCE) so that color schemes work properly when Vim is used inside tmux and GNU screen.
" {
	if &term =~ '256color'
		set t_ut=
	endif
" }

" Tmux will send xterm-style keys when its xterm-keys option is on.
" {
	if &term =~ '^screen'
		execute "set <xUp>=\e[1;*A"
		execute "set <xDown>=\e[1;*B"
		execute "set <xRight>=\e[1;*C"
		execute "set <xLeft>=\e[1;*D"
	endif
" }
	
" Directory where to store files with :mkview.
" {
	execute "set viewdir=".s:vimDir."/various/view"
" }

" Make <Alt> works in terminal.
" (http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459)
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endwhile

" ========== GUI ===============================================
if has("gui_running")
	set guioptions-=T		" No toolbar in GVim.
	set guioptions-=m		" No menu in GVim.
	set guioptions-=e		" Apply normal tabline in Gvim.
	set guioptions-=L
	set guioptions-=l
	if s:hasWin
		set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
	else
		" set guifont=Monospace\ 10
		set guifont=Ubuntu\ Mono\ derivative\ powerline\ 12
	endif
	set wak=no				" Don't use the ALT-keys for menus.
	set linespace=2			" Number of pixel lines to use between lines.
endif


" ========== MESSAGES & INFO ===================================
set showcmd			" Show (partial) command in status line.
set showmode		" Display the current mode in status line.
set ruler			" Show cursor position below each window.


" ========== EDIT TEXT =========================================
set showmatch						" Show matching brackets.
set matchpairs=(:),{:},[:],<:>		" List of pairs that match for the % command.
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu for Insert mode completion without preview.
if s:hasWin
	set backspace=2					" Make backspace works normally in Win
endif


" ========== DISPLAY TEXT ======================================
set number							" Show the line number for each line.
set linebreak						" Wrap long lines at a character in 'breakat'.
let &showbreak='░░░░ '				" String to put before wrapped screen lines.
set scrolloff=3						" Number of screen lines to show around the cursor.
set display=lastline				" Show the last line even if it doesn't fit.
" Make stars and bars visible
" {
	hi link HelpBar Normal
	hi link HelpStar Normal
" }
" Format of highlighting for tabs, whitespace... using 'list'.
" {
	if s:hasWin
		set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
	else
		set listchars=tab:╎\ ,trail:•,extends:#,nbsp:.
	endif
	set list
" }


" ========== MOVE, SEARCH & PATTERNS ===========================
set ignorecase					" Do case insensitive matching.
set smartcase					" Do smart case matching.
set incsearch					" Incremental search.
set whichwrap=b,s,<,>,[,]		" List of flags specifying which commands wrap to another line.


" ========== SYNTAX, HIGHLIGHTING AND SPELLING =================
if has('gui_running')
	set cursorline
endif
set hlsearch				" Highlight all matches for the last used search pattern.
set spelllang=fr			" List of accepted languages.


" ========== TABS & INDENTING ==================================
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent			" Automatically set the indent of a new line.
set smartindent			" Do clever autoindenting.
set copyindent			" Copy whitespace for indenting from previous line.


" ========== FOLDING ===========================================
set foldcolumn=1			" Width of the column used to indicate fold.


" ========== COMMAND LINE EDITING ==============================
set wildmode=list:longest,full		" Command <Tab> completion, list matches, then longest common part, then all.
set wildmenu						" Command-line completion shows a list of matches with TAB.
" Enable the persistent undo.
if has("persistent_undo")
	execute "set undodir =".s:vimDir."/various/undodir/"
	set undofile
endif


" ========== MULTI-BYTE CHARACTERS =============================
set encoding=utf-8


" ========== MULTIPLE WINDOWS ==================================
set splitright						" A new window is put right of the current one.
set laststatus=2					" 0, 1 or 2; when to use a status line for the last window.
set statusline=%<%f\ %y\ %h%m%r%a%=%-14.(%l,%c%V%)\ %P	" Alternate format to be used for a status line.


" ========== SWAP FILE =========================================
" Set the swap file directories.
if s:hasWin
	execute "set directory=".s:vimDir."\\various\\swap_dir,c:\\tmp,c:\\temp\\"
else
	execute "set directory=".s:vimDir."/various/swap_dir,~/tmp,/var/tmp,/tmp\""
endif


" =========== MAPPING ==========================================
" Text manipulation *******
" {
	" *** NORMAL & VISUAL MODE
		" *** <C-d>		=> Duplicate line.
	" *** INSERT MODE
		" *** <A-d> => Duplicate line.
		" *** <A-k> => Delete line.
		" *** <A-$> => Delete till end of line.
		" *** <A-o> => Insert new line.
		" *** <A-a> => Insert new line before.
		" *** <A-"> => Change inside ", ', (, ...
		" *** <A-t> => Change inside xml tag
			vnoremap <silent> <C-d> :t'><CR>
			nnoremap <silent> <C-d> yyp
			inoremap <silent> <A-d> <Esc>mxyyp`x:delmarks x<CR>:sleep 100m<CR>a
			inoremap <silent> <A-$> <C-o>d$
			inoremap <silent> <A-k> <C-o>$<C-u>
			inoremap <silent> <A-o> <C-o>o
			inoremap <silent> <A-a> <C-o>O
			inoremap <silent> <A-'> <C-o>ci'
			inoremap <silent> <A-"> <C-o>ci"
			inoremap <silent> <A-(> <C-o>ci(
			inoremap <silent> <A-{> <C-o>ci{
			inoremap <silent> <A-[> <C-o>ci[
			inoremap <silent> <A-t> <C-o>cit
" }

" Apply the option 'only' *******
" {
	" *** <F5>		=> For a splitted window.
	" *** <S-F5>	=> For a tab.
		nmap <silent> <F5> :only<CR>
		nmap <silent> <S-F5> :tabonly<CR>
" }

" Open the manual for the selected command *******
" {
	" *** \m
		nmap <silent> <leader>m \K
" }

" Open or close the fold *******
" {
	" *** <space>
		nnoremap <silent> <space> za
		vmap <silent> <space> :fold<CR>
" }

" Remove the highlighting of 'hlsearch' *******
" {
	" *** <F6>
		map <silent> <F6> :nohlsearch<CR>
" }

" Make shortcuts for completion *******
" {
	" *** <c-space>		=> Omni-completion.
		" inoremap <silent> <c-space> <c-x><c-o><c-p>
" }

" Operations on tabs *******
" {
	" *** <C-t>			=> New tab.
	" *** <S-Tab>		=> Next tab.
		map <silent> <C-t> :tabedit<CR>
		map <silent> <S-Tab> gt
" }

" Operations on buffers *******
" {
	" *** <C-S-left>		=> Previous.
	" *** <C-S-right>		=> Next. 
	" *** <C-q>		=> Delete buffer.
		map <silent> <C-S-left> :bp!<CR>
		map <silent> <C-S-right> :bn!<CR>
		nnoremap <silent> <C-q> :bd<CR>
" }

" Repeat the last command *******
" {
	" *** zz
		nnoremap zz :<Up><CR>
" }

" Operations on current buffer (Move between errors) *******
" {
	" *** <c-F3>	=> lprevious.
	" *** <c-F4>	=> lnext.
		nmap <silent> <c-F3> :lprevious<CR>
		nmap <silent> <c-F4> :lnext<CR>
" }

" (( termivator )) shortcuts *******
" {
	" *** ;t	=> Terminal.
	" *** ;f	=> File manager.
	" *** ;g	=> Gitg.
	" *** ;h	=> Haroopad
		nmap <silent> ;t :Tt<CR>
		nmap <silent> ;f :Tf<CR>
		nmap <silent> ;g :Tg<CR>
		nmap <silent> ;h :Th<CR>
" }

" (( CtrlP )) & extensions shortcuts *******
" {
	" *** ,,f	:CtrlP
	" *** ,F	:Funky
	" *** ,t	:BufTag
	" *** ,l	:Line
	" *** ,m	:Marks
		nmap <silent> ,,f	:CtrlP<CR>
		nmap <silent> ,F  :CtrlPFunky<CR>
		nmap <silent> ,t   :CtrlPBufTag<CR>
		nmap <silent> ,l   :CtrlPLine %<CR>
		nmap <silent> ,m   :CtrlPMark<CR>
" }

" (( FuzzyFinder )) shortcuts *******
" {
	" *** ,b		=> FufBuffer
	" *** ,f		=> FufFile
	" *** ,r		=> FufMruFile
	" *** ,d		=> FufDir
	" *** ,B		=> FufBookmarkDir
	" *** ,c		=> FufMruCmd
		nmap <silent> ,b :FufBuffer<CR>
		nmap <silent> ,f :FufFile<CR>
		nmap <silent> ,r :FufMruFile<CR>
		nmap <silent> ,d :FufDir<CR>
		nmap <silent> ,B :FufBookmarkDir<CR>
		nmap <silent> ,c :FufMruCmd<CR>
" }

" (( ultisnips )) *******
" {
	" <C-F2>		=> Open the custom snippet file of the current file.
		nmap <C-F2> :UltiSnipsEdit<CR>
" }

" (( NERDTree )) shortcut *******
" {
	" *** ,N		=> Toggle NERDTree.
		nmap <silent> ,N :NERDTreeToggle<CR>
" }

" (( tagbar )) shortcut *******
" {
	" *** ,T		=> TagbarToggle
		nnoremap <silent> ,T :TagbarToggle<CR>
" }

" (( undotree )) shortcut *******
" {
	" *** ,U		=> UndotreeToggle
		nnoremap <silent> ,U :UndotreeToggle<CR>
" }

" (( tComment )) shortcut *******
" {
	" *** \cc			=> Comment or uncomment a line.
	" *** \c{motion}	=> Comment or uncomment a specified motion.
		nmap <silent> <leader>cc <c-_><c-_>
		vmap <silent> <leader>cc <c-_><c-_>
		nmap <silent> <leader>c gc
" }

" (( syntastic )) shortcuts *******
" {
	" *** <F8>		=> SyntasticCheck
	" *** <c-F8>	=> SyntasticReset
	" *** ,E		=> Display an errors window.
		map <silent> <F8> :SyntasticCheck<CR>
		map <silent> <c-F8> :SyntasticReset<CR>
		map <silent> ,E :Errors<CR>
" }

" (( easymotion )) shortcuts *******
" {
	" *** ù				=> Leader key of easymotion.
	" *** ù<Down>		=> j motion.
	" *** ù<Up>			=> k motion.
	" *** ù<Right>		=> w motion.
	" *** ù<Left>		=> b motion.
	" *** ùù			=> Anywhere in the same line.
	" *** ùf			=> Search for a character in both directions (f equivalent).
		" Disable default mappings
			let g:EasyMotion_do_mapping = 0
		map <silent> ù		  <Plug>(easymotion-prefix)
		map <silent> ù<Down>  <Plug>(easymotion-sol-j)
		map <silent> ù<Up>	  <Plug>(easymotion-sol-k)
		map <silent> ù<Right> <Plug>(easymotion-iskeyword-w)
		map <silent> ù<Left>  <Plug>(easymotion-iskeyword-b)
		map <silent> ùù		  <Plug>(easymotion-lineanywhere)
		map <silent> ùf		  <Plug>(easymotion-bd-f)
" }

" (( splitjoin )) mappings *******
" {
	" *** \s				=> Split code.
	" *** \j				=> Join code.
		" Disable the default mapping.
			let g:splitjoin_split_mapping = ''
			let g:splitjoin_join_mapping = ''
		nmap <silent> <Leader>j :SplitjoinJoin<CR>
		nmap <silent> <Leader>s :SplitjoinSplit<CR>
" }

" (( move )) *******
" {
	" Disable default mapping.
		let g:move_map_keys = 0
	vmap <A-up> <Plug>MoveBlockUp
	vmap <A-down> <Plug>MoveBlockDown
	nmap <A-up> <Plug>MoveLineUp
	nmap <A-down> <Plug>MoveLineDown
" }


" =========== COMMANDS ==============================
" Make cursor line appear only in INSERT mode (Terminal only)
" {
	if !empty($TERM)
		autocmd InsertEnter * set cursorline
		autocmd InsertLeave * set nocursorline
	endif
" }

" Open config files for editing *******
" {
	" *** :Ev		=> ~/.vimrc
	" *** :Eb		=> ~/.dotfiles/bash/bashrc
	" *** :Ea		=> ~/.dotfiles/bash/bash_aliases
	" *** :Ef		=> ~/.dotfiles/bash/bash_functions
	" *** :Et		=> ~/.dotfiles/tmux/.tmux.conf
		command! Ev :e! $MYVIMRC
		command! Eb :e! $HOME/.dotfiles/bash/bashrc
		command! Ea :e! $HOME/.dotfiles/bash/bash_aliases
		command! Ef :e! $HOME/.dotfiles/bash/bash_functions
		command! Et :e! $HOME/.dotfiles/tmux/tmux.conf
" }

" Commands for manipulating directories and deleting files *******
" {
	" *** :CreD		=> Create directory(ies) (Or directories recursively)
	" *** :SCreD	=> Same as last command but with high privileges (Unix).
	" *** :DelD		=> Delete directory(ies) in windows.
	" *** :DelF		=> Delete file(s) in windows.
	" *** :Del		=> Delete file(s) or folder(s).
	if s:hasWin
		command! -complete=file -nargs=+ CreD :!MD <args>
		command! -complete=file -nargs=+ DelD :!RD /S <args> 
		command! -complete=file -nargs=+ DelF :!DEL /P <args> 
	else
		command! -complete=file -nargs=+ CreD :!mkdir -pv <args> 
		command! -complete=file -nargs=+ SCreD :!sudo mkdir -pv <args> 
		command! -complete=file -nargs=+ Del :!rm -Irv <args> 
	endif
" }

" Set md files as a markdown files.
" {
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" }


" Define the file type *******
" {
	" *** :Ft <FileType>
		command! -complete=filetype -nargs=1 Ft :set ft=<args>
" }

" Specify indentation (ts,sts,sw) *******
" {
	" *** :Indent
		command! Indent :call Indent()
		function! Indent()
			let s:size_of_indentation = input("New indentation (".&ts.",".&sts.",".&sw.") => ")
			if(s:size_of_indentation != '')
				execute "setlocal ts=".s:size_of_indentation.""
				execute "setlocal sts=".s:size_of_indentation.""
				execute "setlocal sw=".s:size_of_indentation.""
			endif
		endfunction
" }

" Shortcuts for vim doc *******
" {
	" *** :Hl	=>	local-additions
	" *** :Fl	=>	function-list
		command! Hl :help local-additions
		command! Fl :help function-list
" }

" Change file type between PHP and HTML files *******
" {
	" *** :Ch
		autocmd! FileType php command! Ch :setlocal ft=html
		autocmd! FileType html command! Ch :setlocal ft=php
" }

" Conversion between TABS ans SPACES *******
" {
	" *** :TabToSpace
	" *** :SpaceToTab
		command! TabToSpace :setlocal expandtab | %retab!
		command! SpaceToTab :setlocal noexpandtab | %retab!
" }

" Make the current file directory as the vim current directory *******
" {
	" *** :Dir
	command! Dir :cd %:p:h
" }

" Short commands for (( vim-plug ))
" {
	" *** :PI			=> Install new plugins.
	" *** :PU			=> Update all plugins.
	" *** :PS			=> Show plugin status.
	" *** :PC			=> Clean the plugin directories.
		command! PI :PlugInstall
		command! PU :PlugUpdate
		command! PS :PlugStatus
		command! PC :PlugClean
" }
" Toggle (( gitgutter )) *******

" {
	" *** :GG	=> Toggle GitGutter.
	" *** :Gn	=> Next diff.
	" *** :Gp	=> Previous diff.
		command! GG :GitGutterToggle
		command! Gn :GitGutterNextHunk
		command! Gp :GitGutterPrevHunk
" }


" =========== ABBREVIATIONS ==============================
" No more rage (Idea from a generated vimrc
" from http://vim-bootstrap.com/)
" {
	cab W! w!
	cab Q! q!
	cab QA! qa!
	cab QA qa
	cab Wq wq
	cab wQ wq
	cab WQ wq
	cab W w
	cab Q q
" }


" =========== OMNIFUNC ==============================
" Set omni-completion if the appropriate syntax file is present otherwise use the syntax completion ***
" {
	if has("autocmd") && exists("+omnifunc")
		autocmd! Filetype *
			\	if &omnifunc == "" |
			\		setlocal omnifunc=syntaxcomplete#Complete |
			\	endif
	endif
	" For (( javacomplete ))
		if has("autocmd")
			autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
		endif
" }


" =========== PLUGINS OPTIONS =======================
" Make the man page appear in a Vim window *******
	runtime! ftplugin/man.vim

" ******* (( FuzzyFinder )) *******
" {
		let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|\.(png|jpg|jpeg|gif|xcf|svg)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|\.(cbp|depend)$'
	" Enable all the modes (MRU mode was disabled).
		let g:fuf_modesDisable = []
	let g:fuf_mrufile_maxItem = 40
	" Separator for a primary and refining patterns.
		let g:fuf_patternSeparator = '+'
	" Cancel the <Ctrl-s> shortcut to use it in next command.
		let g:fuf_keyPrevPattern = ''	
	let g:fuf_keyOpenSplit = '<C-s>'
	let g:fuf_keyOpenVsplit = '<C-v>'
	let g:fuf_buffer_keyDelete = '<C-d>'
	" Cancel the <Ctrl-t> shortcut to use it in next command.
		let g:fuf_keyNextMode = '<>'
	let g:fuf_keyOpenTabpage = '<C-t>'
	" Define the directory for data files.
		execute "let g:fuf_dataDir = '".s:vimDir."/various/fuf-data/'"
" }

" ******* (( NERDTree )) *******
" {
	if s:hasWin
		let NERDTreeBookmarksFile='C:\Users\k-bag\vimfiles\various\NERDTreeBookmarks'
	else
		let NERDTreeBookmarksFile='/home/k-bag/.vim/various/NERDTreeBookmarks'
	endif
	" Ignore the following files.
		let NERDTreeIgnore=['\~$', '\.class$']
	" Remove a buffer when a file is being deleted or renamed.
		let NERDTreeAutoDeleteBuffer=1
	" Single-clic for folder nodes and double for files.
		let NERDTreeMouseMode=2
	let NERDTreeDirArrows=1
" }

" " ******* (( python-syntax )) *******
	let python_highlight_all=1

" ******* (( tagbar )) *******
" {
	let g:tagbar_autofocus = 1
	" Sort the elements by the order of appearance.
		let g:tagbar_sort = 0
	" Define the ctags location for windows.
		if s:hasWin
			let g:tagbar_ctags_bin = 'C:\Program Files\ctags58\ctags.exe'
		endif
	" Get a simple list of ((ultisnips)) snippets in snippet files.
		let g:tagbar_type_snippets = {
					\ 'ctagstype' : 'snippets',
					\ 'kinds' : [
					\ 's:snippets',
					\ ]
					\ }
" }

" ******* (( airline )) *******
" {
  let g:airline_theme='raven'
	" Customization.
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
	" Automatically populate the symbols dictionary with the powerline symbols.
		let g:Powerline_symbols = 'fancy'
		let g:airline_powerline_fonts = 1
	" Tabline.
		let g:airline#extensions#tabline#enabled = 1
		let g:airline#extensions#tabline#show_buffers = 1
		" Configure the minimum number of buffers needed to show the tabline.
			let g:airline#extensions#tabline#buffer_min_count = 1
		" Configure the minimum number of tabs needed to show the tabline.
			let g:airline#extensions#tabline#tab_min_count = 1
" }

" ******* (( markdown )) *******
" {
	" Disable folding.
		let g:vim_markdown_folding_disabled=1
" }

" ******* (( syntastic )) *******
" {
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_html_checkers = ['w3']
	let g:syntastic_javascript_checkers = ['jslint']
	let g:syntastic_mode_map = { "mode": "passive",
				\ "active_filetypes": [],
				\ "passive_filetypes": ["c", "java", "php", "python", "sh", "tex", "javascript", "html", "xhtml", "css", "sass", "scss"]
				\ }
" }

" ******* (( emmet )) *******
" {
	" Enable emmet for specific files.
		let g:user_emmet_install_global = 0
		autocmd FileType html,xhtml,scss,css,sass,php EmmetInstall
	let g:user_emmet_leader_key = '<c-e>'
" }

" ******* (( undotree )) *******
" {
	let g:undotree_SetFocusWhenToggle = 1
	let g:undotree_WindowLayout = 'botright'
	" Automatically remove a buffer when his file is being deleted/renamed via the menu.
		let NERDTreeAutoDeleteBuffer=1
	" Case sensitive sorting.
		let NERDTreeCaseSensitiveSort=1
" }

" ******* (( delimitmate )) *******
" {
	let delimitMate_matchpairs = "(:),[:],{:}"
" }

" ******* (( vim-javascript )) *******
" {
	let javascript_enable_domhtmlcss = 1
" }

" ******* (( easymotion )) *******
" {
	" Keep cursor in the same column for JK motions
		let g:EasyMotion_startofline = 0
	" Matching target keys by smartcase.
		let g:EasyMotion_smartcase = 1
	let g:EasyMotion_use_upper = 1
	let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" }

" ******* (( ultisnips )) *******
" {
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
	" :UltiSnipsEdit splits the window.
		let g:UltiSnipsEditSplit="vertical"
	" Define directory for my personal snippets.
		let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" }

" ******* (( youcompleteme )) *******
" {
	let g:ycm_show_diagnostics_ui = 0		" To get (( syntastic )) working
	let g:ycm_complete_in_comments = 1
	let g:ycm_seed_identifiers_with_syntax = 1
	let g:ycm_key_list_select_completion = ['<Down>']
	let g:ycm_key_list_previous_completion = ['<Up>']
	let g:ycm_filetype_specific_completion_to_disable = {'vim': 1}
" }

" ******* (( gitgutter )) *******
" {
	let g:gitgutter_enabled = 0
" }

" ******* (( ctrlp & cie )) *******
" {
	let g:ctrlp_cache_dir = s:vimDir.'/various/ctrlp'
	let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30'
	let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
	let g:ctrlp_clear_cache_on_exit = 0
	let g:ctrlp_working_path_mode = 0
	let g:ctrlp_max_files = 0
	let g:ctrlp_max_depth = 40
	let g:ctrlp_follow_symlinks = 1
	let g:ctrlp_lazy_update = 1
	let g:ctrlp_cmdpalette_execute = 1
	" Open multiple files in hidden buffers.
		let g:ctrlp_open_multiple_files = 'i'
	" Open new file in the current window.
		let g:ctrlp_open_new_file = 'r'
	" Files to ignore in MRU mode.
		if has('win32') || has('win64')
			let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
		else
			let g:ctrlp_mruf_exclude = '^C:\\dev\\tmp\\.*'
		endif
	" Make available extensions.
		let g:ctrlp_extensions = ['funky']
" }

" ******* (( vim-plug )) *******
" {
	if has('win32') || has('win64')
		let g:plug_threads = 1
	else
		let g:plug_threads = 10
	endif
" }

" ******* (( vim-instant-markdown )) *******
" {
	let g:instant_markdown_slow = 1
	let g:instant_markdown_autostart = 0
" }

" ******* (( clever-f.vim )) *******
" {
	let g:clever_f_across_no_line = 1
	let g:clever_f_ignore_case = 1
	let g:clever_f_smart_case = 1
	" Fix a direction of search (f & F)
	let g:clever_f_fix_key_direction = 1
" }


" ******* (( zeavim )) *******
" {
	" let g:ZV_zeal_directory = ""
	" let g:ZV_disable_mapping = 1
	" let g:ZV_added_files_type = {
	"			\ 'extension': 'docset',
	"			\}
" }

" ******* (( vcoolor )) *******
" {
	let g:vcoolor_lowercase = 1
	" let g:vcoolor_map = {
	" 			\ 'h': ';c',
	" 			\ 'r': ';r',
	" 			\ 'v': ';v'
	" 			\ }
" }

" ******* (( termivator )) *******
" {
	let g:T_list_comm = {
				\ "cmder": {
					\ "w": "start \"C:\\Program Files\\cmder\\Cmder.exe\" /START" }
				\ }
" }
