" ========== Minimal vimrc without plugins (Unix & Windows) ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-08-26
" ================================================================

" ========== MISC  ===========================================
" Load indentation rules and plugins according to the detected filetype {{{1
filetype plugin indent on
" Enables syntax highlighting {{{1
syntax on
" What to write in Viminfo and his location {{{1
if g:isNvim
	execute "set shada='100,<50,s10,h,n" . g:vimDir . "/misc/shada"
else
	execute "set vi='100,<50,s10,h,n" . g:vimDir . "/misc/viminfo"
endif
" Add the file systags to the tags option {{{1
execute 'set tags+=' . g:vimDir . '/misc/systags'
" Using a dark background {{{1
set background=dark
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
execute 'set viewdir=' . g:vimDir . '/misc/view'
" Make <Alt> works in terminal. {{{1
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !empty($TERM) && !g:isNvim
	let s:c = 'a'
	while s:c <=# 'z'
		exec "set <A-" . s:c . ">=\e" . s:c
		exec "imap \e" . s:c . " <A-" . s:c . ">"
		let s:c = nr2char(1 + char2nr(s:c))
	endwhile
	unlet s:c
endif
" }}}

" ========== OPTIONS  ===========================================
" >>> GUI {{{1
let &guioptions = 'agirtc'
set winaltkeys=no	" Don't use ALT-keys for menus.
set linespace=5
let &guifont = g:hasWin ?
			\ 'InconsolataForPowerline NF Medium:h10:cANSI' :
			\ 'InconsolataForPowerline NF Medium 13'
" >>> Messages & info {{{1
set showcmd
set ruler
set confirm		" Start a dialog when a command fails
" >>> Edit text {{{1
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu for Insert mode completion without preview.
set textwidth=0						" Don't insert automatically newlines
if g:hasWin
	set backspace=2					" Make backspace works normally in Win
endif
set matchpairs+=<:>
" >>> Display text {{{1
set number
set linebreak
let &showbreak='⤷ '
set scrolloff=3			" Number of screen lines to show around the cursor.
set display=lastline	" Show the last line even if it doesn't fit.
set lazyredraw			" Don't redraw while executing macros
set breakindent			" Preserve indentation in wrapped text
" Make stars and bars visible
hi! link HelpBar Normal
hi! link HelpStar Normal
let &listchars = g:hasWin ?
			\ 'tab:| ,trail:~,extends:>,precedes:<' :
			\ 'tab:│ ,trail:•,extends:#,nbsp:.'
set list
" Scroll horizontally by 1 character (Only when wrap is disabled).
set sidescroll=1
" >>> Reading and writing files {{{1
set modeline
" >>> Move, search & patterns {{{1
set ignorecase
set smartcase
set incsearch					" Incremental search.
set whichwrap=b,s,<,>,[,]		" List of flags specifying which commands wrap to another line.
set magic
" >>> Running make and jumping to errors {{{1
if executable('ag')
	let &grepprg = 'ag --vimgrep $*'
	set grepformat=%f:%l:%c:%m
endif
" >>> Syntax, highlighting and spelling {{{1
set cursorline
set hlsearch
set spelllang=fr
set synmaxcol=200	" Max column to look for syntax items
" >>> Tabs & indenting {{{1
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent			" Automatically set the indent of a new line.
set copyindent			" Copy whitespace for indenting from previous line.
" >>> Folding {{{1
set foldcolumn=1	" Width of the column used to indicate fold.
" >>> Command line editing {{{1
set wildmode=list:longest,full		" Command <Tab> completion, list matches, then longest common part, then all.
set wildmenu						" Command-line completion shows a list of matches with TAB.
" Enable the persistent undo.
if has('persistent_undo')
	let &undodir = g:vimDir . '/misc/undodir/'
	set undofile
endif
" >>> Multi-byte characters {{{1
if !g:isNvim
	set encoding=utf-8
endif
" >>> Multiple windows {{{1
set splitright		" A new window is put right of the current one.
set hidden
" >>> Swap file {{{1
" Set the swap file directories.
let &directory = g:hasWin ?
			\ g:vimDir . '\\misc\\swap_dir,c:\\tmp,c:\\temp\\' :
			\ g:vimDir . '/misc/swap_dir,~/tmp,/var/tmp,/tmp\'
" >>> Mapping {{{1
" Remove the delay when escaping from insert-mode in terminal
if !g:hasGui
	set timeoutlen=1000 ttimeoutlen=0
endif
" >>> Executing external commands
" Use my own bash (functions, aliases...)
if g:hasGui
	let &shell = '/bin/bash -i'
endif
" }}}

" =========== DEFAULT PLUGINS ===================================
" Disable non-used default plugins {{{1
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_netrwPlugin = 1
let g:loaded_tarPlugin= 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
" }}}

" =========== MAPPINGS ==========================================
" >>> Make Y work as other capitals {{{1
nnoremap Y y$
" >>> Duplicate selection {{{1
" *** yd to duplicate line in NORMAL mode witout moving cursor
" *** <C-d> to duplicate selection in VISUAL mode.
nnoremap <silent> yd :call <SID>Duplicate()<CR>
vnoremap <silent> <C-d> :t'><CR>gv<Esc>
function! s:Duplicate() abort " {{{2
	let l:ip = getpos('.') | silent .t. | call setpos('.', l:ip)
endfunction " 2}}}
" >>> Apply the option 'only' {{{1
nnoremap <silent> gso :only<CR>
nnoremap <silent> <F5> :tabonly<CR>
" >>> Open or close the fold {{{1
nnoremap <silent> <space> za
vnoremap <silent> <space> :fold<CR>
" >>> Searching {{{1
nnoremap <silent> ghh :nohlsearch<CR>
" >>> Operations on tabs {{{1
nnoremap <silent> <C-t> :tabedit<CR>
" >>> Operations on buffers {{{1
nnoremap <silent> <S-h> :silent bp!<CR>
nnoremap <silent> <S-l> :silent bn!<CR>
nnoremap <silent> <BS> <C-^>
" For this mapping, check NERDTree settings in config/plugins.vim
nnoremap <silent> <S-q> :silent bw<CR>
" >>> Repeat the last command {{{1
nnoremap !z @:
" >>> JK for escape from INSERT & COMMAND modes {{{1
inoremap jk <Esc>
inoremap JK <Esc>
cnoremap jk <C-c>
" >>> For splits {{{1
nnoremap <silent> gsv <C-w>v
nnoremap <silent> gss <C-w>s
nnoremap <silent> gsnv :vnew<CR>
nnoremap <silent> gsns :split +enew<CR>
nnoremap <silent> gs= <C-w>=
nnoremap <silent> gsc <C-w>c
nnoremap <silent> <C-Up> <C-w>+
nnoremap <silent> <C-Down> <C-w>-
nnoremap <silent> <Up> <C-w>K
nnoremap <silent> <Down> <C-w>J
nnoremap <silent> <Right> <C-w>L
nnoremap <silent> <Left> <C-w>H
if g:hasGui
	nnoremap <silent> <c-h> <C-w><Left>
	nnoremap <silent> <c-j> <C-w><Down>
	nnoremap <silent> <c-k> <C-w><Up>
	nnoremap <silent> <c-l> <C-w><Right>
else
	nnoremap <silent> <c-h> :call <SID>TmuxMove('h')<CR>
	nnoremap <silent> <c-j> :call <SID>TmuxMove('j')<CR>
	nnoremap <silent> <c-k> :call <SID>TmuxMove('k')<CR>
	nnoremap <silent> <c-l> :call <SID>TmuxMove('l')<CR>
endif
" Move between splits & tmux " {{{2
" https://gist.github.com/mislav/5189704#gistcomment-1735600
function! s:TmuxMove(direction) abort
	let l:wnr = winnr()
	silent! execute 'wincmd ' . a:direction
	" If the winnr is still the same after we moved, it is the last pane
	if l:wnr ==# winnr()
		call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
	endif
endfunction " 2}}}
" >>> For command line {{{1
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-h> <C-Left>
cnoremap <C-l> <C-Right>
cnoremap <C-a> <Home>
" >>> Sort {{{1
vnoremap <silent> <leader>s :!sort<CR>
nnoremap <silent> <leader>s <Esc>:setlocal operatorfunc=<SID>Sort<CR>g@
function! s:Sort(...) abort
	execute printf('%d,%d:!sort', line("'["), line("']"))
endfunction
" >>> Move by paragraph ({ & } are quite difficult to reach in azerty layout) {{{1
nnoremap J }
nnoremap K {
" >>> Make j and k move to the next row, not file line {{{1
nnoremap j gj
nnoremap k gk
" >>> Mappings for quickfix/location list window {{{1
" Quickfix (G for global)
nnoremap <silent> Gn :call <SID>LocQuickWindow('c')<CR>zz
nnoremap <silent> Gp :call <SID>LocQuickWindow('c', 1)<CR>zz
" Location
nnoremap <silent> gn :call <SID>LocQuickWindow('l')<CR>zz
nnoremap <silent> gp :call <SID>LocQuickWindow('l', 1)<CR>zz
function! s:LocQuickWindow(type, ...) abort " 2{{{
	let l:cmd = a:type . (exists('a:1') ? 'previous' : 'next')
	let l:cmd2 = a:type . (exists('a:1') ? 'last' : 'first')
	try
		silent exe l:cmd
	catch /^Vim\%((\a\+)\)\=:\(E553\|E43\)/
		silent exe l:cmd2
	endtry
endfunction " 2}}}
" >>> Quickly edit macro or register content in scmdline-window {{{1
" (https://github.com/mhinz/vim-galore)
" e.g. "q\r
nnoremap <leader>r :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" >>> Open URL {{{1
nnoremap <silent> gx :call helpers#OpenUrl()<CR>
" >>> For marks {{{1
nnoremap <silent> m<space> :delmarks!<CR>
" >>> Open here terminal/file manager {{{1
nnoremap <silent> ;t   :call helpers#OpenHere('t')<CR>
nnoremap <silent> ;;t  :call helpers#OpenHere('t', expand('%:h:p'))<CR>
nnoremap <silent> ;f   :call helpers#OpenHere('f')<CR>
nnoremap <silent> ;;f  :call helpers#OpenHere('f', expand('%:h:p'))<CR>
" >>> Move current line or visual selection & auto indent {{{1
nnoremap <silent> <A-k> :call <SID>Move(-1)<CR>==
nnoremap <silent> <A-j> :call <SID>Move(1)<CR>==
vnoremap <silent> <A-k> :call <SID>Move(-1)<CR>gv=gv
vnoremap <silent> <A-j> :call <SID>Move(1)<CR>gv=gv
function! s:Move(to) range " {{{2
	" a:to : -1/1 <=> up/down

	let l:fl = a:firstline | let l:ll = a:lastline
	let l:to = a:to ==# -1 ?
				\ l:fl - 2 :
				\ (l:ll + 1 >=# line('$') ? line('$') : l:ll + 1)
	execute printf(':%d,%dm%d', l:fl, l:ll, l:to)
	let l:cl = line('.')
	if foldlevel(l:cl) !=# 0
		execute 'normal! ' . repeat('za', foldlevel(l:cl))
	endif
endfunction " 2}}}
" >>> Mimic multiple cursor behavior with <C-n>, useful with gn {{{1
" - \V literal string (very no magic)
" - \C case match
" - Use register x in visual mode
nnoremap <C-n> *N
vnoremap <C-n> "xy/\V\C<C-r>x<CR>N
" >>> Use c for manipulating + register {{{1
nnoremap cd "+d
nnoremap cp "+p
nnoremap cP "+P
nnoremap cy "+y
nnoremap cY "+y$
vnoremap Cd "+d
vnoremap Cp "+p
vnoremap CP "+P
vnoremap Cy "+y
" >>> Text objects {{{1
" All ***
"	- ie         : Entire file
"	- il         : Current line without whitespace
"	- i{X}/a{X}  : Inside/around {X}
"					* dots
"					* commas
"					* underscores
"					* stars
"					* #, :, +, -, /, =
" Scss/Css ***
"	 - iV     : Value
"	 - iP     : Property
"	 - if/af  : Inside/around a selector block
" Sh ***
"	 - if/af  : Inside/around a function
let s:to = {
			\	'_' : [
			\			['ie', 'ggVG'],
			\			['il', '^vg_'],
			\			['i.', 'F.WvEf.ge'],
			\			['a.', 'F.vEf.'],
			\			['i_', 'T_vt_'],
			\			['a_', 'F_vf_'],
			\			['i*', 'T*vt*'],
			\			['a*', 'F*vf*'],
			\			['i,', 'T,vt,'],
			\			['a,', 'F,vf,'],
			\			['i#', 'T#vt#'],
			\			['a#', 'F#vf#'],
			\			['i:', 'T:vt:'],
			\			['a:', 'F:vf:'],
			\			['i+', 'T+vt+'],
			\			['a+', 'F+vf+'],
			\			['i-', 'T-vt-'],
			\			['a-', 'F-vf-'],
			\			['i/', 'T/vt/'],
			\			['a/', 'F/vf/'],
			\			['i=', 'T=vt='],
			\			['a=', 'F=vf='],
			\	],
			\	'scss,css' : [
			\		['iV', '^f:wvt;'],
			\		['iP', '^f:Bvt:'],
			\		['if', '][kvi{V'],
			\		['af', '][kva{Vo[]j'],
			\	],
			\	'sh' : [
			\		['if', 'vi{V'],
			\		['af', 'va{V'],
			\	]
			\ }
call helpers#MakeTextObjects(s:to)
unlet! s:to
" >>> Enable Paste when using <C-r> in INSERT mode {{{1
inoremap <silent> <C-r> <C-r><C-p>
" >>> Preview {{{1
nnoremap <silent> gP :Preview<CR>
vnoremap <silent> gP :Preview<CR>
nnoremap <silent> gaP :call helpers#AutoCmd('Preview', 'Preview', ['BufWritePost,InsertLeave,TextChanged,CursorHold,CursorHoldI'])<CR>
" >>> Search {{{1
nnoremap / /\v
nnoremap # #\v
nnoremap n nzz
nnoremap N Nzz
" >>> Toggle options {{{1
nnoremap <silent> <leader><leader>n :setl number!<CR>
nnoremap <silent> <leader><leader>w :setl wrap!<CR>
nnoremap <silent> <leader><leader>c :execute 'setl colorcolumn=' . (&cc ? '' : 81)<CR>
" >>> Grep {{{1
nnoremap ,,g :call <SID>Grep()<CR>
xnoremap <silent> ,,g :call <SID>Grep(1)<CR>
nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>GrepMotion<CR>g@
function! s:Grep(...) abort " {{{2
	if exists('a:1')
		let l:q = a:1 ==# 1 ?
					\	helpers#GetVisualSelection() :
					\	helpers#GetMotionResult()
	else
		echohl ModeMsg | let l:q = input('grep> ') | echohl None
	endif
	if !empty(l:q)
		silent exe "grep! '" . l:q . "'"
		botright copen 10
		wincmd p
		redraw!
	endif
endfunction
function! s:GrepMotion(...) abort " {{{2
	call <SID>Grep(2)
endfunction " 2}}}
" 1}}}

" =========== (AUTO)COMMANDS ==============================
" >>> Disable continuation of comments when using o/O {{{1
augroup FormatOpt
	autocmd!
	autocmd FileType * setl formatoptions-=o
augroup END
" >>> Indentation for specific filetypes {{{1
augroup Indentation
	autocmd!
	autocmd FileType coffee,html,css,scss,pug,vader,ruby,markdown
				\ setl ts=2 sts=2 sw=2 expandtab
	autocmd FileType python,json
				\ setl ts=4 sts=4 sw=4 expandtab
augroup END
" >>> Make cursor line appear only in active window {{{1
augroup CursorLine
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup END
" >>> Commands for folders & files {{{1
command! -nargs=+ -complete=file Mkdir  :call helpers#MakeDir(<f-args>)
command! -nargs=+ -complete=file Rm     :call helpers#Delete(<f-args>)
command! -nargs=1 -complete=file Rename :call helpers#Rename(<f-args>)
" >>> Specify indentation (ts,sts,sw) {{{1
command! Indent :call <SID>SetIndentation()
function! s:SetIndentation() abort " {{{2
	let l:indentation = input('New indentation (' . &ts . ', ' . &sts . ', ' . &sw . ') => ')
	if l:indentation !=# ''
		execute 'setl ts=' . l:indentation
		execute 'setl sts=' . l:indentation
		execute 'setl sw=' . l:indentation
	endif
endfunction " 2}}}
" >>> Shortcuts for vim doc {{{1
command! Hl :help local-additions
command! Fl :help function-list
" >>> Change file type between PHP and HTML files {{{1
augroup ChPhpHtml
	autocmd!
	autocmd FileType php,html command! -buffer Ch :execute 'setf ' . (&ft ==# 'php' ? 'html' : 'php')
augroup END
" >>> Conversion between TABS ans SPACES {{{1
command! TabToSpace :setlocal expandtab | %retab!
command! SpaceToTab :setlocal noexpandtab | %retab!
" >>> Make the current file directory as the vim current directory {{{1
command! Dir :cd %:p:h
" >>> Write to file with sudo (Linux only) {{{1
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
if g:hasUnix
	command! Sw :w !sudo tee % >/dev/null
endif
" >>> Set spelllang & spell in one command {{{1
command! -nargs=? Spell call <SID>SetSpell(<f-args>)
function! s:SetSpell(...) abort " {{{2
	let l:l = exists('a:1') ? a:1 : 'fr'
	execute 'setlocal spelllang=' . l:l
	setlocal spell!
endfunction " 2}}}
" >>> Enable marker folding for some ft {{{1
augroup AutoFold
	autocmd!
	autocmd BufEnter *.js,*.sh,*.css
				\ setlocal foldmethod=marker
				\| setlocal foldmarker=\ {,}
				\| normal! zR
augroup END
" >>> Use shiba with some file types {{{1
if executable('shiba')
	augroup Shiba
		autocmd!
		autocmd Filetype html,markdown command! -buffer Shiba :silent !shiba --detach %
	augroup END
endif
" >>> Cmus {{{1
if executable('cmus')
	let s:cmusCmds = {
				\	'play'      : 'p',
				\	'pause'     : 'u',
				\	'stop'      : 's',
				\	'next'      : 'n',
				\	'previous'  : 'r',
				\	'repeat'    : 'R',
				\	'shuffle'   : 'S',
				\ }
	command! -nargs=? -bar -complete=custom,<SID>CompleteCmus Cmus :call <SID>Cmus('<args>')
	function! s:Cmus(...) abort " {{{2
		let l:arg = exists('a:1') && !empty(get(s:cmusCmds, a:1)) ?
					\ get(s:cmusCmds, a:1) : 'u'
		silent call system('cmus-remote -' . l:arg)
		" Get the value of a:1 if it exists...
		let l:Q = filter(systemlist('cmus-remote -Q'), 'v:val =~# "^set " . a:1 . " "')
		" ... then show it
		if !empty(l:Q)
			echo l:Q[0][4:]
		endif
	endfunction " 2}}}
	function! s:CompleteCmus(A, L, P) abort " {{{2
		return join(keys(s:cmusCmds), "\n")
	endfunction " 2}}}
endif
" >>> Echo vim expression in a buffer __Echo__ {{{1
command! -nargs=* -complete=expression Echo :call <SID>Echo(<f-args>)
function! s:Echo(...) abort " {{{2
	let l:out = ''
	redir => l:out
	silent execute 'echo ' . join(a:000, '')
	redir END
	if !empty(l:out[1:])
		call helpers#OpenOrMove2Buffer('__Echo__', 'vim', 'sp')
		call setline(1, l:out[1:])
		wincmd p
	endif
endfunction " 2}}}
" >>> Preview buffer {{{1
" TODO: Find a way to execute vimscript.
command! -range=% Preview :call <SID>Preview(<line1>, <line2>)
function! s:Preview(start, end) abort " {{{2
	call helpers#ExecuteInBuffer('__Preview__', a:start, a:end, {
				\	'c'         : {'cmd': 'gcc -o %o.out %i.c', 'tmp': 1, 'exec': 1},
				\	'coffee'    : {'cmd': 'coffee -spb', 'ft': 'javascript'},
				\	'cpp'       : {'cmd': 'g++ -o %o.out %i.c', 'tmp': 1, 'exec': 1},
				\	'javascript': {'cmd': 'nodejs'},
				\	'lua'       : {'cmd': 'lua'},
				\	'markdown'  : {'cmd': 'markdown', 'ft': 'html'},
				\	'php'       : {'cmd': 'php'},
				\	'pug'       : {'cmd': 'pug --pretty', 'ft': 'html'},
				\	'python'    : {'cmd': 'python3'},
				\	'ruby'      : {'cmd': 'ruby'},
				\	'scss'      : {'cmd': 'node-sass --output-style=expanded', 'ft': 'css'},
				\	'sh'        : {'cmd': 'bash'},
				\ })
endfunction " 2}}}
" >>> Scratch buffer {{{1
command! Scratch :call helpers#OpenOrMove2Buffer('__Scratch__', 'markdown', 'sp')
" >>> Chmod current file {{{1
command! ChmodX :!chmod +x %
" >>> Auto mkdir when creating/saving file {{{1
function! s:AutoMkdir() abort " {{{2
	let l:dir = expand('<afile>:p:h')
	let l:file = expand('<afile>:t')
	if !isdirectory(l:dir)
		echohl WarningMsg
		let l:ans = input(l:dir . ' does not exist, create it [Y/n]? ')
		echohl None
		if empty(l:ans) || l:ans ==# 'y'
			let l:old_b = bufnr('%') + 1
			call mkdir(l:dir, 'p')
			silent execute 'saveas ' . l:dir . '/' . l:file
			silent execute 'bw ' . l:old_b
		endif
	endif
endfunction " 2}}}
augroup AutoMkdir
	autocmd!
	autocmd BufWritePre * call <SID>AutoMkdir()
augroup END
" >>> For quickfix/location windows {{{1
augroup Quickfix
	autocmd!
	autocmd FileType qf setl nowrap
	autocmd FileType qf nnoremap <buffer> <CR> <CR><C-w>p
augroup END
" 1}}}

" =========== JOBS ==============================
" Command for executing external tools using vim jobs {{{1
if g:hasJob
	command! KillJobs call helpers#KillAllJobs()
	command! LiveServer call helpers#Job('liveServer', 'live-server')
	command! -nargs=* BrowserSync call helpers#Job(
				\	'browserSync',
				\	<SID>BrowserSync(<f-args>)
				\ )
	function! s:BrowserSync(...) abort " {{{2
		let l:cwd = getcwd()
		let l:files = exists('a:1') ?
					\	join(map(split(a:1, ','), 'l:cwd . "/" . v:val'), ',') :
					\	printf('%s/*.html,%s/*.css,%s/*.js', l:cwd, l:cwd, l:cwd)
		let l:opts = exists('a:2') ? a:2 : '--directory --no-online'
		return printf(
					\ "browser-sync start --server --files=%s %s",
					\ l:files, l:opts
					\ )
	endfunction " 2}}}
endif
" 1}}}

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
augroup Omni
	autocmd!
	if exists('+omnifunc')
		autocmd! Filetype *
					\ if &omnifunc ==# '' |
					\	setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	endif
augroup END
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
