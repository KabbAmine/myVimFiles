" ========== Minimal vimrc without plugins (Unix & Windows) ====
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-09-26
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
if !exists('g:syntax_on')
    syntax enable
endif
filetype plugin indent on
" 1}}}

" Set some folders for viminfo, tags & mkdir {{{1
let &viminfo = '''100,<50,s10,h,n' . g:vim_dir . '/misc/viminfo'
if &tags !~# 'systags'
    let &tags .= ',' . g:vim_dir. '/misc/systags'
endif
let &viewdir = g:vim_dir. '/misc/view'
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
        execute "set <A-" . s:c . ">=\e" . s:c
        execute "imap \e" . s:c . " <A-" . s:c . ">"
        let s:c = nr2char(1 + char2nr(s:c))
    endwhile
    unlet s:c
endif
" 1}}}

" " Ensure using 256 colors in terminal when possible {{{1
" if exists('$TERM') && $TERM =~# '^xterm' && !exists('$TMUX') && !g:is_gui
"     set term=xterm-256color
" endif
" " 1}}}

" Make stars and bars in vimhelp visible {{{1
hi! link HelpBar Normal
hi! link HelpStar Normal
" 1}}}

" Change cursor shape in terminal {{{1
if !g:is_gui
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif
" 1}}}

" Enable 256 colors in the terminal in case it does not support truecolors {{{1
if !g:is_gui
    set t_Co=256
endif
" 1}}}

" Color palette for the terminal {{{1
if g:has_term
    let g:terminal_ansi_colors = [
                \   '#3b4252',
                \   '#bf616a',
                \   '#a3be8c',
                \   '#ebcb8b',
                \   '#81a1c1',
                \   '#b48ead',
                \   '#88c0d0',
                \   '#e5e9f0',
                \   '#4c566a',
                \   '#bf616a',
                \   '#a3be8c',
                \   '#ebcb8b',
                \   '#81a1c1',
                \   '#b48ead',
                \   '#8fbcbb',
                \   '#eceff4'
                \ ]
endif
" 1}}}

" =========== OPTIONS  =========================================

" >>> GUI {{{1
let &guioptions = 'agirtcMk'
set winaltkeys=no
set linespace=2
let &guifont = g:is_win ?
            \ 'InconsolataForPowerline NF Medium:h10:cANSI' :
            \ 'FuraMono NF Medium 11'
" 1}}}

" >>> Messages & info {{{1
set confirm         " Start a dialog when a command fails
set shortmess+=c    " Disable ins-completion-menu messages with c
set showcmd
" 1}}}

" >>> Edit text {{{1
set infercase       " Adjust case of a keyword completion match.
set completeopt=menuone,noselect,preview
set textwidth=0     " Don't insert automatically newlines
" Make backspace works normally in Win
if g:is_win
    set backspace=2
endif
set matchpairs+=<:>
set nojoinspaces
" 1}}}

" >>> Display text {{{1
set linebreak
let &showbreak='⤷ '
set scrolloff=3         " Number of screen lines to show around the cursor.
set display=lastline    " Show the last line even if it doesn't fit.
set lazyredraw
set breakindent
let &listchars = g:is_win ?
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
" 1}}}

" >>> Running make and jumping to errors {{{1
let [s:grep_prg, s:grep_format] = ['%s -SF --vimgrep', '%f:%l:%c:%m']
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
set hlsearch
set synmaxcol=1000
" I would like to do the opposite and check if the current terminal supports
" true colors, but there is no way.
if g:is_termguicolors
    set termguicolors
endif
" 1}}}

" >>> Tabs & indenting {{{1
set softtabstop=4       " Number of spaces to insert for a <Tab>.
set shiftwidth=4        " Number of spaces used for each step of (auto)indent.
set smarttab            " A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent
set copyindent          " Copy whitespace for indenting from previous line.
" 1}}}

" >>> Command line editing {{{1
set wildmenu
set wildmode=list:longest,full
set history=1000
" Persistent undo.
if has('persistent_undo')
    let &undodir = g:vim_dir . '/misc/undodir/'
    set undofile
endif
" 1}}}

" >>> Multiple windows {{{1
set splitbelow
set splitright
set hidden
" let &previewheight = winwidth(0) / 2
" 1}}}

" >>> Swap file {{{1
let &directory = g:is_win ?
            \ g:vim_dir . '\\misc\\swap_dir,c:\\tmp,c:\\temp\\' :
            \ g:vim_dir . '/misc/swap_dir,~/tmp,/var/tmp,/tmp\'
set updatetime=1000    " time in msec after which the swap file will be updated
" 1}}}

" >>> Mapping {{{1
" Remove the delay when escaping from insert-mode in terminal
if !g:is_gui
    set ttimeoutlen=0
endif
" 1}}}

" >>> Executing external commands {{{1
" Allows using shell aliases & functions
" if g:is_gui
"   let &shell = '/bin/bash -i'
" endif
" }}}

" >>> Various {{{1
set virtualedit=block
" 1}}}

" >>> Multiple tab pages {{{1
set showtabline=2
set tabline=%!ka#tabline#get()
" 1}}}

" =========== DEFAULT PLUGINS ==================================

" {{{1
packadd! matchit
let g:loaded_logiPat = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrw = 1
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_tarPlugin = 1
let g:loaded_tar = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin= 1
let g:loaded_zip = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_2html_plugin = 1
" }}}

" =========== MAPPINGS =========================================

" >>> Movement {{{1
nnoremap K {
nnoremap J }
vnoremap K {
vnoremap J }
nnoremap j gj
nnoremap k gk

" Tags
nnoremap <C-]> <C-]>zz

" Repeat f/t/F/T movements without ,/; (Because I need them elsewhere)
nnoremap f<CR> ;
nnoremap t<CR> ;
nnoremap f<BS> ,
nnoremap t<BS> ,
vnoremap f<CR> ;
vnoremap t<CR> ;
vnoremap f<BS> ,
vnoremap t<BS> ,

" Move current line or visual selection & auto indent
nnoremap <silent> <A-k> :call <SID>MoveSelection(-1)<CR>==
nnoremap <silent> <A-j> :call <SID>MoveSelection(1)<CR>==
xnoremap <silent> <A-k> :call <SID>MoveSelection(-1)<CR>gv=gv
xnoremap <silent> <A-j> :call <SID>MoveSelection(1)<CR>gv=gv

function! s:MoveSelection(to) range " {{{2
    " a:to : -1/1 <=> up/down
    let l:fl = a:firstline | let l:ll = a:lastline
    let l:cl = line('.')
    let l:to = a:to ==# -1 ?
                \ l:fl - 2 : (l:ll + 1 >=# line('$') ? line('$') : l:ll + 1)
    if foldlevel(l:to) !=# 0
        silent execute l:to ' | normal! zO | ' . l:cl
    endif
    execute printf(':%d,%dm%d', l:fl, l:ll, l:to)
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
vnoremap <silent> * *``
nnoremap / /\V
nnoremap # /\V
nnoremap ? ?\V
" A quick way to use gn in normal mode
nnoremap c* *``cgn
nnoremap c# #``cgn
nnoremap d* *``dgn
nnoremap d# #``dgn
" 1}}}

" >>> Tabs {{{1
nnoremap <silent> <C-t> :tabedit<CR>
" 1}}}

" >>> Buffers {{{1
nnoremap ,b :ls<CR>:b 
nnoremap <silent> <S-l> :call <SID>MoveToBuffer(1)<CR>
nnoremap <silent> <S-h> :call <SID>MoveToBuffer(-1)<CR>
nnoremap <silent> <BS> <C-^>
" For this mapping, check zoomtoggle function & NERDTree settings in config/plugins.vim
nnoremap <silent> <S-q> :bwipeout<CR>

fun! s:MoveToBuffer(dir) abort " {{{2
    let cmd = a:dir ># 0 ? 'bnext!' : 'bprevious!'
    silent execute cmd
    while &l:filetype is# 'qf'
        silent execute cmd
    endwhile
endfun
" 2}}}
" 1}}}

" >>> Commandline {{{1
nnoremap !z @:
nnoremap !: :Job 
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
nnoremap <silent> gsh :hide<CR>
nnoremap <silent> gsns :split +enew<CR>

if g:is_gui
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
xnoremap <leader>s :!sort<CR>
nnoremap <silent> <leader>s <Esc>:setlocal operatorfunc=<SID>Sort<CR>g@
function! s:Sort(...) abort " {{{2
    execute printf('%d,%d:!sort', line("'["), line("']"))
endfunction " 2}}}
" 1}}}

" >>> Open (with) external programs {{{1
nnoremap <silent> gx :call ka#sys#OpenUrl()<CR>
" Terminal
nnoremap <silent> ;t :call ka#sys#OpenHere('t')<CR>
nnoremap <silent> ;;t :call ka#sys#OpenHere('t', expand('%:h:p'))<CR>
" File manager
nnoremap <silent> ;f :call ka#sys#OpenHere('f')<CR>
nnoremap <silent> ;;f :call ka#sys#OpenHere('f', expand('%:h:p'))<CR>
" 1}}}

" >>> Edition {{{1
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
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
"   - ie         : Entire file
"   - il         : Current line without whitespace
"   - i{X}/a{X}  : Inside/around: . , _ * # : + - / = @ &
" Scss/Css ***
"    - iV     : Value
"    - iP     : Property
"    - if/af  : Inside/around a selector block
" Sh ***
"    - if/af  : Inside/around a function
let s:to = {
            \   '_' : [
            \           ['ie', 'ggVG'],
            \           ['il', '^vg_'],
            \           ['i.', 'T.vt.'], ['a.', 'F.vf.'],
            \           ['i_', 'T_vt_'], ['a_', 'F_vf_'],
            \           ['i*', 'T*vt*'], ['a*', 'F*vf*'],
            \           ['i,', 'T,vt,'], ['a,', 'F,vf,'],
            \           ['i#', 'T#vt#'], ['a#', 'F#vf#'],
            \           ['i:', 'T:vt:'], ['a:', 'F:vf:'],
            \           ['i+', 'T+vt+'], ['a+', 'F+vf+'],
            \           ['i-', 'T-vt-'], ['a-', 'F-vf-'],
            \           ['i/', 'T/vt/'], ['a/', 'F/vf/'],
            \           ['i=', 'T=vt='], ['a=', 'F=vf='],
            \           ['i@', 'T@vt@'], ['a@', 'F@vf@'],
            \           ['i&', 'T&vt&'], ['a&', 'F&vf&'],
            \   ],
            \   'scss,css' : [
            \       ['iV', '^f:wvt;'], ['iP', '^f:Bvt:'],
            \       ['if', '][kvi{V'], ['af', '][kva{Vo[]j'],
            \   ],
            \   'sh' : [
            \       ['if', 'vi{V'], ['af', 'va{V'],
            \   ]
            \ }
call ka#utils#E('MakeTextObjects', [s:to])
unlet! s:to
" 1}}}

" >>> Toggle options {{{1
nnoremap <leader><leader>n :setlocal number!<CR>:setlocal number?<CR>
nnoremap <leader><leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap <leader><leader>l :setlocal list!<CR>:setlocal list?<CR>
nnoremap <leader><leader>c
            \ :execute 'setlocal colorcolumn=' . (&colorcolumn ? '' : 80)<CR>
            \ :setlocal colorcolumn?<CR>
" 1}}}

" >>> Grep {{{1
" To use with rg or ag
nnoremap ,,g :call <SID>Grep()<CR>
nnoremap ,,G :call <SID>Grep('', '!')<CR>
xnoremap <silent> ,,g :call <SID>Grep(1)<CR>
xnoremap <silent> ,,G :call <SID>Grep(1, '!')<CR>
nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>GrepMotion<CR>g@
nnoremap <silent> ,G <Esc>:setlocal operatorfunc=<SID>GrepRegMotion<CR>g@

function! s:Grep(...) abort " {{{2
    let l:use_regex = exists('a:2') ? 1 : 0

    if exists('a:1') && type(a:1) ==# type(1)
        let l:q = a:1 ==# 1
                    \ ? ka#utils#E('GetVisualSelection', [], 1)
                    \ : ka#utils#E('GetMotionResult', [], 1)
    else
        let inp_msg = l:use_regex
                    \ ? 'grep[reg]>'
                    \ : 'grep>'
        echohl ModeMsg | let l:q = input(inp_msg . ' ') | echohl None
    endif

    if l:use_regex
        let l:old_grepprg = &grepprg
        let &grepprg = substitute(&grepprg, '-SF', '-S', '')
    endif

    if !empty(l:q)
        let l:q = split(l:q)
        let l:q[0] = l:q[0] =~# '^".*"$'
                    \ ? l:q[0]
                    \ : '"' . l:q[0] . '"'
        call map(l:q, 'escape(v:val, "%#")')
        " Make it async with the job module if possible
        if g:has_job
            let cmd = printf('%s %s .', &grepprg, join(l:q))
            call ka#job#start(cmd, {'realtime': 1, 'std': 'out'})
        else
            silent execute 'grep! ' . join(l:q) | botright cwindow 10 | wincmd p
        endif
        redraw!
    endif

    if l:use_regex
        let &grepprg = l:old_grepprg
    endif
endfunction
function! s:GrepMotion(...) abort " {{{2
    call <SID>Grep(2)
endfunction " 2}}}
function! s:GrepRegMotion(...) abort " {{{2
    call <SID>Grep(2, '!')
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
    let l:hi = [
                \   split(execute('highlight LineNr'), "\n")[0],
                \   split(execute('highlight CursorLineNr'), "\n")[0]
                \ ]
    call map(l:hi, {i, v -> substitute(v, 'xxx', '', '')})

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

" >>> Terminal mode {{{1
if g:has_term
    tnoremap jk <C-w>N
    tmap <C-h> <C-w><C-h>
    tmap <C-l> <C-w><C-l>
    tmap <C-k> <C-w><C-k>
    tmap <C-j> <C-w><C-j>
    tnoremap <silent> <S-q> <C-w>:call <SID>TermKill()<CR>
    " Note that the following mappings replace the OpenHere ones
    nnoremap <silent> ;t :call <SID>TermToggle()<CR>
    nnoremap <silent> ;;t :call <SID>TermToggle(1)<CR>
    tnoremap <silent> ;t <C-w>:call <SID>TermToggle()<CR>

    fun! s:TermToggle(...) abort " {{{2
        let term_buf_nr = get(g:, 'term_buf_nr', 0)
        if !term_buf_nr
            let cwd = exists('a:1') ? expand('%:p:h') : getcwd()
            let g:term_buf_nr = term_start(&shell, {
                        \   'term_name': 'term',
                        \   'cwd': cwd
                        \ })
            augroup Term
                autocmd!
                autocmd BufDelete,BufWipeout <buffer>
                            \ unlet! g:term_buf_nr
            augroup END
        elseif bufexists(term_buf_nr)
            let term_win_nr = bufwinnr(term_buf_nr)
            silent execute term_win_nr isnot# -1
                        \ ? term_win_nr . 'hide'
                        \ : term_buf_nr . 'sbuffer'
        endif
    endfun
    " 2}}}
    fun! s:TermKill() abort " {{{2
        let term_buf_nr = get(g:, 'term_buf_nr', 0)
        if term_buf_nr && index(term_list(), term_buf_nr) isnot# -1 && bufloaded(term_buf_nr)
            silent execute term_buf_nr . 'bwipeout!'
            unlet! g:term_buf_nr
        endif
    endfun
    " 2}}}
endif
" 1}}}

" >>> Clever gf {{{1
nnoremap <silent> gf :call <SID>CleverGf()<CR>

function! s:CleverGf() abort " {{{2
    " Expand 2 times in case we have $HOME or ~
    let l:cf = fnamemodify(expand(expand('<cfile>')), '%:p')
    silent execute isdirectory(l:cf)
                \ ? 'edit ' . l:cf
                \ : filereadable(l:cf)
                \ ? 'normal! gf'
                \ : 'edit ' . expand('<cfile>')
endfunction " 2}}}
" 1}}}

" >>> Super Find {{{1
nnoremap ,f :F 
" 1}}}

" >>> Completion  {{{1
command! -nargs=? -complete=customlist,<SID>CompleteCompletionTypes MashTabAuto
            \ call ka#module#mashtab#AutoComplete(<f-args>)
call ka#module#mashtab#i()
imap <Tab> <Plug>(mashtabTab)
imap <BS> <Plug>(mashtabBS)
silent execute 'inoremap <silent>' . (g:is_gui
            \ ? '<C-space> <C-x><C-o>'
            \ : '<C-@> <C-x><C-o>')
let g:mashtab_custom_sources = {}
let g:mashtab_patterns = {}
let g:mashtab_patterns.user = {
            \   'gitcommit': '\s*:\w*$',
            \   'markdown' : ':\w*$',
            \   'css'      : '^\s*\S\+$',
            \   'scss'     : '^\s*\S\+$'
            \ }
let g:mashtab_ft_chains = {
            \   'css' : ['path', 'ulti', 'omni', 'user', 'buffer', 'line'],
            \   'scss': ['path', 'ulti', 'omni', 'user', 'buffer', 'line']
            \ }

fun! s:CompleteCompletionTypes(a, c, p) abort " {{{2
    let types = ['path', 'ulti', 'spell', 'kspell', 'omni', 'user', 'dict', 'buffer', 'line']
    return filter(copy(types), 'v:val =~ a:a')
endfun " 2}}}
" 1}}}

" >>> Zoom  {{{1
fun! s:ZoomToggle() abort
    let zoomed_win = getwinvar(winnr(), 'zoomed_win')
    let one_win_only = tabpagewinnr(tabpagenr(), '$') is# 1 ? 1 : 0
    if one_win_only && zoomed_win is# 1
        silent tabclose
        unlet! w:zoomed_win
    elseif !one_win_only
        silent tab split
        let w:zoomed_win = 1
    endif
endfun
nnoremap <silent> gsz :call <SID>ZoomToggle()<CR>
nnoremap <silent> <expr> <S-q> get(w:, 'zoomed_win', 0)
            \ ? ":normal gsz\<CR>"
            \ : ":bwipeout\<CR>"
" 2}}}
" 1}}}

" =========== COMMANDS ===================================

" >>> Commands for folders & files {{{1
" TODO: Add windows commands
command! -nargs=+ -complete=file Rm :call ka#sys#ExecuteCmd('rm -vr ', '<args>')
command! -nargs=+ -complete=file Mkdir :call ka#sys#ExecuteCmd('mkdir -vp ', '<args>')
command! -nargs=+ -complete=file Cp :call ka#sys#ExecuteCmd('cp -vrf ', '<args>')
command! -nargs=+ -complete=file Mv :call ka#sys#ExecuteCmd('mv -vf ', '<args>')
command! -nargs=1 -complete=file Rename :call ka#sys#Rename('<args>')
" 1}}}

" >>> Specify indentation (ts,sts,sw) & reindent {{{1
command! -nargs=? Indent :call <SID>Indent(<f-args>)

function! s:Indent(...) abort " {{{2
    let l:pos = getpos('.')
    let l:opts = ['softtabstop', 'shiftwidth']
    let l:old_i = []
    for l:o in l:opts
        call add(l:old_i, getbufvar('%', '&' . l:o))
    endfor
    echohl Question
    let l:new_i = exists('a:1') ? a:1 :
                \ input(printf('%d:%d> ',
                \   l:old_i[0], l:old_i[1]))
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
if g:is_unix
    command! SudoW :w !sudo tee % >/dev/null
endif
" 1}}}

" >>> Set spelllang & spell in one command {{{1
command! -nargs=? Spell call <SID>SetSpell(<f-args>)

function! s:SetSpell(...) abort " {{{2
    if !&l:spell
        let [s:old_complete, s:old_spelllang] = [&l:complete, &l:spelllang]
        let l:l = exists('a:1') ? a:1 : 'fr'
        let &l:spelllang = l:l
        setlocal complete+=kspell spell
    else
        setlocal nospell
        let &l:complete = exists('s:old_complete') ?
                    \ s:old_complete : &l:complete
        let &l:spelllang = exists('s:old_spelllang') ?
                    \ s:old_spelllang : &l:spelllang
    endif
endfunction " 2}}}
" 1}}}

" >>> Enable folding when needed {{{1
command! Fold :call <SID>Fold()

function! s:Fold() abort " {{{2
    let l:indentations = {
                \   'coffee'     : ['indent'],
                \   'css'        : ['marker', ' {,}'],
                \   'javascript' : ['syntax'],
                \   'php'        : ['marker', ' {,}'],
                \   'python'     : ['indent'],
                \   'scss'       : ['marker', ' {,}'],
                \   'sh'         : ['marker', ' {,}'],
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
        call ka#ui#E('CreateOrGoTo', ['__Echo__', 'vim', 'sp'])
        call setline(1, l:out[1:])
        wincmd p
    endif
endfunction " 2}}}
" 1}}}

" >>> Persistent scratch buffer {{{1
command! Scratch :call s:Scratch()

function! s:Scratch() abort " {{{2
    call ka#ui#E('CreateOrGoTo', ['__Scratch__', 'markdown', 'topleft sp'])
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
        if empty(l:ans) || l:ans =~# '\v^(n|N)$'
            return
        endif
        call mkdir(l:dir, 'p')
        silent execute 'saveas ' . l:dir . '/' . l:file
        " Then wipeout the alternative buffer if it have the same name.
        if bufname('#') ==# l:dir . '/' . l:file
            silent execute 'bwipeout! ' . bufnr('#')
        endif
    endif
endfunction " 2}}}
" 1}}}

" >>> Quickfix & location fix windows {{{1
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> [l :lprevious<CR>

function! s:PreviewQItem() abort " {{{2
    let s:is_loclist = getwininfo(bufwinid('%'))[0].loclist
    let l:file = matchstr(getline(line('.')), '^\f\+\ze|')
    let l:to_line = matchstr(getline(line('.')), '^\f\+|\zs\d\+\ze\s\+')
    silent execute printf(
                \ 'vertical pedit! +setlocal\ cursorline\ nobuflisted|%s %s',
                \ l:to_line, l:file
                \ )
    wincmd P
    wincmd L
    if foldlevel(line('.')) !=# 0
        normal! zO
    endif
    wincmd p
endfunction " 2}}}
" 1}}}

" >>> Enable foldcolumn only when folds are present {{{1
function! s:AutoFoldColumn() abort " {{{2
    let l:pos = getpos('.')
    let l:c_l = line('.')
    let l:there_are_folds = 0

    if foldlevel(l:c_l)
        let l:there_are_folds = 1
    endif

    if !l:there_are_folds
        normal! ggzj
        if line('.') !=# 1
            let l:there_are_folds = 1
        endif
    endif

    if !l:there_are_folds
        normal! ]z
        if line('.') !=# 1
            let l:there_are_folds = 1
        endif
    endif

    call setpos('.', l:pos)

    if l:there_are_folds
        setlocal foldcolumn=1
    endif
endfunction " 2}}}
" 1}}}

" >>> Operate on multiple files/buffers at once {{{1
command! -bar -bang -nargs=* -complete=file E
            \ call <SID>CmdOnMultipleFiles('edit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file Sp
            \ call <SID>CmdOnMultipleFiles('split', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file VS
            \ call <SID>CmdOnMultipleFiles('vsplit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file TabE
            \ call <SID>CmdOnMultipleFiles('tabedit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=buffer Bd
            \ call <SID>CmdOnMultipleBuffers('bdelete', [<f-args>], '<bang>')

" An alternative to :find
if executable('rg')
    command! -bar -bang -nargs=* -complete=customlist,<SID>CompleteFiles F
                \ execute 'E ' . <q-args>
endif

function! s:CmdOnMultipleFiles(cmd, list_pattern, bang) abort " {{{2
    let l:cmd = a:cmd . a:bang

    if a:list_pattern ==# []
        execute l:cmd
        return
    endif

    for l:p in a:list_pattern
        if match(l:p, '\v\?|*|\[|\]') >=# 0
            " Expand wildcards only if they exist
            for l:f in glob(l:p, 0, 1)
                execute l:cmd . ' ' . l:f
            endfor
        else
            " Otherwise execute the command
            execute l:cmd . ' ' . l:p
        endif
    endfor
endfunction
function! s:CmdOnMultipleBuffers(cmd, list_pattern, bang) abort " {{{2
    let l:cmd = a:cmd . a:bang

    if a:list_pattern ==# []
        execute l:cmd
        return
    endif

    for l:p in a:list_pattern
        for l:f in getcompletion(l:p, 'buffer', 1)
            if bufloaded(l:f)
                try
                    execute l:cmd . ' ' . l:f
                catch
                    break
                endtry
            endif
        endfor
    endfor
endfunction " 2}}}
function! s:CompleteFiles(a, c, p) abort " {{{2
    let l:cmd = 'rg --files --hidden --glob !.git/'
    return filter(systemlist(l:cmd), 'v:val =~ a:a')
endfunction " 2}}}
" 1}}}

" >>> Jobs {{{1
if g:has_job
    command! -nargs=1 -complete=customlist,ka#job#complete Job
                \ call ka#job#start_from_cmdline(<f-args>)
    command! -nargs=1 -complete=customlist,ka#job#complete JobRestart
                \ call ka#job#restart(<f-args>)
    command! -nargs=1 -bang -complete=customlist,ka#job#complete JobStop
                \ call ka#job#stop(<f-args>, '<bang>')
    command! -bang JobStopAll call ka#job#stop_all('<bang>')
    command! JobList call ka#job#list()
    command! JobClean call ka#job#clean()
endif
" 1}}}

" >>> Notes  {{{1
let s:notes_dir = g:vim_dir . '/misc/notes'

command! -nargs=+ -complete=customlist,CompleteNotes Note
            \ call <SID>Note(<f-args>)
command! -nargs=+ -complete=customlist,CompleteNotes NoteDelete
            \ call <SID>NoteDelete(<f-args>)

" Update the date when the file is saved {{{2
augroup Notes
    autocmd!
    let s:str =
                \ 'autocmd BufWrite %s/*.md ' .
                \ ':call setline(1,  "> " . strftime("%%d %%b %%Y %%X"))'
    execute printf(s:str, s:notes_dir)
    unlet! s:str
augroup END " 2}}}

function! s:Note(file) abort " {{{2
    let l:file_name = s:notes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')

    let l:add_date = file_readable(l:file_name) ? 0 : 1
    silent execute 'vnew! ' . l:file_name
    if l:add_date
        call setline(1,  ["> " . strftime("%d %b %Y %X"), ''])
        normal! G
    endif
endfunction " 2}}}
function! s:NoteDelete(file) abort " {{{2
    let l:file_name = s:notes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')
    call ka#sys#Delete(l:file_name)
endfunction " 2}}}
function! CompleteNotes(a, c, p) " {{{2
    return filter(map(glob(s:notes_dir . '/*', 1, 1), 'fnamemodify(v:val, ":p:t")'),
                \ 'v:val =~ a:a')
endfunction " 2}}}
" 1}}}

" >>> Autoformat  {{{1
command! -range=% AutoFormat :call ka#module#autoformat#run(<line1>, <line2>,
            \ {
            \   'css': printf(
            \       'prettier --parser css --stdin %s --tab-width %d',
            \           s:prettier_stdin_file_path(),
            \           shiftwidth()
            \       ),
            \   'scss': printf(
            \       'prettier --parser scss --stdin %s --tab-width %d',
            \           s:prettier_stdin_file_path(),
            \           shiftwidth()
            \       ),
            \   'markdown': printf(
            \       'prettier --parser markdown --stdin %s',
            \           s:prettier_stdin_file_path()
            \       ),
            \   'yaml': printf(
            \       'prettier --parser yaml --stdin %s',
            \           s:prettier_stdin_file_path()
            \       ),
            \   'html': 'html-beautify -I -p -f - -s ' . shiftwidth(),
            \   'javascript': 'standard --fix --stdin',
            \   'json': 'fixjson -indent ' . shiftwidth(),
            \   'python': 'autopep8 -',
            \   'sh': 'shfmt'
            \ })

fun! s:prettier_stdin_file_path() abort " {{{2
    return !empty(expand('%:p'))
                \ ? '--stdin-filepath "' . expand("%:p") . '"'
                \ : ''
endfun " 2}}}
" 1}}}

" >>> Tags {{{1
if executable('ctags')
    if &tags !~# '\.tags'
        let &tags .= ',.tags'
    endif
    command! GenTags :call ka#module#gentags#Auto()
endif
" 1}}}

" =========== AUTOCOMMANDS ===================================

" All custom autocommands {{{1
augroup CustomAutoCmds
    autocmd!

    " Indentation per filetype
    autocmd FileType yaml,javascript,coffee,html,css,scss,pug,vader,ruby,markdown
                \ setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType vim,python,json
                \ setlocal softtabstop=4 shiftwidth=4 expandtab

    " Quicklist & location window related
    autocmd FileType qf setlocal nowrap
    autocmd FileType qf nnoremap <silent> <buffer> <CR> :pclose!<CR><CR>
    autocmd FileType qf nnoremap <silent> <buffer> p
                \ :call <SID>PreviewQItem()<CR>
    autocmd FileType qf nnoremap <silent> <buffer> P :pclose<CR>

    " Set omni-completion if the appropriate syntax file is present otherwise
    " use the syntax completion
    if exists('+omnifunc')
        autocmd! Filetype *
                    \ if empty(&omnifunc)
                    \|  setlocal omnifunc=syntaxcomplete#Complete
                    \| endif
    endif

    autocmd CompleteDone * pclose
    autocmd BufWritePre * call <SID>AutoMkdir()
    autocmd BufWinEnter * call <SID>AutoFoldColumn()

    " Fix some annoyances
    autocmd FileType vim setlocal textwidth=0
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    if g:has_term
        autocmd TerminalOpen * if &buftype is# 'terminal'
                    \|	setlocal nonumber bufhidden=hide noswapfile nobuflisted
                    \| endif
    endif
augroup END
" 1}}}

" =========== ABBREVIATIONS ====================================

" No more rage {{{1
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev QA! qa!
cnoreabbrev QA qa
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
" 1}}}

" Custom commands {{{1
cnoreabbrev e E
cnoreabbrev sp Sp
cnoreabbrev vs VS
cnoreabbrev tabe TabE
cnoreabbrev bd Bd
" 1}}}

" System utilities {{{1
cnoreabbrev rm Rm
cnoreabbrev mkdir Mkdir
cnoreabbrev cp Cp
cnoreabbrev mv Mv
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
