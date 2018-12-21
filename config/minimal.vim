" ========== Minimal vimrc without plugins (Unix & Windows) ====
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-21
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

" Set dirs for viminfo & mkview {{{1
let &viminfo = '''100,<50,s10,h,n' . g:vim_dir . '/misc/viminfo'
let &viewdir = g:vim_dir . '/misc/view'
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
highlight! link HelpBar Normal
highlight! link HelpStar Normal
" 1}}}

" Change cursor shape in insert mode in terminal {{{1
" N.B: may display graphical artefacts in some terminals
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
" Do not reset the guifont option more than once to avoid gvim window changing
" its size
if empty(&guifont)
    let &guifont = g:is_win ?
                \ 'InconsolataForPowerline NF Medium:h10:cANSI' :
                \ 'FuraMono NF Medium 11'
endif
" 1}}}

" >>> Messages & info {{{1
set confirm         " Start a dialog when a command fails
set shortmess+=c    " Disable ins-completion-menu messages with c
set showcmd
" 1}}}

" >>> Edit text {{{1
set infercase       " Adjust case of a keyword completion match.
set completeopt=menuone,noselect,preview
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
nnoremap <silent> <A-k> :call <SID>move_selection(-1)<CR>==
nnoremap <silent> <A-j> :call <SID>move_selection(1)<CR>==
xnoremap <silent> <A-k> :call <SID>move_selection(-1)<CR>gv=gv
xnoremap <silent> <A-j> :call <SID>move_selection(1)<CR>gv=gv

fun! s:move_selection(to) range " {{{2
    " a:to : -1/1 <=> up/down
    let fl = a:firstline | let ll = a:lastline
    let cl = line('.')
    let to = a:to is# -1 ?
                \ fl - 2 : (ll + 1 >=# line('$') ? line('$') : ll + 1)
    " unfold the target line before moving there
    silent execute to ' | normal! zv | ' . cl
    execute printf(':%d,%dm%d', fl, ll, to)
endfun " 2}}}

" Tags
nnoremap <silent> <C-]> :call <SID>go_to_tag_custom()<CR>
nnoremap <silent> g<C-]> :call <SID>go_to_tag_custom(1)<CR>

fun! s:go_to_tag_custom(...) abort " {{{2
    " tjump to a tag <cexpr>, and if it does not exist search for a tag
    " containing the expression with 'tselect /expr'
    let split = get(a:, 1, 0)
    try
        let exp = expand('<cexpr>')
        let cmd = split ? 'vertical stjump' : 'tjump'
        execute cmd . ' ' . exp
        normal! ztzv
    catch /^Vim\%((\a\+)\)\=:E426/
        " E426: no tag found
        try
            let cmd = split ? 'vertical stselect' : 'tselect'
            execute cmd . ' /' . exp
        catch /^Vim\%((\a\+)\)\=:\(E426\|E349\)/
            " E349: no identifier on cursor
            call ka#ui#echo('[E]', v:exception, 'Error')
        endtry
    endtry
endfun " 2}}}
" 1}}}

" >>> Yanking {{{1
nnoremap Y y$
nnoremap <silent> yd :call <SID>duplicate()<CR>
xnoremap <silent> <C-d> :t'><CR>gv<Esc>

fun! s:duplicate() abort " {{{2
    let ip = getpos('.') | silent .t. | call setpos('.', ip)
endfun " 2}}}
" 1}}}

" >>> Folding {{{1
nnoremap <silent> <space> za
xnoremap <silent> <space> :fold<CR>
" 1}}}

" >>> Searching {{{1
nnoremap <silent> ghh :nohlsearch<CR>
nnoremap / /\V
nnoremap ? ?\V
nnoremap <silent> * *``
nnoremap <silent> # #``
vnoremap <silent> * :<C-u>call <SID>visual_set_search()<CR>//<CR>``
vnoremap <silent> # :<C-u>call <SID>visual_set_search()<CR>??<CR>``
" A quick way to use gn in normal mode
nnoremap c* *``cgn
nnoremap c# #``cgn
nnoremap d* *``dgn
nnoremap d# #``dgn

" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
fun! s:visual_set_search() abort " {{{2
    let temp = @@
    normal! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfun " 2}}}
" 1}}}

" >>> Buffers {{{1
nnoremap ,b :ls<CR>:b 
nnoremap <silent> <S-l> :call <SID>move_to_buf(1)<CR>
nnoremap <silent> <S-h> :call <SID>move_to_buf(-1)<CR>
nnoremap <silent> <BS> <C-^>
" For this mapping, check zoom_toggle function
nnoremap <silent> <S-q> :bwipeout<CR>

fun! s:move_to_buf(dir) abort " {{{2
    let cmd = a:dir ># 0 ? 'bnext!' : 'bprevious!'
    silent execute cmd
    while &l:filetype is# 'qf'
        silent execute cmd
    endwhile
endfun " 2}}}
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
nnoremap <silent> <up> :resize +5<CR>
nnoremap <silent> <down> :resize -5<CR>
nnoremap <silent> <left> :vertical resize -5<CR>
nnoremap <silent> <right> :vertical resize +5<CR>

if g:is_gui
    nnoremap <silent> <c-h> <C-w><Left>
    nnoremap <silent> <c-j> <C-w><Down>
    nnoremap <silent> <c-k> <C-w><Up>
    nnoremap <silent> <c-l> <C-w><Right>
else
    nnoremap <silent> <c-h> :call <SID>tmux_move('h')<CR>
    nnoremap <silent> <c-j> :call <SID>tmux_move('j')<CR>
    nnoremap <silent> <c-k> :call <SID>tmux_move('k')<CR>
    nnoremap <silent> <c-l> :call <SID>tmux_move('l')<CR>
endif

" Move between splits & tmux " {{{2
" https://gist.github.com/mislav/5189704#gistcomment-1735600
fun! s:tmux_move(direction) abort
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the winnr is still the same after we moved, it is the last pane
    if wnr is# winnr()
        call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    endif
endfun " 2}}}
" 1}}}

" >>> Sort {{{1
xnoremap <leader>s :!sort<CR>
nnoremap <silent> <leader>s <Esc>:setlocal operatorfunc=<SID>sort<CR>g@

fun! s:sort(...) abort " {{{2
    execute printf('%d,%d:!sort', line("'["), line("']"))
endfun " 2}}}
" 1}}}

" >>> Open (with) external programs {{{1
nnoremap <silent> gx :call ka#sys#open_url()<CR>
" Terminal
nnoremap <silent> ;t :call ka#sys#open_here('t')<CR>
nnoremap <silent> ;;t :call ka#sys#open_here('t', expand('%:h:p'))<CR>
" File manager
nnoremap <silent> ;f :call ka#sys#open_here('f')<CR>
nnoremap <silent> ;;f :call ka#sys#open_here('f', expand('%:h:p'))<CR>
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
"   - ie: Entire file
"   - il: Current line without whitespace
" Scss/Css ***
"    - iV: Value
"    - iP: Property
let s:to = {
            \   '_' : [
            \       ['ie', 'ggVG'],
            \       ['il', '^vg_'],
            \   ],
            \   'scss,css' : [
            \       ['iV', '^f:wvt;'], ['iP', '^f:Bvt:'],
            \   ]
            \ }
call ka#utils#make_text_objs(s:to)
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
" The following is overwritten in config/plugins
nnoremap ,,g :call <SID>grep()<CR>
nnoremap ,,G :call <SID>grep('', '!')<CR>
xnoremap <silent> ,,g :call <SID>grep(1)<CR>
xnoremap <silent> ,,G :call <SID>grep(1, '!')<CR>
nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>grep_motion<CR>g@
nnoremap <silent> ,G <Esc>:setlocal operatorfunc=<SID>grep_reg_motion<CR>g@

fun! s:grep(...) abort " {{{2
    let use_regex = exists('a:2') ? 1 : 0

    if exists('a:1') && type(a:1) is# v:t_number
        let q = a:1 is# 1
                    \ ? ka#utils#get_visual_selection()
                    \ : ka#utils#get_motion_result()
    else
        let inp_msg = use_regex
                    \ ? 'grep[reg]>'
                    \ : 'grep>'
        echohl ModeMsg | let q = input(inp_msg . ' ') | echohl None
    endif

    if use_regex
        let old_grepprg = &grepprg
        let &grepprg = substitute(&grepprg, '-SF', '-S', '')
    endif

    if !empty(q)
        let [query, path] = matchlist(q, '\v^(".*"|\S+)%(\s+(\f+)$)?')[1:2]
        let query = escape(query, '%#')
        if empty(path)
            let path = '.'
        endif

        if g:has_job
            let cmd = printf('%s %s %s', &grepprg, query, path)
            call ka#job#start(cmd, {'realtime': 1, 'std': 'out'})
        else
            " Revert escaping
            let query = substitute(query, '\#', '#', 'g')
            let query = substitute(query, '\\%', '%', 'g')
            silent execute 'grep! "' . query . '" ' . path
            botright cwindow 10 | wincmd p
        endif
    endif

    if use_regex
        let &grepprg = old_grepprg
    endif
endfun " 2}}}

fun! s:grep_motion(...) abort " {{{2
    call <SID>grep(2)
endfun " 2}}}

fun! s:grep_reg_motion(...) abort " {{{2
    call <SID>grep(2, '!')
endfun " 2}}}
" 1}}}

" >>> Reselect visual selection after (in/de)creasing numbers {{{1
xnoremap <C-a> <C-a>gv
xnoremap <C-x> <C-x>gv
" 1}}}

" >>> Go to line using hints {{{1
nnoremap gj :call ka#module#gotohint#go('j')<CR>
nnoremap gk :call ka#module#gotohint#go('k')<CR>
" 1}}}

" >>> Terminal mode {{{1
if g:has_term
    tnoremap jk <C-w>N
    tnoremap <C-h> <C-w>h
    tnoremap <C-l> <C-w>l
    tnoremap <C-k> <C-w>k
    tnoremap <C-j> <C-w>j
    tnoremap <silent> <S-q> <C-w>:call <SID>term_kill()<CR>
    " Note that the following mappings replace the open_here ones
    nnoremap <silent> ;t :call <SID>term_toggle()<CR>
    nnoremap <silent> ;;t :call <SID>term_toggle(1)<CR>
    tnoremap <silent> ;t <C-w>:call <SID>term_toggle()<CR>

    fun! s:term_toggle(...) abort " {{{2
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
    endfun " 2}}}

    fun! s:term_kill() abort " {{{2
        let term_buf_nr = get(g:, 'term_buf_nr', 0)
        if term_buf_nr && index(term_list(), term_buf_nr) isnot# -1
                    \ && bufloaded(term_buf_nr)
            silent execute term_buf_nr . 'bwipeout!'
            unlet! g:term_buf_nr
        endif
    endfun " 2}}}
endif
" 1}}}

" >>> Clever gf {{{1
nnoremap <silent> gf :call <SID>clever_gf()<CR>
nnoremap <silent> gF :call <SID>clever_gf(1)<CR>

fun! s:clever_gf(...) abort " {{{2
    " Expand 2 times in case we have $HOME or ~
    let cf = fnamemodify(expand(expand('<cfile>')), '%:p')
    if isdirectory(cf)
        return ''
    endif
    if exists('a:1')
        execute 'vsplit ' . cf
    else
        execute filereadable(cf)
                    \ ? 'normal! gf'
                    \ : 'edit ' . cf
    endif
endfun " 2}}}
" 1}}}

" >>> Super Find {{{1
nnoremap ,f :F 
" 1}}}

" >>> Completion  {{{1
call ka#module#mashtab#i()
imap <Tab> <Plug>(mashtabTab)
imap <BS> <Plug>(mashtabBS)
silent execute 'inoremap <silent>' . (g:is_gui
            \ ? '<C-space> <C-x><C-o>'
            \ : '<C-@> <C-x><C-o>')
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

fun! s:complete_completion_types(a, c, p) abort " {{{2
    let types = ['path', 'ulti', 'spell',
                \ 'kspell', 'omni', 'user',
                \ 'dict', 'buffer', 'line']
    return filter(copy(types), 'v:val =~ a:a')
endfun " 2}}}
" 1}}}

" >>> Zoom  {{{1
nnoremap <silent> gsz :call <SID>zoom_toggle()<CR>
nnoremap <silent> <expr> <S-q> get(w:, 'zoomed_win', 0)
            \ ? ":normal gsz\<CR>"
            \ : ":bwipeout\<CR>"

fun! s:zoom_toggle() abort " {{{2
    let zoomed_win = getwinvar(winnr(), 'zoomed_win')
    let one_win_only = tabpagewinnr(tabpagenr(), '$') is# 1 ? 1 : 0
    if one_win_only && zoomed_win is# 1
        silent tabclose
        unlet! w:zoomed_win
    elseif !one_win_only
        silent tab split
        let w:zoomed_win = 1
    endif
endfun " 2}}}
" 1}}}

" =========== COMMANDS ===================================

" >>> Commands for folders & files {{{1
" TODO: Add windows commands
command! -nargs=+ -complete=file Rm
            \ call ka#sys#execute_cmd('rm -vr ', '<args>')
command! -nargs=+ -complete=file Mkdir
            \ call ka#sys#execute_cmd('mkdir -vp ', '<args>')
command! -nargs=+ -complete=file Cp
            \ call ka#sys#execute_cmd('cp -vrf ', '<args>')
command! -nargs=+ -complete=file Mv
            \ call ka#sys#execute_cmd('mv -vf ', '<args>')
command! -nargs=1 -complete=file Rename
            \ call ka#sys#rename('<args>')
" 1}}}

" >>> Specify indentation (ts,sts,sw) & reindent {{{1
command! -nargs=? Indent :call <SID>indent(<f-args>)

fun! s:indent(...) abort " {{{2
    let pos = getpos('.')
    let opts = ['softtabstop', 'shiftwidth']
    let old_i = []
    for o in opts
        call add(old_i, getbufvar('%', '&' . o))
    endfor
    echohl Question
    let new_i = exists('a:1') ? a:1 :
                \ input(printf('%d:%d> ',
                \   old_i[0], old_i[1]))
    echohl None
    if !empty(new_i)
        for o in opts
            silent execute printf('setlocal %s=%d', o, new_i)
        endfor
    endif
    silent execute '%normal! =='
    call setpos('.', pos)
endfun " 2}}}
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
command! -nargs=? Spell call <SID>set_spell(<f-args>)

fun! s:set_spell(...) abort " {{{2
    if !&l:spell
        let s:spelllang = &l:spelllang
        let l = get(a:, 1, 'fr')
        let &l:spelllang = l
        setlocal spell
    else
        setlocal nospell
        let &l:spelllang = get(s:, 'spelllang', &l:spelllang)
    endif
endfun " 2}}}
" 1}}}

" >>> Enable folding when needed {{{1
command! Fold :call <SID>fold({
                \   'coffee'    : ['indent'],
                \   'css'       : ['marker', ' {,}'],
                \   'javascript': ['syntax'],
                \   'php'       : ['marker', ' {,}'],
                \   'python'    : ['indent'],
                \   'scss'      : ['marker', ' {,}'],
                \   'sh'        : ['marker', ' {,}'],
                \ })

fun! s:fold(indentations) abort " {{{2
    if !has_key(a:indentations, &filetype)
        call ka#ui#echo(
                    \   '[fold]',
                    \   'no folding method for "' . &filetype . '"',
                    \   'Error'
                    \ )
        return
    endif
    let ft = a:indentations[&filetype]
    let type = ft[0]
    let marker = len(ft) ># 1 ? ft[1] : ''
    let [foldmethod, foldmarker] = [&foldmethod, &foldmarker]

    if empty(getbufvar('%', 'fold_by_marker'))
        silent execute 'setlocal foldmethod=' . type
        if !empty(marker)
            silent execute 'setlocal foldmarker=' . escape(marker, ' ')
        endif
        setlocal foldenable
        normal! zR
        call setbufvar('%', 'fold_by_marker', 1)
        " Be sure to have foldcolumn enabled
        setlocal foldcolumn=1
        call ka#ui#echo('[fold-' . type . ']', 'enabled', 'ModeMsg')
    else
        setlocal nofoldenable
        silent execute 'setlocal foldmethod=' . foldmethod
        silent execute 'setlocal foldmarker=' . escape(foldmarker, ' ')
        call setbufvar('%', 'fold_by_marker', 0)
        setlocal foldcolumn=0
        call ka#ui#echo('[fold-' . type . ']', 'disabled', 'ModeMsg')
    endif
endfun " 2}}}
" 1}}}

" >>> Echo vim expression in a buffer __Echo__ {{{1
command! -nargs=* -complete=expression Echo :call <SID>echo(<f-args>)

fun! s:echo(...) abort " {{{2
    let out = ''
    redir => out
    silent execute 'echo ' . join(a:000, '')
    redir END
    if !empty(out[1:])
        call ka#utils#create_or_go_to_buf('__Echo__', 'vim', 'sp')
        setlocal noswapfile buftype=nofile
        call setline(1, out[1:])
    endif
endfun " 2}}}
" 1}}}

" >>> Persistent scratch buffer {{{1
command! -nargs=? -complete=filetype Scratch :call s:scratch(<f-args>)

fun! s:scratch(...) abort " {{{2
    let bufname = '__Scratch__'
    let ft = get(a:, 1, 'markdown')
    call ka#utils#create_or_go_to_buf(bufname, ft, 'topleft split')
    if exists('g:scratch')
        silent %delete_
        call setbufline(bufnr(bufname), 1, g:scratch)
    else
        augroup Scratch
            autocmd!
            autocmd InsertLeave,CursorHold,CursorHoldI,TextChanged __Scratch__
                        \ let g:scratch = getline(1, line('$'))
        augroup END
    endif

    setlocal noswapfile buftype=nofile
endfun " 2}}}
" 1}}}

" >>> Chmod current file {{{1
command! ChmodX :!chmod +x %
" 1}}}

" >>> Auto mkdir when creating/saving file {{{1
fun! s:auto_mkdir() abort " {{{2
    let dir = expand('<afile>:p:h')
    let file = expand('<afile>:t')
    if !isdirectory(dir)
        echohl Question
        let ans = input(dir . ' does not exist, create it [y/N]? ')
        echohl None
        if empty(ans) || ans =~? '^n$'
            echomsg 'no'
            return
        endif
        call mkdir(dir, 'p')
        silent execute 'saveas ' . dir . '/' . file
        " Then wipeout the alternative buffer if it have the same name.
        if bufname('#') is# dir . '/' . file
            silent execute 'bwipeout! ' . bufnr('#')
        endif
    endif
endfun " 2}}}
" 1}}}

" >>> Quickfix & location fix windows {{{1
nnoremap <silent> ]q :call <SID>move_in_qf('q', '1')<CR>
nnoremap <silent> [q :call <SID>move_in_qf('q', '-1')<CR>
nnoremap <silent> ]l :call <SID>move_in_qf('l', '1')<CR>
nnoremap <silent> [l :call <SID>move_in_qf('l', '-1')<CR>

fun! s:move_in_qf(l, dir) abort " {{{2
    let [c_l, pre_cmd] = a:l is# 'q'
                \ ? [len(getqflist()), 'c']
                \ : [len(getloclist(0)), 'l']
    try
        execute c_l is# 1
                    \ ? repeat(pre_cmd, 2) . '!'
                    \ : a:dir ># 0
                    \ ? pre_cmd . 'next!'
                    \ : pre_cmd . 'previous'
        normal! zv
    catch /^Vim\%((\a\+)\)\=:\(E42\|E553\)/
        call ka#ui#echo('[E]', v:exception, 'Error')
    endtry
endfun " 2}}}
" 1}}}

" >>> Enable foldcolumn only when folds are present {{{1
fun! s:auto_fold_column() abort " {{{2
    let pos = getpos('.')
    let c_l = line('.')
    let there_are_folds = 0

    if foldlevel(c_l)
        let there_are_folds = 1
    endif

    if !there_are_folds
        normal! ggzj
        if line('.') isnot# 1
            let there_are_folds = 1
        endif
    endif

    if !there_are_folds
        normal! ]z
        if line('.') isnot# 1
            let there_are_folds = 1
        endif
    endif

    call setpos('.', pos)

    if there_are_folds
        setlocal foldcolumn=1
    endif
endfun " 2}}}
" 1}}}

" >>> Operate on multiple files/buffers at once {{{1
command! -bar -bang -nargs=* -complete=file E
            \ call <SID>cmd_on_multiple_files('edit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file Sp
            \ call <SID>cmd_on_multiple_files('split', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file VS
            \ call <SID>cmd_on_multiple_files('vsplit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=file TabE
            \ call <SID>cmd_on_multiple_files('tabedit', [<f-args>], '<bang>')
command! -bar -bang -nargs=* -complete=buffer Bd
            \ call <SID>cmd_on_multiple_bufs('bdelete', [<f-args>], '<bang>')

" An alternative to :find
if executable('rg')
    command! -bar -bang -nargs=* -complete=customlist,<SID>complete_files F
                \ execute 'E ' . <q-args>
endif

fun! s:cmd_on_multiple_files(cmd, list_pattern, bang) abort " {{{2
    let cmd = a:cmd . a:bang

    if a:list_pattern ==# []
        execute cmd
        return
    endif

    for p in a:list_pattern
        if match(p, '\v\?|*|\[|\]') >=# 0
            " Expand wildcards only if they exist
            for f in glob(p, 0, 1)
                if filereadable(f)
                    execute cmd . ' ' . f
                endif
            endfor
        else
            " Otherwise execute the command
            execute cmd . ' ' . p
        endif
    endfor
endfun " 2}}}

fun! s:cmd_on_multiple_bufs(cmd, list_pattern, bang) abort " {{{2
    let cmd = a:cmd . a:bang

    if a:list_pattern ==# []
        execute cmd
        return
    endif

    for p in a:list_pattern
        for f in getcompletion(p, 'buffer', 1)
            if bufloaded(f)
                try
                    execute cmd . ' ' . f
                catch
                    break
                endtry
            endif
        endfor
    endfor
endfun " 2}}}

fun! s:complete_files(a, c, p) abort " {{{2
    let cmd = 'rg --files --hidden --glob !.git/'
    return filter(systemlist(cmd), 'v:val =~ a:a')
endfun " 2}}}
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

command! -nargs=+ -complete=customlist,<SID>complete_notes Note
            \ call <SID>note(<f-args>)
command! -nargs=+ -complete=customlist,<SID>complete_notes NoteDelete
            \ call <SID>note_delete(<f-args>)

" Update the date when the file is saved {{{2
augroup Notes
    autocmd!
    let s:str =
                \ 'autocmd BufWrite %s/*.md ' .
                \ ':call setline(1,  "> " . strftime("%%d %%b %%Y %%X"))'
    execute printf(s:str, s:notes_dir)
    unlet! s:str
augroup END " 2}}}

fun! s:note(file) abort " {{{2
    let file_name = s:notes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')

    let add_date = file_readable(file_name) ? 0 : 1
    silent execute 'vnew! ' . file_name
    if add_date
        call setline(1,  ["> " . strftime("%d %b %Y %X"), ''])
        normal! G
    endif
endfun " 2}}}

fun! s:note_delete(file) abort " {{{2
    let file_name = s:notes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')
    call ka#sys#delete(file_name)
endfun " 2}}}

fun! s:complete_notes(a, c, p) " {{{2
    return filter(map(glob(s:notes_dir . '/*', 1, 1), {i, v ->
                \   fnamemodify(v, ':p:t')
                \ }),
                \ {i, v -> v =~ a:a })
endfun " 2}}}
" 1}}}

" >>> Fixnformat module  {{{1
command! -range=% FixNFormat :call ka#module#fixnformat#run(<line1>, <line2>,
            \ {
            \   'css': 'prettier --parser css --stdin --tab-width ' .
            \       shiftwidth(),
            \   'scss': 'prettier --parser scss --stdin --tab-width ' .
            \       shiftwidth(),
            \   'markdown': 'prettier --parser markdown --stdin',
            \   'yaml': 'prettier --parser yaml --stdin',
            \   'html': 'html-beautify -I -p -f - -s ' . shiftwidth(),
            \   'javascript': 'standard --fix --stdin',
            \   'json': 'fixjson -indent ' . shiftwidth(),
            \   'python': ['isort -', 'autopep8 -'],
            \   'sh': 'shfmt'
            \ })
" 1}}}

" >>> Gentags module {{{1
if executable('ctags')
    call ka#module#gentags#auto_enable()
    command! GenTags call ka#module#gentags#enable_for_wd()
endif
" 1}}}

" =========== AUTOCOMMANDS ===================================

" All custom autocommands {{{1
augroup CustomAutoCmds
    autocmd!

    " Indentation per filetype
    autocmd FileType
                \ yaml,javascript,coffee,html,css,scss,pug,vader,ruby,markdown
                \ setlocal softtabstop=2 shiftwidth=2 expandtab
    autocmd FileType vim,python,json
                \ setlocal softtabstop=4 shiftwidth=4 expandtab

    " Set omni-completion if the appropriate syntax file is present otherwise
    " use the syntax completion
    if exists('+omnifunc')
        autocmd! Filetype *
                    \ if empty(&omnifunc)
                    \|  setlocal omnifunc=syntaxcomplete#Complete
                    \| endif
    endif

    autocmd CompleteDone * pclose
    autocmd BufWritePre * call <SID>auto_mkdir()
    autocmd BufWinEnter * call <SID>auto_fold_column()

    " Fix some annoyances
    autocmd FileType vim setlocal textwidth=0
    autocmd FileType *
                \ setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
