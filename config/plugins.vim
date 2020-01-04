" ========== Vim plugins configurations (Unix & Windows) =======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2020-01-05
" ==============================================================


" Global vars  {{{1

" Store checker unicode characters and hi-groups, to keep uniformity between
" plugins & statusline.
let g:checker = {
            \   'error_sign'   : '⨉',
            \   'warning_sign' : '⬥',
            \   'success_sign' : '',
            \   'error_group'  : 'Error',
            \   'warning_group': 'Function',
            \ }
" 1}}}

" =========== VIM-PLUG =========================================

" Initialization {{{1
call plug#begin(g:vim_dir . '/plugs')
" 1}}}

" Plugins {{{1

" Syntaxes {{{2
Plug 'digitaltoad/vim-pug'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'rhysd/vim-gfm-syntax'
Plug 'tpope/vim-haml'
Plug 'vim-python/python-syntax'
" 2}}}

" CSS {{{2
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/csscomplete.vim', {'for': 'css'}
" 2}}}

" PHP {{{2
Plug '2072/PHP-Indenting-for-VIm', {'for': 'php'}
Plug 'StanAngeloff/php.vim'
" 2}}}

" JavaScript {{{2
Plug 'othree/yajs.vim'
            \ | Plug 'othree/javascript-libraries-syntax.vim'
" 2}}}

" VimL {{{2
Plug 'machakann/vim-Verdin'
" 2}}}

" LSP & completion {{{2
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 2}}}

" Web development {{{2
Plug 'alvan/vim-closetag', {'for': ['html', 'php', 'xml']}
" Plug 'mattn/emmet-vim'
Plug 'KabbAmine/emmet-vim'
" 2}}}

" Git {{{2
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" 2}}}

" Snippets engine {{{2
Plug 'SirVer/ultisnips'
" 2}}}

" Edition & moving {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'machakann/vim-sandwich'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
            \| Plug 'glts/vim-textobj-comment'
            \| Plug 'somini/vim-textobj-fold',
            \| Plug 'kana/vim-textobj-function'
            \| Plug 'haya14busa/vim-textobj-function-syntax'
            \| Plug 'bps/vim-textobj-python', {'for': 'python'}
            \| Plug 'kentaro/vim-textobj-function-php', {'for': 'php'}
            \| Plug 'thinca/vim-textobj-function-javascript',
            \   {'for': 'javascript'}
" 2}}}

" Misc {{{2
Plug 'junegunn/vader.vim', {'on': 'Vader', 'for': 'vader'}
Plug 'junegunn/vim-emoji', {'for': ['markdown', 'gitcommit']}
Plug 'mbbill/undotree'   , {'on': 'UndotreeToggle'}
Plug 'w0rp/ale'
" 2}}}

" Interface {{{2
Plug 'itchyny/vim-parenmatch'
Plug 'machakann/vim-highlightedyank',
" 2}}}

" My Plugins {{{2
" Plug 'KabbAmine/unite-cmus'
" Plug 'KabbAmine/gulp-vim'
" Plug 'KabbAmine/vZoom.vim'
" Plug $HOME . '/Temp/lab/vim/RAP/'
Plug $HOME . '/Projets/vim/vfinder/'
Plug $HOME . '/Projets/vim/vfinder-cmus/'
Plug $HOME . '/Projets/vim/pine.vim/'
Plug 'KabbAmine/lazyList.vim'
Plug 'KabbAmine/vBox.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'KabbAmine/vullscreen.vim'
Plug 'KabbAmine/yowish.vim'
Plug 'KabbAmine/zeavim.vim'
" 2}}}
" 1}}}

" End {{{1
call plug#end()
" 1}}}

" =========== COLORS ============================================

" Colors {{{1
let g:yowish = {
            \   'term_italic' : 1,
            \   'colors': {
            \       'background'     : ['#2f343f', 'none'],
            \       'backgroundDark' : ['#191d27', '16'],
            \       'backgroundLight': ['#464b5b', '59'],
            \       'blue'           : ['#5295e2', '68'],
            \       'comment'        : ['#5b6176', '245'],
            \       'lightBlue'      : ['#e39f52', '179'],
            \       'lightYellow'    : ['#80aee3', '110'],
            \       'yellow'         : ['#5295e2', '68'],
            \   }
            \ }
colorscheme yowish
if g:is_termguicolors
    " Make bg transparent with truecolors on terminal
    highlight Normal guibg=NONE
    highlight! link LineNr Comment
    highlight! link FoldColumn Comment
endif
if g:has_term
    highlight! link StatusLineTerm StatusLineNC
    highlight! link StatusLineTermNC Terminal
    highlight SpellBad cterm=underline ctermbg=black ctermfg=red
endif
" Manually execute the ColorScheme event (Useful for some plugins)
silent doautocmd ColorScheme
" }}}

" =========== PLUGINS CONFIGS ==================================

" >>> (( closetag )) {{{1
let g:closetag_filenames = '*.html,*.xml,*.php'
" 1}}}

" >>> (( python-syntax )) {{{1
let python_highlight_all = 1
" 1}}}

" >>> (( ale )) {{{1
" Disabled by default
let g:ale_enabled = 0
nmap <silent> <F8> :ALEToggle<CR>
let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = g:checker.error_sign
let g:ale_sign_warning = g:checker.warning_sign
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let [g:ale_echo_msg_error_str, g:ale_echo_msg_warning_str] = ['E', 'W']
exe 'highlight! link ALEErrorSign ' . g:checker.error_group
exe 'highlight! link ALEWarningSign ' . g:checker.warning_group
" Specific to file types and are here for reference
let g:ale_linters = {
            \   'c'              : ['gcc'],
            \   'coffee'         : ['coffee', 'coffeelint'],
            \   'css'            : ['csslint'],
            \   'html'           : ['htmlhint'],
            \   'javascript'     : ['standard'],
            \   'json'           : ['jsonlint'],
            \   'markdown'       : ['mdl'],
            \   'php'            : ['php'],
            \   'python'         : ['flake8'],
            \   'scss'           : ['sasslint'],
            \   'sh'             : ['shellcheck', 'shell'],
            \   'vim'            : ['vint'],
            \   'yaml'           : ['yamllint'],
            \ }
let g:ale_vim_vint_show_style_issues = 0
" 1}}}

" >>> (( emmet )) {{{1
let g:emmet_html5 = 1
let g:user_emmet_install_global = 0

augroup EmmetMaps " {{{2
    autocmd!
    autocmd FileType html,scss,css,pug,javascript EmmetInstall
    autocmd FileType html,scss,css,pug,javascript
                \ imap <silent> <buffer> jhh <plug>(emmet-expand-abbr)
    autocmd FileType scss,css setlocal completefunc=emmet#completeTag
augroup END " 2}}}
" 1}}}

" >>> (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" 1}}}

" >>> (( delimitmate )) {{{1
imap <S-space> <Plug>delimitMateS-Tab
imap <expr> <CR> pumvisible() ? "\<C-Y>\<CR>" : "<Plug>delimitMateCR"
imap <expr> <BS> pumvisible() ? "<Plug>(mashtabBS)" : "<Plug>delimitMateBS"
if &backspace is# 2
    let delimitMate_expand_cr = 1
endif
let delimitMate_expand_space = 1
let delimitMate_matchpairs = '(:),[:],{:}'
let delimitMate_excluded_ft = 'vfinder'
" 1}}}

" >>> (( ultisnips )) {{{1
nnoremap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsEditSplit = 'vertical'

" Personal snippets folder.
let g:UltiSnipsSnippetsDir = g:vim_dir . '/misc/snippets'
let g:UltiSnipsSnippetDirectories =
            \ [g:vim_dir . '/misc/snippets']
" 1}}}

" >>> (( vim-signify )) {{{1
let g:signify_vcs_list = ['git']
let g:signify_sign_add = '❙'
let g:signify_sign_delete = g:signify_sign_add
let g:signify_sign_delete_first_line = g:signify_sign_add
let g:signify_sign_change = g:signify_sign_add
let g:signify_sign_changedelete = g:signify_sign_add
let g:signify_sign_show_count = 0
highlight! link SignifySignAdd Question
highlight! link SignifySignDelete Title
highlight! link SignifySignChange ModeMsg
" 1}}}

" >>> (( vim-plug )) {{{1
let g:plug_threads = 10
let g:plug_window = 'enew'
highlight! link PlugDeleted Conceal
" 1}}}

" >>> (( vim-lion )) {{{1
let g:lion_create_maps = 1
let g:lion_map_right = '<CR>'
let g:lion_map_left = ''
" 1}}}

" >>> (( fugitive )) {{{1
" Split, vsplit & tab
augroup FugitiveCustom " {{{2
    autocmd!
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-s> :norm o<CR>
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-v> :norm S<CR>
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-t> :norm O<CR>
    " Refresh signify after commiting
    autocmd BufDelete COMMIT_EDITMSG SignifyRefresh
augroup END " 2}}}

" Aliases
cabbrev Ga Git add
cabbrev Gb Git branch
cabbrev Gch Git checkout
cabbrev Gco Gcommit
cabbrev Gl Git log --oneline
cabbrev Gm Gmerge
cabbrev Gs Gstatus
cabbrev Gst Git stash
cabbrev Gt Git tag
" 1}}}

" >>> (( vim-commentary )) {{{1
augroup Commentary " {{{2
    autocmd!
    autocmd FileType vader,cmusrc setlocal commentstring=#\ %s
    autocmd FileType xdefaults setlocal commentstring=!\ %s
    " for jsonc
    autocmd FileType json setlocal commentstring=//\ %s
augroup END " 2}}}
" 1}}}

" >>> (( vim-highlightedyank )) {{{1
let g:highlightedyank_highlight_duration = 200
" 1}}}

" >>> (( vim-sandwich )) {{{1
call operator#sandwich#set('all', 'all', 'cursor', 'keep')
call operator#sandwich#set('all', 'all', 'hi_duration', 150)
call operator#sandwich#set('all', 'all', 'autoindent', 0)
" vmap v ab
" Allow using . with the keep cursor option enabled
nmap . <Plug>(operator-sandwich-dot)
hi link OperatorSandwichStuff StatusLine
" 1}}}

" >>> (( vim-parenmatch )) {{{1
let g:parenmatch_highlight = 0
highlight! link ParenMatch Underlined
" 1}}}

" >>> (( vim-emoji )) {{{1
augroup Emoji
    autocmd!
    autocmd FileType markdown,gitcommit :setl completefunc=emoji#complete
augroup END
" 1}}}

" >>> (( textobj-usr )) & its plugins {{{1

" (( vim-textobj-comment )) {{{2
let g:textobj_comment_no_default_key_mappings = 1
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)
" 2}}}

" (( vim-textobj-python )) {{{2
let g:textobj_python_no_default_key_mappings = 1
augroup TOPython
    autocmd!
    " Functions
    autocmd Filetype python xmap <buffer> af <Plug>(textobj-python-function-a)
    autocmd Filetype python omap <buffer> af <Plug>(textobj-python-function-a)
    autocmd Filetype python xmap <buffer> if <Plug>(textobj-python-function-i)
    autocmd Filetype python omap <buffer> if <Plug>(textobj-python-function-i)
    " Classes
    autocmd Filetype python xmap <buffer> aC <Plug>(textobj-python-class-a)
    autocmd Filetype python omap <buffer> aC <Plug>(textobj-python-class-a)
    autocmd Filetype python xmap <buffer> iC <Plug>(textobj-python-class-i)
    autocmd Filetype python omap <buffer> iC <Plug>(textobj-python-class-i)
augroup END
" 2}}}
" 1}}}

" >>> (( vim-Verdin )) {{{1
let g:Verdin#fuzzymatch = 0
" 1}}}

" >>> (( vim-css3-syntax )) {{{1
augroup VimCSS3Syntax
    autocmd!
    autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS nocopyindent iskeyword+=-
augroup END
" 1}}}

" >>> (( zeavim )) {{{1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap <leader>z <Plug>ZVKeyDocset
nmap gZ <Plug>ZVKeyDocset<CR>
nmap gz <Plug>ZVOperator
let g:zv_keep_focus = 0
let g:zv_file_types = {
            \   'javascript'          : 'javascript,nodejs',
            \   'python'              : 'python3',
            \   '\v^(G|g)ulpfile\.js' : 'gulp,javascript,nodejs',
            \ }
let g:zv_zeal_args = g:is_unix ? '--style=gtk+' : ''
" 1}}}

" >>> (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
let g:vcool_ins_rgb_map = '<A-r>'
" 1}}}

" " >>> (( gulp-vim )) {{{1
" let g:gv_rvm_hack = 1
" " 1}}}

" >>> (( lazyList )) {{{1
let g:lazylist_omap = 'ii'
nnoremap gli :LazyList ''<Left>
xnoremap gli :LazyList ''<Left>
let g:lazylist_maps = [
            \   'gl',
            \   {
            \       'l'  : '',
            \       '*'  : '* ',
            \       '-'   : '- ',
            \       '+'   : '+ ',
            \       't'   : '- [ ] ',
            \       '2'  : '%2%. ',
            \       '3'  : '%3%. ',
            \       '.1' : '1.%1%. ',
            \       '.2' : '2.%1%. ',
            \       '.3' : '3.%1%. ',
            \       '##': '# ',
            \       '#2': '## ',
            \       '#3': '### ',
            \   }
            \ ]
" 1}}}

" >>> (( vBox )) {{{1
nnoremap <S-F2> :VBEdit 
let g:vbox = {
            \   'dir': g:vim_dir . '/misc/templates',
            \   'empty_buffer_only': 0
            \ }
let g:vbox.variables = {
            \   '%LICENSE%'  : 'MIT',
            \   '%MAIL%'     : 'amine.kabb@gmail.com',
            \   '%NAME%'     : 'Kabbaj Amine',
            \   '%PROJECT%'  : 'f=fnamemodify(getcwd(), ":t")',
            \   '%REPO%'     : 'https://github.com/KabbAmine/',
            \   '%USERNAME%' : 'KabbAmine',
            \   '%YEAR%'     : 'f=strftime("%Y")',
            \ }
" For ALE
call extend(g:vbox.variables, {
            \   '%TYPE%'     : 'f=split(expand("%:p:h"), "/")[-1]',
            \ })

augroup VBoxAuto " {{{2
    autocmd!
    " For vim plugins
    " exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/README.md ' .
    "             \ ':VBTemplate README.md-vim'
    " exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/**/*.vim ' .
    "             \ ':VBTemplate vim-plugin'
    " exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/doc/*.txt ' .
    "             \ ':VBTemplate vim-doc'
    " Misc
    autocmd BufNewFile LICENSE VBTemplate license-MIT
    autocmd BufNewFile Makefile,CHANGELOG.md,.tern-project VBTemplate
    autocmd BufNewFile *.py,*.sh,*.php,*.html,*.js,*.c VBTemplate
augroup END " 2}}}
" 1}}}

" " >>> (( RAP )) {{{1
" let g:rap_cfg = {'runners': {}}
" let g:rap_cfg.runners = {
"             \   'lua'   : {'cmd' : 'lua5.3'},
"             \   'python': {'cmd' : 'python3'},
"             \   'sh'    : {'cmd' : 'bash'},
"             \ }
" nnoremap <silent> gpp :RAP<CR>
" xnoremap <silent> gpp :RAP<CR>
" nnoremap <silent> gp! :RAP!<CR>
" " 1}}}

" >>> (( vfinder )) {{{1
let g:vfinder_fuzzy = 0
let g:vfinder_win_pos = 'botright'
let g:vfinder_default_match_mode = 'compact_match'
let g:vfinder_maps = {}
let g:vfinder_maps._ = {
            \   'n': {'window_quit': 'q'},
            \   'i': {
            \       'toggle_maps_in_sl': '<Tab>',
            \       'cache_clean': '<C-x>'
            \   }
            \ }

nnoremap <silent> ,f :call vfinder#i('files')<CR>
nnoremap <silent> ,b :call vfinder#i('buffers')<CR>
nnoremap <silent> ,r :call vfinder#i('mru')<CR>
nnoremap <silent> ,t :call vfinder#i('tags')<CR>
nnoremap <silent> ,,f :call vfinder#i('tags_in_buffer', {
            \   'win_pos': 'aboveleft'
            \ })<CR>
nnoremap <silent> ,c :call vfinder#i('commands', {'fuzzy': 1})<CR>
nnoremap <silent> ,,c :call vfinder#i('command_history')<CR>
nnoremap <silent> ,w :call vfinder#i('windows')<CR>
nnoremap <silent> ,d :call vfinder#i('directories', {'win_pos': 'tab'})<CR>
nnoremap <silent> ,h :call vfinder#i('help')<CR>
nnoremap <silent> ,m :call vfinder#i('marks')<CR>
nnoremap <silent> ,l :call vfinder#i('lines', {'win_pos': 'aboveleft'})<CR>
if executable('cmus')
    nnoremap <silent> ,x :call vfinder#i('cmus', {'win_pos': 'tab'})<CR>
endif

" yank
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> ,y :call vfinder#i('yank')<CR>
inoremap <silent> <A-y> <Esc>:call vfinder#i('yank')<CR>

" spell
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> z= :call vfinder#i('spell', {
            \   'win_pos': 'topleft vertical'
            \ })<CR>
inoremap <silent> <A-z> <Esc>:call vfinder#i('spell', {
            \   'win_pos': 'topleft vertical'
            \ })<CR>

" qf
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

command! VFQf call <SID>vfinder_qf()

fun! s:vfinder_qf() abort " {{{2
    if getwininfo(win_getid(winnr()))[0].loclist
        call vfinder#i('qf', {'args': 'l', 'win_pos': 'topleft'})
    else
        call vfinder#i('qf', {'win_pos': 'topleft'})
    endif
endfun " 2}}}

" git_commits
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight! link vfinderGitCommitsDiffStatPlus Question
highlight! link vfinderGitCommitsDiffStatMinus Error
nnoremap <silent> ,gc :call vfinder#i('git_commits', {'win_pos': 'tab'})<CR>

" grep
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The following mappings overwrite the ones defined in config/minimal
" nnoremap <silent> ,,g :call vfinder#i('grep')<CR>
" xnoremap <silent> ,,g :call <SID>vfinder_grep_visual()<CR>
" nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>vfinder_grep_motion<CR>g@

" fun! s:vfinder_grep_visual() abort " {{{2
"     call vfinder#i('grep', {'args': ka#selection#get_visual_selection()})
" endfun " 2}}}

" fun! s:vfinder_grep_motion(...) abort " {{{2
"     call vfinder#i('grep', {'args': ka#selection#get_motion_result()})
" endfun " 2}}}
" 1}}}

" >>> (( pine.vim )) {{{1
nnoremap <silent> ,N :Pine<CR>
" 1}}}


" >>> (( coc )) {{{1
" Some servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
" set nowritebackup
" Use <c-space> to trigger completion.
inoremap <silent> <expr> <c-space> coc#refresh()
" the terminal interprets <c-space> as <c-@> (or <nul>)
if !g:is_gui
    imap <C-@> <C-Space>
endif
" Use <cr> to confirm completion (useful for snippets)
inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> gH :call CocAction('doHover')<CR>

augroup CocAutocmds
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Disable completion for some filetypes
  autocmd FileType vfinder let b:coc_suggest_disable = 1
augroup end

highlight! link CocErrorSign Error
highlight! link CocErrorFloat Title
highlight! link CocWarningSign Function
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
