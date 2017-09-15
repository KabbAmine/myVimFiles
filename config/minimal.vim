" ========== Minimal vimrc without plugins (Unix & Windows) ====
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-09-16
" ==============================================================


" =========== MISC =============================================

" Ensure to use french locale if it exists {{{1
let s:curr_locale = v:lang
try
    language fr_FR.utf8
catch /^Vim\%((\a\+)\)\=:E197/
    silent execute 'language ' . s:curr_locale
endtry
unlet! s:curr_locale
" 1}}}

" Enable syntax and indentation {{{1
syntax on
filetype plugin indent on
" 1}}}

" Set some folders for viminfo, tags & mkdir {{{1
execute "set viminfo='100,<50,s10,h,n" . g:vim_dir . "/misc/viminfo"
execute 'set tags+=' . g:vim_dir . '/misc/systags'
execute 'set viewdir=' . g:vim_dir . '/misc/view'
" 1}}}

" Disable Background Color Erase (BCE) so that color schemes work properly {{{1
" when Vim is used inside tmux and GNU screen.
if exists('$TMUX')
    set t_ut=
endif
" 1}}}

" Tmux will send xterm-style keys when its xterm-keys option is on. {{{1
if &term =~# '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
" 1}}}

" Make <Alt> works in terminal. {{{1
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-
" -on-gnome-terminal-with-vim/10216459#10216459
if !empty($TERM)
    let s:c = 'a'
    while s:c <=# 'z'
        exec "set <A-" . s:c . ">=\e" . s:c
        exec "imap \e" . s:c . " <A-" . s:c . ">"
        let s:c = nr2char(1 + char2nr(s:c))
    endwhile
    unlet s:c
endif
" 1}}}

" Ensure using 256 colors in terminal when possible {{{1
if exists('$TERM') && $TERM =~# '^xterm' && !exists('$TMUX') && !g:has_gui
    set term=xterm-256color
endif
" 1}}}

" Make stars and bars in vimhelp visible {{{1
hi! link HelpBar Normal
hi! link HelpStar Normal
" 1}}}

" =========== OPTIONS  =========================================

" >>> GUI {{{1
let &guioptions = 'agirtc'
set winaltkeys=no
set linespace=5
let &guifont = g:has_win ?
            \ 'InconsolataForPowerline NF Medium:h10:cANSI' :
            \ 'InconsolataForPowerline NF Medium 13'
" 1}}}

" >>> Messages & info {{{1
set showcmd
set ruler
set confirm		" Start a dialog when a command fails
" 1}}}

" >>> Edit text {{{1
set infercase		" Adjust case of a keyword completion match.
set completeopt=longest,menuone
set textwidth=0		" Don't insert automatically newlines
" Make backspace works normally in Win
if g:has_win
    set backspace=2
endif
set matchpairs+=<:>
" 1}}}

" >>> Display text {{{1
set number
set linebreak
let &showbreak='⤷ '
set scrolloff=3			" Number of screen lines to show around the cursor.
set display=lastline	" Show the last line even if it doesn't fit.
set lazyredraw
set breakindent
let &listchars = g:has_win ?
            \ 'tab:¦ ,trail:~,extends:>,precedes:<' :
            \ 'tab:¦ ,trail:~,extends:#,nbsp:.'
set list
" Scroll horizontally by 1 character (Only when wrap is disabled).
set sidescroll=1
" 1}}}

" >>> Reading and writing files {{{1
set modeline
" 1}}}

" >>> Move, search & patterns {{{1
set ignorecase
set smartcase
set incsearch
" List of flags specifying which commands wrap to another line.
set whichwrap=b,s,<,>,[,]
" 1}}}

" >>> Running make and jumping to errors {{{1
let [s:grep_prg, s:grep_format] = ['%s -S --vimgrep $*', '%f:%l:%c:%m']
if executable('rg')
    let &grepprg = printf(s:grep_prg, 'rg')
    let &grepformat = s:grep_format
elseif executable('ag')
    let &grepprg = printf(s:grep_prg, 'ag')
    let &grepformat = s:grep_format
endif
unlet! s:grep_prg s:grep_format
" 1}}}

" >>> Syntax, highlighting and spelling {{{1
set background=dark
set hlsearch
set spelllang=fr
set synmaxcol=200
" 1}}}

" >>> Tabs & indenting {{{1
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent
set copyindent			" Copy whitespace for indenting from previous line.
" 1}}}

" >>> Command line editing {{{1
set wildmenu
set wildmode=list:longest,full
" Persistent undo.
if has('persistent_undo')
    let &undodir = g:vim_dir . '/misc/undodir/'
    set undofile
endif
" 1}}}

" >>> Multi-byte characters {{{1
set encoding=utf-8
" 1}}}

" >>> Multiple windows {{{1
set splitright
set hidden
" 1}}}

" >>> Swap file {{{1
let &directory = g:has_win ?
            \ g:vim_dir . '\\misc\\swap_dir,c:\\tmp,c:\\temp\\' :
            \ g:vim_dir . '/misc/swap_dir,~/tmp,/var/tmp,/tmp\'
" 1}}}

" >>> Mapping {{{1
" Remove the delay when escaping from insert-mode in terminal
if !g:has_gui
    set timeoutlen=1000 ttimeoutlen=0
endif
" 1}}}

" >>> Executing external commands {{{1
" Allows using shell aliases & functions
" if g:has_gui
" 	let &shell = '/bin/bash -i'
" endif
" }}}

" =========== DEFAULT PLUGINS ==================================

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

" =========== MAPPINGS =========================================

" >>> Movement {{{1
nnoremap J }
nnoremap K {
xnoremap J }
xnoremap K {
nnoremap j gj
nnoremap k gk

" Repeat f/t/F/T movements without ,/; (Because I need them elsewhere)
nnoremap f<CR> ;
nnoremap t<CR> ;
nnoremap f<BS> ,
nnoremap t<BS> ,

" Move current line or visual selection & auto indent
nnoremap <silent> <A-k> :call <SID>Move(-1)<CR>==
nnoremap <silent> <A-j> :call <SID>Move(1)<CR>==
xnoremap <silent> <A-k> :call <SID>Move(-1)<CR>gv=gv
xnoremap <silent> <A-j> :call <SID>Move(1)<CR>gv=gv
function! s:Move(to) range " {{{2
    " a:to : -1/1 <=> up/down
    let l:fl = a:firstline | let l:ll = a:lastline
    let l:to = a:to ==# -1 ?
                \ l:fl - 2 : (l:ll + 1 >=# line('$') ? line('$') : l:ll + 1)
    execute printf(':%d,%dm%d', l:fl, l:ll, l:to)
    let l:cl = line('.')
    if foldlevel(l:cl) !=# 0
        normal! zaza
    endif
endfunction " 2}}}
" 1}}}

" >>> Yanking {{{1
nnoremap Y y$
nnoremap <silent> yd :call <SID>Duplicate()<CR>
xnoremap <silent> <C-d> :t'><CR>gv<Esc>
function! s:Duplicate() abort " {{{2
    let l:ip = getpos('.') | silent .t. | call setpos('.', l:ip)
endfunction " 2}}}
" 1}}}

" >>> Folding {{{1
nnoremap <silent> <space> za
xnoremap <silent> <space> :fold<CR>
" 1}}}

" >>> Searching {{{1
nnoremap <silent> ghh :nohlsearch<CR>
nnoremap <silent> * *``
nnoremap / /\V
nnoremap ? ?\V
nnoremap n nzz
nnoremap N Nzz
" A quick way to use gn in normal mode
nnoremap c* *``cgn
nnoremap c# #``cgn
nnoremap d* *``dgn
nnoremap d# #``dgn
" 1}}}

" >>> Tabs {{{1
nnoremap <silent> <C-t> :tabedit<CR>
nnoremap <silent> <F5> :tabonly<CR>
" 1}}}

" >>> Buffers {{{1
nnoremap <silent> <S-h> :silent bp!<CR>
nnoremap <silent> <S-l> :silent bn!<CR>
nnoremap <silent> <BS> <C-^>
" For this mapping, check NERDTree settings in config/plugins.vim
nnoremap <silent> <S-q> :silent bw<CR>
" 1}}}

" >>> Commandline {{{1
nnoremap !z @:
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <C-Left>
cnoremap <C-l> <C-Right>
cnoremap <C-a> <Home>
" 1}}}

" >>> Super escape {{{1
inoremap jk <Esc>
inoremap JK <Esc>
cnoremap jk <C-c>
cnoremap JK <Esc>
" 1}}}

" >>> Enable Paste when using <C-r> {{{1
inoremap <silent> <C-r> <C-r><C-p>
" 1}}}

" >>> Windows  {{{1
nnoremap <silent> gs <C-w>
nnoremap <silent> gsnv :vnew<CR>
nnoremap <silent> gsns :split +enew<CR>
nnoremap <silent> <C-Up> <C-w>+
nnoremap <silent> <C-Down> <C-w>-
nnoremap <silent> <Up> <C-w>K
nnoremap <silent> <Down> <C-w>J
nnoremap <silent> <Right> <C-w>L
nnoremap <silent> <Left> <C-w>H
if g:has_gui
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
" 1}}}

" >>> Sort {{{1
xnoremap <silent> <leader>s :!sort<CR>
nnoremap <silent> <leader>s <Esc>:setlocal operatorfunc=<SID>Sort<CR>g@
function! s:Sort(...) abort " {{{2
    execute printf('%d,%d:!sort', line("'["), line("']"))
endfunction " 2}}}
" 1}}}

" >>> Quickly edit macro or register content in scmdline-window {{{1
" (https://github.com/mhinz/vim-galore)
" e.g. "q\r
nnoremap <leader>r :<c-u><c-r>='let @'. v:register 
            \ .' = '. string(getreg(v:register))<cr><c-f><left>
" 1}}}

" >>> Open (with) external programs {{{1
nnoremap <silent> gx :call helpers#OpenUrl()<CR>
" Terminal
nnoremap <silent> ;t   :call helpers#OpenHere('t')<CR>
nnoremap <silent> ;;t  :call helpers#OpenHere('t', expand('%:h:p'))<CR>
" File manager
nnoremap <silent> ;f   :call helpers#OpenHere('f')<CR>
nnoremap <silent> ;;f  :call helpers#OpenHere('f', expand('%:h:p'))<CR>
" 1}}}

" >>> Use c for manipulating + register {{{1
nnoremap cd "+d
nnoremap cp "+p
nnoremap cP "+P
nnoremap cy "+y
nnoremap cY "+y$
xnoremap Cd "+d
xnoremap Cp "+p
xnoremap CP "+P
xnoremap Cy "+y
" 1}}}

" >>> Text objects {{{1
" All ***
"	- ie         : Entire file
"	- il         : Current line without whitespace
"	- i{X}/a{X}  : Inside/around: . , _ * # : + - / = @ &
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
            \			['i.', 'F.WvEf.ge'], ['a.', 'F.vEf.'],
            \			['i_', 'T_vt_'], ['a_', 'F_vf_'],
            \			['i*', 'T*vt*'], ['a*', 'F*vf*'],
            \			['i,', 'T,vt,'], ['a,', 'F,vf,'],
            \			['i#', 'T#vt#'], ['a#', 'F#vf#'],
            \			['i:', 'T:vt:'], ['a:', 'F:vf:'],
            \			['i+', 'T+vt+'], ['a+', 'F+vf+'],
            \			['i-', 'T-vt-'], ['a-', 'F-vf-'],
            \			['i/', 'T/vt/'], ['a/', 'F/vf/'],
            \			['i=', 'T=vt='], ['a=', 'F=vf='],
            \			['i@', 'T@vt@'], ['a@', 'F@vf@'],
            \			['i&', 'T&vt&'], ['a&', 'F&vf&'],
            \	],
            \	'scss,css' : [
            \		['iV', '^f:wvt;'], ['iP', '^f:Bvt:'],
            \		['if', '][kvi{V'], ['af', '][kva{Vo[]j'],
            \	],
            \	'sh' : [
            \		['if', 'vi{V'], ['af', 'va{V'],
            \	]
            \ }
call helpers#MakeTextObjects(s:to)
unlet! s:to
" 1}}}

" >>> Preview {{{1
nnoremap <silent> gPr :Preview<CR>
xnoremap <silent> gPr :Preview<CR>
nnoremap <silent> gaPr :call helpers#AutoCmd(
            \	'Preview', 'Preview',
            \	['BufWritePost,InsertLeave,TextChanged,CursorHold,CursorHoldI']
            \ )<CR>
" 1}}}

" >>> Toggle options {{{1
nnoremap <silent> <leader><leader>n :setl number!<CR>
nnoremap <silent> <leader><leader>w :setl wrap!<CR>
nnoremap <silent> <leader><leader>l :setl list!<CR>
nnoremap <silent> <leader><leader>f :set fo-=o fo-=c fo-=r<CR>
nnoremap <silent> <leader><leader>c
            \ :execute 'setl colorcolumn=' . (&cc ? '' : 80)<CR>
" 1}}}

" >>> Grep {{{1
" To use with ag
nnoremap ,,g :call <SID>Grep()<CR>
xnoremap <silent> ,,g :call <SID>Grep(1)<CR>
nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>GrepMotion<CR>g@
function! s:Grep(...) abort " {{{2
    if exists('a:1')
        let l:q = a:1 ==# 1 ?
                    \	helpers#GetVisualSelection() : helpers#GetMotionResult()
    else
        echohl ModeMsg | let l:q = input('grep> ') | echohl None
    endif
    " Escape spaces in strings between double quotes then delete them
    let l:q = substitute(l:q, '\v(".*")', '\=escape(submatch(1), " ")', 'g')
    let l:q = substitute(l:q, '"', '', 'g')
    " Escape special spaces & characters
    let l:q = map(split(l:q, ' '), 'escape(v:val, "%# ")')
    if !empty(l:q)
        silent execute 'grep! ' . join(l:q, ' ') | botright copen 10 | wincmd p
        redraw!
    endif
endfunction
function! s:GrepMotion(...) abort " {{{2
    call <SID>Grep(2)
endfunction " 2}}}
" 1}}}

" >>> Reselect visual selection after (in/de)creasing numbers {{{1
xnoremap <C-a> <C-a>gv
xnoremap <C-x> <C-x>gv
" 1}}}

" >>> Go to line using relative numbers {{{1
nnoremap gj :call <SID>GoTo('j')<CR>
nnoremap gk :call <SID>GoTo('k')<CR>
function! s:GoTo(direction) abort " {{{2
    let [l:n, l:rn] = [&l:number, &l:relativenumber]
    redir => l:hi
    silent highlight LineNr
    silent highlight CursorLineNr
    redir END
    let l:hi = map(split(l:hi, "\n"), 'substitute(v:val, "xxx", "", "")')

    setlocal nonumber relativenumber
    hi! link LineNr ModeMsg
    hi! link CursorLineNr Search
    redraw

    echohl ModeMsg
    let l:goto = input('Goto> ')
    echohl None
    if !empty(l:goto)
        execute 'normal! ' . l:goto . a:direction
    endif

    call setbufvar('%', '&number', l:n)
    call setbufvar('%', '&relativenumber', l:rn)
    for l:h in l:hi
        execute 'highlight! ' . l:h
    endfor
endfunction " 2}}}
" 1}}}

" >>> Completion {{{1
inoremap <Tab>o <C-x><C-o>
inoremap <Tab>n <C-x><C-n>
inoremap <Tab>f <C-x><C-f>
inoremap <Tab>t <C-x><C-]>
inoremap <Tab>l <C-x><C-l>
inoremap <Tab>u <C-x><C-u>
inoremap <Tab>k <C-x><C-k>
inoremap <Tab>s <C-x>s
" A small sacrifice for a big cause
inoremap <Tab><Tab> <Tab>
" Triggers for auto completion
" call helpers#AutoCompleteWithMapTriggers({
"             \   'css'        : {':': 'o'},
"             \   'gitcommit'  : {':': 'u'},
"             \   'html'       : {'<': 'o'},
"             \   'javascript' : {'.': 'o'},
"             \   'markdown'   : {':': 'u'},
"             \   'php'        : {'->': 'o', '::': 'o'},
"             \   'python'     : {'.': 'o', '__': 'o'},
"             \   'scss'       : {':': 'o'},
"             \ })
" 1}}}

" =========== (AUTO)COMMANDS ===================================

" >>> Indentation for specific filetypes {{{1
augroup Indentation
    autocmd!
    autocmd FileType coffee,html,css,scss,pug,vader,ruby,markdown
                \ setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType vim,python,json
                \ setlocal ts=4 sts=4 sw=4 expandtab
augroup END
" 1}}}

" >>> Commands for folders & files {{{1
command! -nargs=+ -complete=file Mkdir  :call helpers#MakeDir(<f-args>)
command! -nargs=+ -complete=file Rm     :call helpers#Delete(<f-args>)
command! -nargs=1 -complete=file Rename :call helpers#Rename(<f-args>)
" 1}}}

" >>> Specify indentation (ts,sts,sw) & reindent {{{1
command! -nargs=? Indent :call <SID>Indent(<f-args>)
function! s:Indent(...) abort " {{{2
    let l:pos = getpos('.')
    let l:opts = ['tabstop', 'softtabstop', 'shiftwidth']
    let l:old_i = []
    for l:o in l:opts
        call add(l:old_i, getbufvar('%', '&' . l:o))
    endfor
    echohl Question
    let l:new_i = exists('a:1') ? a:1 :
                \ input(printf('%d:%d:%d> ',
                \	l:old_i[0], l:old_i[1], l:old_i[2]))
    echohl None
    if !empty(l:new_i)
        for l:o in l:opts
            silent execute printf('setlocal %s=%d', l:o, l:new_i)
        endfor
    endif
    silent execute '%normal! =='
    call setpos('.', l:pos)
endfunction " 2}}}
" 1}}}

" >>> Shortcuts for vim doc {{{1
command! Hl :help local-additions
command! Fl :help function-list
" 1}}}

" >>> Conversion between TABS ans SPACES {{{1
command! TabsAndSpaces :setlocal expandtab! | %retab!
" 1}}}

" >>> Make the current file directory as the vim current directory {{{1
command! Dir :cd %:p:h
" 1}}}

" >>> Write to file with sudo (Linux only) {{{1
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
if g:has_unix
    command! SudoW :w !sudo tee % >/dev/null
endif
" 1}}}

" >>> Set spelllang & spell in one command {{{1
command! -nargs=? Spell call <SID>SetSpell(<f-args>)
function! s:SetSpell(...) abort " {{{2
    if !&l:spell
        let s:old_complete = &l:complete
        let l:l = exists('a:1') ? a:1 : 'fr'
        let &l:spelllang = l:l
        setlocal complete+=kspell
        setlocal spell
    else
        setlocal nospell
        let &l:complete = exists('s:old_complete') ?
                    \ s:old_complete : &l:complete
    endif
endfunction " 2}}}
" 1}}}

" >>> Enable folding when needed {{{1
command! Fold :call <SID>Fold()
function! s:Fold() abort " {{{2
    let l:indentations = {
                \	'css'       : ['marker', ' {,}'],
                \	'javascript': ['marker', ' {,}'],
                \	'python'    : ['indent'],
                \	'sh'        : ['marker', ' {,}'],
                \ }

    if !has_key(l:indentations, &ft)
        return
    endif

    let l:ft = l:indentations[&ft]

    let l:type = l:ft[0]
    let l:marker = len(l:ft) ># 1 ? l:ft[1] : ''

    let l:old_foldmethod = &foldmethod
    let l:old_foldmarker = &foldmarker

    if getbufvar('%', 'fold_by_marker') ==# 0
        silent execute 'setlocal foldmethod=' . l:type
        if !empty(marker)
            silent execute 'setlocal foldmarker=' . escape(l:marker, ' ')
        endif
        setlocal foldenable
        normal! zR
        call setbufvar('%', 'fold_by_marker', 1)

        " Be sure to have foldcolumn enabled
        setlocal foldcolumn=1
    else
        setlocal nofoldenable
        silent execute 'setlocal foldmethod=' . l:old_foldmethod
        silent execute 'setlocal foldmarker=' . escape(l:old_foldmarker, ' ')
        call setbufvar('%', 'fold_by_marker', 0)
        setlocal foldcolumn=0
    endif
endfunction " 2}}}
" 1}}}

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
" 1}}}

" >>> Preview buffer {{{1
" TODO: Find a way to execute vimscript.
command! -range=% Preview :call <SID>Preview(<line1>, <line2>)
let s:ft_dict = {
            \ 'c'         : {'cmd': 'gcc -o %o.out %i.c', 'tmp': 1, 'exec': 1},
            \ 'coffee'    : {'cmd': 'coffee -s'},
            \ 'cpp'       : {'cmd': 'g++ -o %o.out %i.c', 'tmp': 1, 'exec': 1},
            \ 'javascript': {'cmd': 'nodejs'},
            \ 'lua'       : {'cmd': 'lua'},
            \ 'markdown'  : {'cmd': 'markdown', 'ft': 'html'},
            \ 'php'       : {'cmd': 'php'},
            \ 'pug'       : {'cmd': 'pug --pretty', 'ft': 'html'},
            \ 'python'    : {'cmd': 'python3'},
            \ 'ruby'      : {'cmd': 'ruby'},
            \ 'sh'        : {'cmd': 'bash'},
            \ 'scss'      :
            \   {'cmd': 'node-sass --output-style=expanded', 'ft': 'css'},
            \ }
function! s:Preview(start, end) abort " {{{2
    call helpers#ExecuteInBuffer('__Preview__', a:start, a:end, s:ft_dict,
                \ ['nonumber', 'nobuflisted'],
                \ ['wincmd J', 'resize 10', 'normal! gg']
                \ )
endfunction " 2}}}
" 1}}}

" >>> Persistent scratch buffer {{{1
command! Scratch :call s:Scratch()
function! s:Scratch() abort " {{{2
    call helpers#OpenOrMove2Buffer('__Scratch__', 'markdown', 'topleft sp')
    if exists('g:scratch')
        silent %delete_
        call append(0, g:scratch)
    else
        augroup Scratch
            autocmd!
            autocmd InsertLeave,CursorHold,CursorHoldI,TextChanged __Scratch__
                        \ let g:scratch = getline(1, line('$'))
        augroup END
    endif
endfunction " 2}}}
" 1}}}

" >>> Chmod current file {{{1
command! ChmodX :!chmod +x %
" 1}}}

" >>> Auto mkdir when creating/saving file {{{1
function! s:AutoMkdir() abort " {{{2
    let l:dir = expand('<afile>:p:h')
    let l:file = expand('<afile>:t')
    if !isdirectory(l:dir)
        echohl Question
        let l:ans = input(l:dir . ' does not exist, create it [y/N]? ')
        echohl None
        if empty(l:ans) || l:ans =~# '\v^n|N$'
            return
        endif
        call mkdir(l:dir, 'p')
        silent execute 'saveas ' . l:dir . '/' . l:file
        " Then wipeout the 1st buffer (alternative).
        silent execute 'bwipeout! ' . bufnr('#')
    endif
endfunction " 2}}}
augroup AutoMkdir
    autocmd!
    autocmd BufWritePre * call <SID>AutoMkdir()
augroup END
" 1}}}

" >>> Quickfix & location fix windows {{{1
augroup QLWindows
    autocmd!
    autocmd FileType qf setl nowrap
    autocmd FileType qf nnoremap <buffer> <CR> <CR><C-w>p
augroup END
" 1}}}

" >>> Disable continuation of comments when using o/O {{{1
augroup ResetFormatOptions
    autocmd!
    autocmd FileType vim setl formatoptions&
augroup END
" 1}}}

" >>> Enable foldcolumn only when folds are present {{{1
function! s:AutoFoldColumn() abort " {{{2
    let l:pos = getpos('.')
    let l:c_l = line('.')
    let l:there_are_folds = 0

    if foldlevel(l:c_l)
        let l:there_are_folds = 1
    endif

    normal! ggzj
    if line('.') !=# 1
        let l:there_are_folds = 1
    endif

    normal! ]z
    if line('.') !=# 1
        let l:there_are_folds = 1
    endif

    call setpos('.', l:pos)

    if l:there_are_folds
        setlocal foldcolumn=1
    endif
endfunction " 2}}}
augroup AutoFoldColumn
    autocmd!
    autocmd BufWinEnter * :call <SID>AutoFoldColumn()
augroup END

" 1}}}

" =========== JOBS =============================================

" Command for executing external tools using vim jobs {{{1
if g:has_job
    command! KillJobs call helpers#KillAllJobs()
    " Live-server
    if executable('live-server')
        command! LiveServer call helpers#Job('liveServer', 'live-server')
    endif
    " Browser-sync
    if executable('browser-sync')
        command! -nargs=* BrowserSync call helpers#Job(
                    \	'browserSync', <SID>BrowserSync(<f-args>))
        function! s:BrowserSync(...) abort " {{{2
            let l:cwd = getcwd()
            let l:files = exists('a:1') ?
                        \   join(map(
                        \       split(a:1, ','), 'l:cwd . "/" . v:val'), ',') :
                        \	printf('%s/*.html,%s/*.css,%s/*.js',
                        \		l:cwd, l:cwd, l:cwd)
            let l:opts = exists('a:2') ? a:2 : '--directory --no-online'
            return printf(
                        \ "browser-sync start --server --files=%s %s",
                        \ l:files, l:opts
                        \ )
        endfunction " 2}}}
    endif
endif
" 1}}}

" =========== ABBREVIATIONS ====================================

" No more rage {{{1
cab W! w!
cab Q! q!
cab QA! qa!
cab QA qa
cab Wq wq
cab wQ wq
cab WQ wq
cab W w
cab Q q
" 1}}}

" =========== OMNIFUNC =========================================

" Set omni-completion if the appropriate syntax file is present otherwise {{{1
" use the syntax completion.
augroup Omni
    autocmd!
    if exists('+omnifunc')
        autocmd! Filetype *
                    \ if empty(&omnifunc)
                    \|	setlocal omnifunc=syntaxcomplete#Complete
                    \| endif
    endif
augroup END
" 1}}}

" =========== EXTERNAL APPLICATIONS INTEGRATION ================

" >>> Use Shiba with some file types {{{1
if executable('shiba')
    augroup Shiba
        autocmd!
        autocmd Filetype html,markdown command! -buffer Shiba
                    \ silent exe '!shiba --detach %' | redraw!
    augroup END
endif
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
