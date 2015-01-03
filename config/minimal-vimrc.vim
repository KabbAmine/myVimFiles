" ========== Minimal vimrc without plugins (Unix & Windows) ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2015-01-02
" ================================================================


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
	execute "set vi='100,<50,s10,h,n".g:vimDir."/various/viminfo"

" Add the file systags to the tags option.
	execute "set tags+=".g:vimDir."/various/systags"

" Using a dark background.
	set background=dark

" General theme for tty
	colo delek

" Disable Background Color Erase (BCE) so that color schemes work properly when Vim is used inside tmux and GNU screen.
" {
	if exists("$TMUX")
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
	execute "set viewdir=".g:vimDir."/various/view"

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
	" Activate horizontal bottom scrollbar for each line.
	" set guioptions+=bh		
	if g:hasWin
		set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
	else
		" set guifont=Monospace\ 10
		set guifont=Ubuntu\ Mono\ derivative\ powerline\ 12
	endif
	set wak=no				" Don't use the ALT-keys for menus.
	set linespace=5			" Number of pixel lines to use between lines.
endif


" ========== MESSAGES & INFO ===================================
set showcmd			" Show (partial) command in status line.
set ruler			" Show cursor position below each window.

" ========== SELECT TEXT =========================================
" set clipboard=unnamedplus

" ========== EDIT TEXT =========================================
set showmatch						" Show matching brackets.
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu for Insert mode completion without preview.
if g:hasWin
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
	if g:hasWin
		set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
	else
		set listchars=tab:╎\ ,trail:•,extends:#,nbsp:.
	endif
" }
set list


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
	execute "set undodir =".g:vimDir."/various/undodir/"
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
if g:hasWin
	execute "set directory=".g:vimDir."\\various\\swap_dir,c:\\tmp,c:\\temp\\"
else
	execute "set directory=".g:vimDir."/various/swap_dir,~/tmp,/var/tmp,/tmp\""
endif


" =========== MAPPING ==========================================
" Text manipulation *******
" {
	" *** NORMAL & VISUAL MODE
		" *** <C-d>		=> Duplicate line.
	" *** INSERT MODE
		" *** <A-d> => Duplicate line.
		" *** <A-q> => Delete line.
		" *** <A-o> => Insert new line.
		" *** <A-a> => Insert new line before.
		" *** <A-"> => Change inside ", ', (, ...
			vnoremap <silent> <C-d> :t'><CR>
			nnoremap <silent> <C-d> yyp
			inoremap <silent> <A-d> <Esc>mxyyp`x:delmarks x<CR>:sleep 100m<CR>a
			inoremap <silent> <A-$> <C-o>d$
			inoremap <silent> <A-q> <C-o>$<C-u>
			inoremap <silent> <A-o> <C-o>o
			inoremap <silent> <A-a> <C-o>O
			inoremap <silent> <A-'> <C-o>ci'
			inoremap <silent> <A-"> <C-o>ci"
			inoremap <silent> <A-(> <C-o>ci(
			inoremap <silent> <A-{> <C-o>ci{
			inoremap <silent> <A-[> <C-o>ci[
" }

" Apply the option 'only' *******
" {
	" *** <F5>		=> For a splitted window.
	" *** <S-F5>	=> For a tab.
		nmap <silent> <F5> :only<CR>
		nmap <silent> <S-F5> :tabonly<CR>
" }

" Open or close the fold *******
" {
	nnoremap <silent> <space> za
	vmap <silent> <space> :fold<CR>
" }

" Remove the highlighting of 'hlsearch' *******
	map <silent> <F6> :nohlsearch<CR>

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
	" *** <C-q>				=> Delete buffer.
		map <silent> <C-S-left> :bp!<CR>
		map <silent> <C-S-right> :bn!<CR>
		nnoremap <silent> <C-q> :bd<CR>
" }

" Repeat the last command *******
	nnoremap zz @:


" =========== COMMANDS ==============================

" Make Y work as other capitals.
	nnoremap Y y$

" Make cursor line appear only in INSERT mode (Terminal only)
" {
	if !empty($TERM)
		autocmd InsertEnter * set cursorline
		autocmd InsertLeave * set nocursorline
	endif
" }


" Commands for manipulating directories and deleting files *******
" {
	" *** :CreD		=> Create directory(ies) (Or directories recursively)
	" *** :SCreD	=> Same as last command but with high privileges (Unix).
	" *** :DelD		=> Delete directory(ies) in windows.
	" *** :DelF		=> Delete file(s) in windows.
	" *** :Del		=> Delete file(s) or folder(s).
		if g:hasWin
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
	autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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
	command! TabToSpace :setlocal expandtab | %retab!
	command! SpaceToTab :setlocal noexpandtab | %retab!
" }

" Make the current file directory as the vim current directory *******
	command! Dir :cd %:p:h


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
" }
