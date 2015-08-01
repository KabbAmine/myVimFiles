" ========== Minimal vimrc without plugins (Unix & Windows) ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2015-08-02
" ================================================================


" ========== VARIOUS  ===========================================
set nocompatible		" No compatible with Vi.

" Load indentation rules and plugins according to the detected filetype {{{1
if has("autocmd")
	filetype plugin indent on
endif
" Enables syntax highlighting {{{1
if has("syntax")
	syntax on
endif
" What to write in Viminfo and his location {{{1
execute "set vi='100,<50,s10,h,n" . g:vimDir . "/various/viminfo"
" Add the file systags to the tags option {{{1
execute 'set tags+=' . g:vimDir . '/various/systags'
" Using a dark background {{{1
set background=dark
" General theme for tty {{{1
colo delek
" Disable Background Color Erase (BCE) so that color schemes work properly when Vim is used inside tmux and GNU screen. {{{1
if exists("$TMUX")
	set t_ut=
endif
" Tmux will send xterm-style keys when its xterm-keys option is on. {{{1
if &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
" Directory where to store files with :mkview. {{{1
execute 'set viewdir=' . g:vimDir . '/various/view'
" Make <Alt> works in terminal. {{{1
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endwhile
" }}}

" ========== GUI ===============================================
" {{{1
if has('gui_running')
	set guioptions-=T		" No toolbar in GVim.
	set guioptions-=m		" No menu in GVim.
	set guioptions-=e		" Apply normal tabline in Gvim.
	set guioptions-=L
	set guioptions-=l
	set wak=no				" Don't use the ALT-keys for menus.
	set linespace=5			" Number of pixel lines to use between lines.
	if g:hasWin
		set guifont=DejaVu_Sans_Mono_for_Powerline:h10:cANSI
	else
		set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Plus\ Nerd\ File\ Types\ 12
	endif
endif
" }}}

" ========== MESSAGES & INFO ===================================
" {{{1
set showcmd			" Show (partial) command in status line.
set ruler			" Show cursor position below each window.
" }}}

" ========== SELECT TEXT =========================================
" {{{1
" set clipboard=unnamedplus
" }}}

" ========== EDIT TEXT =========================================
" {{{1
set showmatch						" Show matching brackets.
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone,preview				" Use only a popup menu for Insert mode completion without preview.
set textwidth=0						" Don't insert automatically newlines
if g:hasWin
	set backspace=2					" Make backspace works normally in Win
endif
" }}}

" ========== DISPLAY TEXT ======================================
" {{{1
set number							" Show the line number for each line.
set linebreak						" Wrap long lines at a character in 'breakat'.
let &showbreak='░░░░ '				" String to put before wrapped screen lines.
set scrolloff=3						" Number of screen lines to show around the cursor.
set display=lastline				" Show the last line even if it doesn't fit.
" Make stars and bars visible
hi link HelpBar Normal
hi link HelpStar Normal
" Format of highlighting for tabs, whitespace... using 'list'.
if g:hasWin
	set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
else
	set listchars=tab:╎\ ,trail:•,extends:#,nbsp:.
endif
set list
" }}}

" ========== MOVE, SEARCH & PATTERNS ===========================
" {{{1
set ignorecase					" Do case insensitive matching.
set smartcase					" Do smart case matching.
set incsearch					" Incremental search.
set whichwrap=b,s,<,>,[,]		" List of flags specifying which commands wrap to another line.
" }}}

" ========== SYNTAX, HIGHLIGHTING AND SPELLING =================
" {{{1
if has('gui_running')
	set cursorline
endif
set hlsearch				" Highlight all matches for the last used search pattern.
set spelllang=fr			" List of accepted languages.
" }}}

" ========== TABS & INDENTING ==================================
" {{{1
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent			" Automatically set the indent of a new line.
set copyindent			" Copy whitespace for indenting from previous line.
" }}}

" ========== FOLDING ===========================================
" {{{1
set foldcolumn=1			" Width of the column used to indicate fold.
" }}}

" ========== COMMAND LINE EDITING ==============================
" {{{1
set wildmode=list:longest,full		" Command <Tab> completion, list matches, then longest common part, then all.
set wildmenu						" Command-line completion shows a list of matches with TAB.
" Enable the persistent undo.
if has('persistent_undo')
	execute 'set undodir =' . g:vimDir . '/various/undodir/'
	set undofile
endif
" }}}

" ========== MULTI-BYTE CHARACTERS =============================
" {{{1
set encoding=utf-8
" }}}

" ========== MULTIPLE WINDOWS ==================================
" {{{1
set splitright						" A new window is put right of the current one.
set laststatus=2					" 0, 1 or 2; when to use a status line for the last window.
set statusline=%<%f\ %y\ %h%m%r%a%=%-14.(%l,%c%V%)\ %P	" Alternate format to be used for a status line.
" }}}

" ========== SWAP FILE =========================================
" {{{1
" Set the swap file directories.
if g:hasWin
	execute 'set directory=' . g:vimDir . '\\various\\swap_dir,c:\\tmp,c:\\temp\\'
else
	execute 'set directory=' . g:vimDir . '/various/swap_dir,~/tmp,/var/tmp,/tmp\'
endif
" }}}

" =========== MAPPING ==========================================
" Remove the delay when escaping from insert-mode in terminal {{{1
if !has('gui_running')
	set timeoutlen=1000 ttimeoutlen=0
endif
" }}}

" =========== MAPPINGS ==========================================
" Text manipulation {{{1
" *** NORMAL & VISUAL MODE
	" *** <C-d>		=> Duplicate line.
" *** INSERT MODE
	" *** <A-d> => Duplicate line.
	" *** <A-o> => Insert new line.
	" *** <A-a> => Insert new line before.
vnoremap <silent> <C-d> :t'><CR>
nnoremap <silent> <C-d> yyp
inoremap <silent> <A-d> <Esc>mxyyp`x:delmarks x<CR>:sleep 100m<CR>a
inoremap <silent> <A-o> <C-o>o
inoremap <silent> <A-a> <C-o>O
" Apply the option 'only' {{{1
noremap <silent> gso :only<CR>
noremap <silent> <F5> :tabonly<CR>
" Open or close the fold {{{1
nnoremap <silent> <space> za
vmap <silent> <space> :fold<CR>
" Remove the highlighting of 'hlsearch' {{{1
nnoremap <silent> ghh :nohlsearch<CR>
" Operations on tabs {{{1
" *** <C-t>			=> New tab.
" *** <S-Tab>		=> Next tab.
map <silent> <C-t> :tabedit<CR>
map <silent> <S-Tab> gt
" Operations on buffers {{{1
" *** <S-h>		=> Previous.
" *** <S-l>		=> Next.
" *** <S-q>		=> Delete buffer.
nnoremap <silent> <S-h> :bp!<CR>
nnoremap <silent> <S-l> :bn!<CR>
nnoremap <silent> <S-q> :bd<CR>
" Repeat the last command {{{1
nnoremap zz @:
" JK for escape {{{1
inoremap jk <Esc>
vnoremap gk <Esc>
" For splits {{{1
nnoremap <silent> gsv <C-w>v
nnoremap <silent> gss <C-w>s
nnoremap <silent> gs= <C-w>=
nnoremap <silent> gsc <C-w>c
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <Up> <C-w>K
nnoremap <silent> <Down> <C-w>J
nnoremap <silent> <Right> <C-w>L
nnoremap <silent> <Left> <C-w>H
" For command line {{{1
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
" }}}

" =========== (AUTO)COMMANDS ==============================
" Make Y work as other capitals {{{1
nnoremap Y y$
" Make cursor line appear only in INSERT mode (Terminal only) {{{1
if !empty($TERM)
	autocmd InsertEnter * set cursorline
	autocmd InsertLeave * set nocursorline
endif
" Commands for manipulating directories and deleting files {{{1
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
" Define the file type {{{1
" *** :Ft <FileType>
command! -complete=filetype -nargs=1 Ft :set ft=<args>
" Specify indentation (ts,sts,sw) {{{1
" *** :Indent
command! Indent :call <SID>Indent()
function! <SID>Indent()
	let l:size_of_indentation = input('New indentation (' . &ts . ', ' . &sts . ', ' . &sw . ') => ')
	if(l:size_of_indentation !=# '')
		execute 'setlocal ts=' . l:size_of_indentation
		execute 'setlocal sts=' . l:size_of_indentation
		execute 'setlocal sw=' . l:size_of_indentation
	endif
endfunction
" Shortcuts for vim doc {{{1
" *** :Hl	=>	local-additions
" *** :Fl	=>	function-list
command! Hl :help local-additions
command! Fl :help function-list
" Change file type between PHP and HTML files {{{1
" *** :Ch
command! Ch :call <SID>Ch()
function! <SID>Ch()
	if &ft ==# 'php'
		setlocal ft=html
	elseif &ft ==# 'html'
		setlocal ft=php
	endif
endfunction
" Conversion between TABS ans SPACES {{{1
command! TabToSpace :setlocal expandtab | %retab!
command! SpaceToTab :setlocal noexpandtab | %retab!
" Make the current file directory as the vim current directory {{{1
command! Dir :cd %:p:h
" Set line highlighting only in current buffer/split {{{1
" http://superuser.com/a/393948
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
" Show syntax highlighting groups for word under cursor {{{1
" http://vimcasts.org/episodes/creating-colorschemes-for-vim/
command! GetSyntax :call <SID>SynStack()
function! <SID>SynStack()
	if !exists('*synstack')
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" =========== ABBREVIATIONS ==============================
" No more rage (Idea from a generated vimrc {{{1
" from http://vim-bootstrap.com/)
cab W! w!
cab Q! q!
cab QA! qa!
cab QA qa
cab Wq wq
cab wQ wq
cab WQ wq
cab W w
cab Q q
cab git Git
cab G Git
" }}}

" =========== OMNIFUNC ==============================
" Set omni-completion if the appropriate syntax file is present otherwise use the syntax completion {{{1
if has("autocmd") && exists("+omnifunc")
	autocmd! Filetype *
		\	if &omnifunc == "" |
		\		setlocal omnifunc=syntaxcomplete#Complete |
		\	endif
endif
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
