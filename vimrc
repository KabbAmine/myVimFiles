" ========== $MYVIMRC (Unix & Windows) ===========================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2014-05-26
" ================================================================


" Stock the Location of vim's folder in a global variable.
" {
	if has('win32') || has('win64')
		let g:vimDir = "$HOME/vimfiles"
	else
		let g:vimDir = "$HOME/.vim"
	endif
" }


" ========== VUNDLE ==============================================

set nocompatible		" No compatible with Vi.
filetype off			" Required for (( vundle )) !

" Let Vundle manage Vundle
execute "set rtp+=".vimDir."/bundle/Vundle.vim"

if has ('win32') || has('win64')
	call vundle#begin('$HOME/vimfiles/bundle/')
else
	call vundle#begin()
endif

Plugin 'gmarik/Vundle.vim'

" My Plugins:
" " {
 	" For PHP
 		Plugin 'PHP-correct-Indenting'
 		Plugin 'StanAngeloff/php.vim'
 	" For HTML/CSS
 		Plugin 'ap/vim-css-color'
 		Plugin 'jaxbot/brolink.vim.git'
		Plugin 'cakebaker/scss-syntax.vim'
 		Plugin 'hail2u/vim-css3-syntax.git'
 		Plugin 'mattn/emmet-vim'
 		Plugin 'othree/html5.vim'
 		Plugin 'plasticboy/vim-markdown'
 		" Plugin 'Valloric/MatchTagAlways'
 	" For JavaScript
 		Plugin 'pangloss/vim-javascript'
 	" For Python
 		" Plugin 'hdima/python-syntax'
 		" Plugin 'rkulla/pydiction'
 	" For Java
 		" Plugin 'javacomplete'
 	" For (( fuzzyfinder ))
		Plugin 'FuzzyFinder'
		Plugin 'L9'
 	" For (( ultisnips ))
		Plugin 'SirVer/ultisnips'
		Plugin 'honza/vim-snippets'
 	" For (( airline ))
		Plugin 'bling/vim-airline'
		Plugin 'edkolev/tmuxline.vim'
	" For (( nerdtree ))
		Plugin 'ivalkeen/nerdtree-execute'
		Plugin 'markgandolfo/nerdtree-wget.vim'
		Plugin 'scrooloose/nerdtree'
 	" Various
 		Plugin 'AndrewRadev/splitjoin.vim'
 		Plugin 'godlygeek/tabular'
		Plugin 'airblade/vim-gitgutter'
 		Plugin 'kshenoy/vim-signature'
 		Plugin 'Lokaltog/vim-easymotion'
 		Plugin 'majutsushi/tagbar'
 		Plugin 'matchit.zip'
 		Plugin 'mbbill/undotree'
 		Plugin 'Raimondi/delimitMate'
 		Plugin 'scrooloose/syntastic'
 		Plugin 'sk1418/Join'
 		Plugin 't9md/vim-textmanip'
 		Plugin 'terryma/vim-multiple-cursors'
 		Plugin 'tomtom/tcomment_vim'
 		Plugin 'tpope/vim-surround'
		Plugin 'Valloric/YouCompleteMe'
 	" Colorschemes
		Plugin 'chriskempson/base16-vim'
		Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
 		Plugin 'jnurmine/Zenburn'
 		Plugin 'morhetz/gruvbox'
 		Plugin 'nanotech/jellybeans.vim'
 		Plugin 'noahfrederick/vim-hemisu'
 		Plugin 'reedes/vim-colors-pencil'
 		Plugin 'sjl/badwolf'
 		Plugin 'w0ng/vim-hybrid'
 		Plugin 'Wombat'
 		Plugin 'zeis/vim-kolor'
 	" My Plugins
		Plugin 'KabbAmine/zeavim.vim'
 " }

call vundle#end()
filetype plugin indent on


" ========== VARIOUS  ===========================================
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
execute "set vi='100,<50,s10,h,n".vimDir."/various/viminfo"

" Add the file systags to the tags option.
execute "set tags+=".vimDir."/various/systags"

" Using a dark background.
set background=dark

" Theme & number of colors.
" {
	if has ('win32') || has('win64')
		colorscheme hybrid
	else
		colorscheme Tomorrow-Night
	endif
	" set t_Co=256
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

" " Change color of cursor in INSERT mode terminal
" " {
" 	if (&term =~ "^screen") || (&term =~ "^xterm")
" 		" Use an orange cursor in insert mode
" 		let &t_SI = "\<Esc>]12;orange\x7"
" 		" Use a green cursor otherwise
" 		let &t_EI = "\<Esc>]12;green\x7"
" 		" Reset cursor when vim exits
" 		autocmd VimLeave * silent !echo -ne "\033]112\007"
" 	endif
" " }


" ========== GUI ===============================================
if has("gui_running")
	set guioptions-=T		" No toolbar in GVim.
	set guioptions-=m		" No menu in GVim.
	set guioptions-=e		" Apply normal tabline in Gvim.
	set guioptions-=L
	set guioptions-=l
	if has("win32") || has('win64')
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
set backspace=indent,eol,start		" Specifies what <BS>, CTRL-W, etc. can do in Insert mode.
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu for Insert mode completion without preview.


" ========== DISPLAY TEXT ======================================
set number							" Show the line number for each line.
" set breakat=\ \ !@*-+;:,./?			" Which characters might cause a line break
set linebreak						" Wrap long lines at a character in 'breakat'.
let &showbreak='░░░░ '				" String to put before wrapped screen lines.
set scrolloff=3						" Number of screen lines to show around the cursor.
set display=lastline				" Show the last line even if it doesn't fit.
" Make stars and bars visible
" {
	set conceallevel=0				" Controls whether concealable text is hidden.
	hi link HelpBar Normal
	hi link HelpStar Normal
" }
" Format of highlighting for tabs, whitespace... using 'list'.
" {
	if has ('win32') || has('win64')
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


" ========== MOUSE =============================================
set mouse=a		" Enable mouse usage (all modes).


" ========== SYNTAX, HIGHLIGHTING AND SPELLING =================
set cursorline				" Highlight the screen line of the cursor.
" set cursorcolumn			" Highlight the screen column of the cursor.
set hlsearch				" Highlight all matches for the last used search pattern.
set spelllang=fr			" List of accepted languages.


" ========== READ & WRITE FILES ================================
set writebackup				" Write a backup file before overwriting a file.
" set backupext=.backup		" File name extension for the backup file.


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
set foldmethod=manual		" Folding type: 'manual', 'indent', 'expr', 'marker' or 'syntax'.
" set foldlevel=4			" Folds with a level higher than this number will be closed.
" set foldenable			" Folds are open by default


" ========== MULTIPLE TAB PAGES ================================
"set showtabline=1		" 0, 1 or 2; when to use a tab pages line.


" ========== COMMAND LINE EDITING ==============================
set wildmode=list:longest,full		" Command <Tab> completion, list matches, then longest common part, then all.
set wildmenu						" Command-line completion shows a list of matches with TAB.
" Enable the persistent undo.
if has("persistent_undo")
	execute "set undodir =".vimDir."/various/undodir/"
	set undofile
endif


" ========== MULTI-BYTE CHARACTERS =============================
set encoding=utf-8


" ========== MULTIPLE WINDOWS ==================================
set equalalways						" Make all windows the same size when adding/removing windows.
set eadirection=both				" In which direction 'equalalways' works: 'ver', 'hor' or 'both'.
set splitright						" A new window is put right of the current one.
set laststatus=2					" 0, 1 or 2; when to use a status line for the last window.
set statusline=%<%f\ %y\ %h%m%r%a%=%-14.(%l,%c%V%)\ %P	" Alternate format to be used for a status line.


" ========== TERMINAL ==========================================
" set title			" Show info in the window title.


" ========== SWAP FILE =========================================
" Set the swap file directories.
if has ('win32') || has('win64')
	execute "set directory=".vimDir."\\various\\swap_dir,c:\\tmp,c:\\temp\\"
else
	execute "set directory=".vimDir."/various/swap_dir,~/tmp,/var/tmp,/tmp\""
endif


" =========== MAPPING ==========================================
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
		inoremap <silent> <c-space> <c-x><c-o><c-p>
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
	" *** <F3>		=> Previous.
	" *** <F3>		=> Next. 
	" *** <C-q>		=> Delete buffer.
		map <silent> <F3> :bp!<CR>
		map <silent> <F4> :bn!<CR>
		nnoremap <silent> <C-q> :bd<CR>
" }

" Operations on current buffer (Move between errors) *******
" {
	" *** <c-F3>	=> lprevious.
	" *** <c-F4>	=> lnext.
		nmap <silent> <c-F3> :lprevious<CR>
		nmap <silent> <c-F4> :lnext<CR>
" }

" (( brolink )) shortcuts *******
" {
	" *** <C-F5>	=> Reload page
		nmap <silent> <C-f5> :BLReloadPage<CR>
" }

" (( FuzzyFinder )) shortcuts *******
" {
	" *** F2		=> FufBuffer
	" *** ,r		=> FufMruFile
	" *** ,c		=> FufMruCmd
	" *** ,f		=> FufFile
	" *** ,,f		=> FufCoverageFile
	" *** ,d		=> FufDir
	" *** ,t		=> FufBufferTag
	" *** ,b		=> FufBookmarkDir
	" *** ,l		=> FufLine
	" *** ,h		=> FufHelp
		nmap <silent> <F2> :FufBuffer<CR>
		nmap <silent> ,f :FufFile<CR>
		nmap <silent> ,r :FufMruFile<CR>
		nmap <silent> ,c :FufMruCmd<CR>
		nmap <silent> ,,f :FufCoverageFile<CR>
		nmap <silent> ,d :FufDir<CR>
		nmap <silent> ,t :FufBufferTag<CR>
		nmap <silent> ,b :FufBookmarkDir<CR>
		nmap <silent> ,l :FufLine<CR>
		nmap <silent> ,h :FufHelp!<CR>
" }

" (( ultisnips )) *******
" {
	" <C-F2>		=> Open the custom snippet file of the current file.
		nmap <C-F2> :UltiSnipsEdit<CR>
" }

" (( textmanip )) *******
" {
	" *** \t				=> Toggle insert/replace modes.
	" *** <Alt-direction>	=> Move selection.
		nmap <silent> <leader>t <Plug>(textmanip-toggle-mode)
		xmap <silent> <M-Down> <Plug>(textmanip-move-down)
		xmap <silent> <M-Up> <Plug>(textmanip-move-up)
		xmap <silent> <M-Left> <Plug>(textmanip-move-left)
		xmap <silent> <M-Right> <Plug>(textmanip-move-right)
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
	" *** <F8>		=> SyntasticToggleMode.
	" *** <c-F8>	=> SyntasticReset
	" *** ,E		=> Errors: Display an errors window.
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
	" *** \S				=> Split code.
	" *** \J				=> Join code.
		" Disable the default mapping.
			let g:splitjoin_split_mapping = ''
			let g:splitjoin_join_mapping = ''
		nmap <Leader>j :SplitjoinJoin<cr>
		nmap <Leader>s :SplitjoinSplit<cr>
" }


" =========== COMMANDS ==============================
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

" Open a terminal with tmux in the current directory
" {
	" *** :Term
	fun! Term()
		let currentDir = getcwd()
		execute "silent :!xfce4-terminal --working-directory=\"".currentDir."\" -x tmux -2 &"
		unlet currentDir
	endf
	command! Term :call Term()
" }

" Commands for manipulating directories and deleting files *******
" {
	" *** :CreD		=> Create directory(ies) (Or directories recursively)
	" *** :SCreD	=> Same as last command but with high privileges (Unix).
	" *** :DelD		=> Delete directory(ies) in windows.
	" *** :DelF		=> Delete file(s) in windows.
	" *** :Del		=> Delete file(s) or folder(s).
	if has ('win32') || has('win64')
		command! -complete=file -nargs=+ CreD :!MD <args>
		command! -complete=file -nargs=+ DelD :!RD /S <args> 
		command! -complete=file -nargs=+ DelF :!DEL /P <args> 
	else
		command! -complete=file -nargs=+ CreD :!mkdir -pv <args> 
		command! -complete=file -nargs=+ SCreD :!sudo mkdir -pv <args> 
		command! -complete=file -nargs=+ Del :!rm -Irv <args> 
	endif
" }

" Short commands for (( vundle ))
" {
	" *** :VI			   => Install new plugins.
	" *** :VU			   => Update all plugins.
	" *** :VL			   => List all plugins.
	" *** :VS (scriptName) => Search vim-scripts in the repos
	" *** :VC			   => Clean the plugins. directory.
		command! VI :PluginInstall
		command! VU :PluginUpdate
		command! VL :PluginList
		command! -nargs=? VS :PluginSearch! <args>
		command! VC :PluginClean
" }

" Define the file type *******
" {
	" *** :Ft <FileType>
	command! -complete=filetype -nargs=1 Ft :set ft=<args>
" }

" Reload the localhost in saving scss files using (( brolink ))
" {
	" autocmd! BufWritePre,FileWritePre *.scss :BLReloadPage
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

" Open the help of local-additions *******
" {
	" *** :Hl
		command! Hl :help local-additions
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

" Toggle (( gitgutter )) *******
" {
	" *** :GG
		command! GG :GitGutterToggle
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
	" Files to ignore in 'FufCoverageFile' (All files in current directory).
		let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|\.(png|jpg|jpeg|gif|xcf|svg)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|\.(cbp|depend)$'
	" Enable all the modes (MRU mode was disabled).
		let g:fuf_modesDisable = []
	" Maximum number of MRU stored items.
		let g:fuf_mrufile_maxItem = 40
	" Separator for a primary and refining patterns.
		let g:fuf_patternSeparator = '+'
	" Cancel the <Ctrl-s> shortcut to use it in next command.
		let g:fuf_keyPrevPattern = ''	
	" Open it in horizontal split with <Ctrl-s>
		let g:fuf_keyOpenSplit = '<C-s>'
	" Open it in vertical split with <Ctrl-v>
		let g:fuf_keyOpenVsplit = '<C-v>'
	" Cancel the <Ctrl-t> shortcut to use it in next command.
		let g:fuf_keyNextMode = '<>'
	" Open it in a tab with <Ctrl-t>
		let g:fuf_keyOpenTabpage = '<C-t>'
	" Define the directory for data files.
		execute "let g:fuf_dataDir = '".vimDir."/various/fuf-data/'"
" }

" ******* (( NERDTree )) *******
" {
	" Where bookmarks are stored.
		if has ('win32') || has('win64')
			let NERDTreeBookmarksFile='C:\Users\k-bag\vimfiles\various\NERDTreeBookmarks'
		else
			let NERDTreeBookmarksFile='/home/k-bag/.vim/various/NERDTreeBookmarks'
		endif
	" Ignore the following files.
		let NERDTreeIgnore=['\~$', '\.class$']
	" Show the bookmarks in the startup.
		" let NERDTreeShowBookmarks=1
	" Remove a buffer when a file is being deleted or renamed.
		let NERDTreeAutoDeleteBuffer=1
	" Single-clic for folder nodes and double for files.
		let NERDTreeMouseMode=2
	" Arrows for the directories.
		let NERDTreeDirArrows=1
" }

" " ******* (( pydiction )) *******
" " {
" 	execute "let g:pydiction_location = '".vimDir."/bundle/pydiction/complete-dict'"
" 	let g:pydiction_menu_height = 20
" " }

" " ******* (( python-syntax )) *******
" 	let python_highlight_all=1

" ******* (( tagbar )) *******
" {
	" Move the cursor to the tagbar window when it is opened.
		let g:tagbar_autofocus = 1
	" Sort the elements by the order of appearance.
		let g:tagbar_sort = 0
	" Define the ctags location for windows.
		if has ('win32') || has('win64')
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
	" Set theme.
		" let g:airline_theme='lucius'
	" Customization.
		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif
	" Automatically populate the symbols dictionary with the powerline symbols.
		let g:Powerline_symbols = 'fancy'
		let g:airline_powerline_fonts = 1
	" Tabline.
		" Enable/disable enhanced tabline.
			let g:airline#extensions#tabline#enabled = 1
		" Enable/disable displaying buffers with a single tab.
			let g:airline#extensions#tabline#show_buffers = 1
		" Configure the minimum number of buffers needed to show the tabline.
			let g:airline#extensions#tabline#buffer_min_count = 1
		" Configure the minimum number of tabs needed to show the tabline.
			let g:airline#extensions#tabline#tab_min_count = 1
		" Integration with tmux
			let g:airline#extensions#tmuxline#enabled = 1
			let airline#extensions#tmuxline#snapshot_file = "~/.dotfiles/tmux/tmux-statusline-colors.conf"

" }

" ******* (( markdown )) *******
" {
	" Disable folding.
		let g:vim_markdown_folding_disabled=1
" }

" ******* (( syntastic )) *******
" {
	" Set a specific checkers for some languages.
		let g:syntastic_html_checkers=['w3']
		let g:syntastic_xhtml_checkers=['tidy']
		let g:syntastic_css_checkers=['prettycss']
		let g:syntastic_python_checkers=['python']
		let g:syntastic_tex_checkers=['chktex']
		let g:syntastic_javascript_checkers=['jshint']
		" For sass
			let g:syntastic_filetype_map = { 'scss.css': 'scss' }
			let g:syntastic_scss_checkers=['sass']
	" Passive mode.
		let g:syntastic_mode_map = { 'mode': 'passive',
					\ 'active_filetypes': [],
					\ 'passive_filetypes': ['c', 'html', 'java', 'php', 'python', 'sh', 'tex', 'xhtml', 'javascript', 'sass', 'scss']}
" }

" ******* (( emmet )) *******
" {
	" Enable emmet for specific files.
		let g:user_emmet_install_global = 0
		autocmd FileType html,xhtml,scss,css,sass,php EmmetInstall
	" Set the leader key.
		let g:user_emmet_leader_key = '<c-e>'
" }

" ******* (( undotree )) *******
" {
	" Set focus to undotree after opening it.
		let g:undotree_SetFocusWhenToggle = 1
	" Undotree window in the right.
		let g:undotree_WindowLayout = 'botright'
	" Disable the bookmarks.
		let NERDTreeMinimalUI=1
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
	" Enables HTML/CSS syntax highlighting in your JavaScript file.
		let javascript_enable_domhtmlcss = 1
" }

" ******* (( easymotion )) *******
" {
	" Keep cursor in the same column for JK motions
		let g:EasyMotion_startofline = 0
	" Matching target keys by smartcase.
		let g:EasyMotion_smartcase = 1
	" Shows target labels with uppercase letters.
		let g:EasyMotion_use_upper = 1
		let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" }

" ******* (( ultisnips )) *******
" {
	" Trigger configuration.
		let g:UltiSnipsExpandTrigger="<tab>"
		let g:UltiSnipsJumpForwardTrigger="<tab>"
		let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
	" :UltiSnipsEdit splits the window.
		let g:UltiSnipsEditSplit="vertical"
	" Define directory for my personal snippets.
		" let g:UltiSnipsSnippetsDir= ".vim/mySnippets"
		let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" }

" ******* (( youcompleteme )) *******
" {
	  let g:ycm_min_num_of_chars_for_completion = 1
	  let g:ycm_key_list_select_completion = ['<Down>']
	  let g:ycm_key_list_previous_completion = ['<Up>']
" }

" ******* (( gitgutter )) *******
" {
	" Turn off the plugin by default.
		let g:gitgutter_enabled = 0
" }
	

" ******* (( zeavim )) *******
" {
	" let g:ZV_zeal_directory = ""
	" let g:ZV_added_files_type = {
	" 			\ 'extension': 'docset',
	" 			\}
" }
