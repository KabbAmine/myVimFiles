" ========== Minimal vimrc without plugins (Unix & Windows) ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-02-21
" ================================================================


" ========== VARIOUS  ===========================================
" No compatible with Vi {{{1
set nocompatible
" Load indentation rules and plugins according to the detected filetype {{{1
if has('autocmd')
	filetype plugin indent on
endif
" Enables syntax highlighting {{{1
if has('syntax')
	syntax on
endif
" What to write in Viminfo and his location {{{1
if g:isNvim
	execute "set shada='100,<50,s10,h,n" . g:vimDir . "/various/shada"
else
	execute "set vi='100,<50,s10,h,n" . g:vimDir . "/various/viminfo"
endif
" Add the file systags to the tags option {{{1
execute 'set tags+=' . g:vimDir . '/various/systags'
" Using a dark background {{{1
set background=dark
" General theme for tty {{{1
colo delek
" Disable Background Color Erase (BCE) so that color schemes work properly when Vim is used inside tmux and GNU screen. {{{1
if exists('$TMUX')
	set t_ut=
endif
" Tmux will send xterm-style keys when its xterm-keys option is on. {{{1
if &term =~# '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
" Directory where to store files with :mkview. {{{1
execute 'set viewdir=' . g:vimDir . '/various/view'
" Make <Alt> works in terminal. {{{1
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !empty($TERM) && !g:isNvim
	let s:c = 'a'
	while s:c <=# 'z'
		exec 'set <A-' . s:c . '>=\e' . s:c
		exec 'inoremap \e' . s:c . ' <A-' . s:c . '>'
		let s:c = nr2char(1+char2nr(s:c))
	endwhile
	unlet s:c
endif
" }}}

" ========== OPTIONS  ===========================================
" ********* GUI {{{1
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
		" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 12
		set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
	endif
endif
" ********* Messages & info{{{1
set showcmd			" Show (partial) command in status line.
set ruler			" Show cursor position below each window.
" ********* Select text {{{1
" set clipboard=unnamedplus
" ********* Edit text {{{1
set showmatch						" Show matching brackets.
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu for Insert mode completion without preview.
set textwidth=0						" Don't insert automatically newlines
if g:hasWin
	set backspace=2					" Make backspace works normally in Win
endif
" ********* Display text {{{1
set number							" Show the line number for each line.
set linebreak						" Wrap long lines at a character in 'breakat'.
let &showbreak='░░░░ '				" String to put before wrapped screen lines.
set scrolloff=3						" Number of screen lines to show around the cursor.
set display=lastline				" Show the last line even if it doesn't fit.
set lazyredraw						" Don't redraw while executing macros
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
" ********* Move, search & patterns {{{1
set ignorecase					" Do case insensitive matching.
set smartcase					" Do smart case matching.
set incsearch					" Incremental search.
set whichwrap=b,s,<,>,[,]		" List of flags specifying which commands wrap to another line.
set magic
" ********* Syntax, highlighting and spelling {{{1
if has('gui_running')
	set cursorline
endif
set hlsearch				" Highlight all matches for the last used search pattern.
set spelllang=fr			" List of accepted languages.
set synmaxcol=200			" Max column to look for syntax items
" ********* Tabs & indenting {{{1
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent			" Automatically set the indent of a new line.
set copyindent			" Copy whitespace for indenting from previous line.
" ********* Folding {{{1
set foldcolumn=1			" Width of the column used to indicate fold.
" ********* Command line editing {{{1
set wildmode=list:longest,full		" Command <Tab> completion, list matches, then longest common part, then all.
set wildmenu						" Command-line completion shows a list of matches with TAB.
" Enable the persistent undo.
if has('persistent_undo')
	execute 'set undodir =' . g:vimDir . '/various/undodir/'
	set undofile
endif
" ********* Multi-byte characters {{{1
if !g:isNvim
	set encoding=utf-8
endif
" ********* Multiple windows {{{1
set splitright						" A new window is put right of the current one.
set laststatus=2					" 0, 1 or 2; when to use a status line for the last window.
set statusline=%<%f\ %y\ %h%m%r%a%=%-14.(%l,%c%V%)\ %P	" Alternate format to be used for a status line.
" ********* Swap file {{{1
" Set the swap file directories.
if g:hasWin
	execute 'set directory=' . g:vimDir . '\\various\\swap_dir,c:\\tmp,c:\\temp\\'
else
	execute 'set directory=' . g:vimDir . '/various/swap_dir,~/tmp,/var/tmp,/tmp\'
endif
" ********* Mapping {{{1
" Remove the delay when escaping from insert-mode in terminal
if !has('gui_running')
	set timeoutlen=1000 ttimeoutlen=0
endif
" ********* Multiple tab pages {{{1
set showtabline=1	" Only if there are at least 2 tabs
" }}}

" =========== MAPPINGS ==========================================
" Make Y work as other capitals {{{1
nnoremap Y y$
" Text manipulation {{{1
" *** NORMAL & VISUAL MODE
	" *** yd		=> Duplicate line.
" *** INSERT MODE
	" *** <A-d> => Duplicate line.
	" *** <A-o> => Insert new line.
	" *** <A-a> => Insert new line before.
function! <SID>Duplicate(...) abort " {{{2
	let l:ip = getpos('.') | silent .t. | call setpos('.', l:ip)
endfunction
" 2 }}}
nnoremap <silent> yd :call <SID>Duplicate()<CR>
vnoremap <silent> <C-d> :t'><CR>gv<Esc>
inoremap <silent> <A-d> <Esc>:call <SID>Duplicate()<CR>a
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
map <silent> <C-t> :tabedit<CR>
" Operations on buffers {{{1
" *** <S-h>		=> Previous.
" *** <S-l>		=> Next.
" *** <S-q>		=> Delete buffer.
nnoremap <silent> <S-h> :bp!<CR>
nnoremap <silent> <S-l> :bn!<CR>
" For this mapping, check NERDTree settings in config/plugins.vim
nnoremap <silent> <S-q> :bd<CR>
" Repeat the last command {{{1
nnoremap !z @:
" JK for escape {{{1
inoremap jk <Esc>
inoremap JK <Esc>
" For splits {{{1
nnoremap <silent> gsv <C-w>v
nnoremap <silent> gss <C-w>s
nnoremap <silent> gsnv :vnew<CR>
nnoremap <silent> gsns :split +enew<CR>
nnoremap <silent> gs= <C-w>=
nnoremap <silent> gsc <C-w>c
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-Up> <C-w>+
nnoremap <silent> <C-Down> <C-w>-
nnoremap <silent> <Up> <C-w>K
nnoremap <silent> <Down> <C-w>J
nnoremap <silent> <Right> <C-w>L
nnoremap <silent> <Left> <C-w>H
" For command line {{{1
cnoremap jk <C-c>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-j> <C-Left>
cnoremap <C-k> <C-Right>
cnoremap <C-l> <Del>
" Sort in VISUAL mode {{{1
vnoremap <leader>s :!sort<CR>
nnoremap <leader>s <Esc>:setlocal operatorfunc=<SID>Sort<CR>g@
function! <SID>Sort(...) abort
	let l:cmd = printf('%d,%d:!sort', line("'["), line("']"))
	execute l:cmd
endfunction
" Show syntax highlighting group for word under cursor {{{1
nnoremap gsy :echo synIDattr(synID(line('.'), col('.'), 1), "name")<CR>
" Move by paragraph ({ & } are quite difficult to reach azerty) {{{1
nnoremap J }
nnoremap K {
" Make j and k move to the next row, not file line {{{1
nnoremap j gj
nnoremap k gk
" Mappings for location/quickfix list window {{{1
nnoremap <C-F3> :lprevious<CR>
nnoremap <C-F4> :lnext<CR>
nnoremap <S-F3> :cprevious<CR>
nnoremap <S-F4> :cnext<CR>
" TIPS from https://github.com/mhinz/vim-galore {{{1
" n/N always search forward/backward {{{2
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
" Quickly edit macro or register content in scmdline-window {{{2
" "q\r
nnoremap <leader>r :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" 2}}}
" Open URL {{{1
let g:netrw_nogx = 1
nnoremap <silent> gx :call <SID>OpenURL()<CR>
function! <SID>OpenURL() abort " {{{2
	" Open the current URL
	" - If line begins with "Plug" or "call s:PlugInOs", open the github page of the plugin

	let l:cl = getline('.')
	let l:url = matchstr(l:cl, '[a-z]*:\/\/[^ >,;]*')
	if l:cl =~# 'Plug' || l:cl =~# 'call s:PlugInOs'
		let l:pn = l:cl[match(l:cl, "'", 0, 1) + 1 : match(l:cl, "'", 0, 2) - 1]
		let l:url = printf('https://github.com/%s', l:pn)
	endif
	if !empty(l:url)
		let l:url = substitute(l:url, "'", '', 'g')
		let l:wmctrl = executable('wmctrl') && v:windowid !=# 0 ?
					\ ' && wmctrl -ia ' . v:windowid : ''
		exe 'silent :!' . (g:hasUnix ?
						\ 'x-www-browser ' . l:url :
						\ 'start cmd /c ' . l:url)
					\ . l:wmctrl
					\ . (has('unix') ? ' &' : '')
		if !has('gui_running') | redraw! | endif
	endif
endfunction
" 2}}}
" For marks {{{1
nnoremap <silent> m<space> :delmarks!<CR>
" Open here terminal/file manager {{{1
nnoremap <silent> ;t   :call <SID>OpenHere('t')<CR>
nnoremap <silent> ;;t  :call <SID>OpenHere('t', expand('%:h:p'))<CR>
nnoremap <silent> ;f   :call <SID>OpenHere('f')<CR>
nnoremap <silent> ;;f  :call <SID>OpenHere('f', expand('%:h:p'))<CR>
function! <SID>OpenHere(type, ...) abort " {{{2
	" type: (t)erminal, (f)ilemanager
	" a:1: Location (pwd by default)
	let l:cmd = {
				\ 't': (has('unix') ?
					\ 'exo-open --launch TerminalEmulator --working-directory %s &' :
					\ 'start cmd /k cd %s'),
				\ 'f': (has('unix') ?
					\ 'xdg-open %s &' :
					\ 'start explorer %s')
				\ }
	execute printf('silent !' . l:cmd[a:type], (exists('a:1') ? a:1 : getcwd()))
endfunction " 2}}}
" Move current line or visual selection {{{1
nnoremap <silent> <A-k> :call <SID>Move(-1)<CR>
nnoremap <silent> <A-j> :call <SID>Move(1)<CR>
vnoremap <silent> <A-k> :call <SID>Move(-1)<CR>gv
vnoremap <silent> <A-j> :call <SID>Move(1)<CR>gv
function! <SID>Move(to) range " {{{2
	" a:to : -1/1 <=> up/down
	let fl = a:firstline | let ll = a:lastline
	execute printf(':%d,%dm%d', fl, ll, (a:to ==# -1 ? fl - 2 : ll + 1))
endfunction " 2}}}
" }}}

" =========== (AUTO)COMMANDS ==============================
" Make cursor line appear only in INSERT mode (Terminal only) {{{1
if !empty($TERM)
	augroup term
		autocmd!
		autocmd InsertEnter * set cursorline
		autocmd InsertLeave * set nocursorline
	augroup END
endif
" Commands for manipulating directories and deleting files {{{1
" *** :Mkdir => Create directory(ies) (Or directories recursively)
" *** :Rm    => Delete file(s) or directory(ies)
command! -nargs=+ -complete=file Mkdir :call <SID>MakeDir(<f-args>)
command! -nargs=+ -complete=file Rm    :call <SID>Delete(<f-args>)
function! <SID>Delete(...) abort
	for l:f in a:000
		if filereadable(l:f)
			if delete(l:f) ==# 0
				echohl Statement | echo l:f . ' was deleted' | echohl None
			endif
		elseif isdirectory(l:f)
			let l:cmd = g:hasUnix ?
						\ 'rm -vr %s' :
						\ 'RD /S %s'
			echo system(printf(l:cmd, escape(l:f, ' ')))
		endif
	endfor
endfunction
function! <SID>MakeDir(...) abort
	for l:d in a:000
		if !isdirectory(l:d)
			call mkdir(l:d, 'p')
			echohl Statement | echo l:d . '/ was created' | echohl None
		else
			echohl Error | echo l:d . '/ exists already' | echohl None
		endif
	endfor
endfunction
" 2}}}
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
command! Hl :help local-additions
command! Fl :help function-list
" Change file type between PHP and HTML files {{{1
command! Ch :execute 'setf ' . (&ft ==# 'php' ? 'html' : 'php')
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
" Write to file with sudo (Linux only) {{{1
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
if g:hasUnix
	command! Sw :w !sudo tee % >/dev/null
endif
" Set spelllang & spell in one command {{{1
command! -nargs=? Spell call s:Spell(<f-args>)
fun! s:Spell(...) abort
	let l:l = exists('a:1') ? a:1 : 'fr'
	execute 'setlocal spelllang=' . l:l
	setlocal spell!
endfun
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
" }}}

" =========== OMNIFUNC ==============================
" Set omni-completion if the appropriate syntax file is present otherwise use the syntax completion {{{1
augroup omni
	autocmd!
	if has('autocmd') && exists('+omnifunc')
		autocmd! Filetype *
					\ if &omnifunc ==# '' |
					\	setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	endif
augroup END
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
