" ========== Vim plugins configurations (Unix & Windows) =======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-04-09
" ==============================================================


" My plugins {{{1
let s:my_plugins_dir = g:has_win
            \ ? 'z:\\k-bag\\Projects\\pluginsVim\\'
            \ : $HOME . '/Projects/pluginsVim/'
let s:my_plugins = {
            \   'imagePreview'  : "{'on': '<Plug>(image-preview)'}",
            \ }
let s:lab_mode = 0
" 1}}}

" Signs for checkers  {{{1
let g:checker = {
            \   'error_sign'   : '⨉',
            \   'warning_sign' : '⬥',
            \   'success_sign' : ' ',
            \   'error_group'  : 'Error',
            \   'warning_group': 'Function',
            \ }
" 1}}}

" Helpers {{{1

function! s:MyPlugs() abort " {{{2
    let [l:pn, l:pl] = [keys(s:my_plugins), values(s:my_plugins)]
    for l:i in range(0, len(l:pn) - 1)
        let l:opt = (!empty(l:pl[l:i]) ? ', ' . l:pl[l:i] : '')
        exec printf("Plug '%s'%s", expand(s:my_plugins_dir) . l:pn[l:i], l:opt)
    endfor
endfunction
" 2}}}
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
" 2}}}

" Css {{{2
Plug 'othree/csscomplete.vim', {'for': 'css'}
" 2}}}

" PHP {{{2
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'     , {'for': 'php'}
Plug 'shawncplus/phpcomplete.vim'     , {'for': 'php'}
Plug 'Rican7/php-doc-modded'          , {'for': 'php'}
" 2}}}

" JavaScript {{{2
Plug 'heavenshell/vim-jsdoc', {'for': 'javascript'}
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
" 2}}}

" Python {{{2
Plug 'davidhalter/jedi-vim',
            \ {'do': 'git submodule update --init', 'for': 'python'}
Plug 'heavenshell/vim-pydocstring', {'for': 'python'}
Plug 'vim-python/python-syntax'
" 2}}}

" VimL {{{2
Plug 'machakann/vim-Verdin'
" 2}}}

" Web development {{{2
Plug 'alvan/vim-closetag'    , {'for': ['html', 'php', 'xml']}
Plug 'chrisbra/Colorizer'    , {'on': 'ColorToggle'}
Plug 'mattn/emmet-vim'
" 2}}}

" Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim', {'on': ['Agit', 'AgitFile']}
Plug 'tpope/vim-fugitive'
" 2}}}

" Snippets engine {{{2
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" 2}}}

" (( textobj-user )) {{{2
Plug 'kana/vim-textobj-user'
            \| Plug 'glts/vim-textobj-comment'
            \| Plug 'somini/vim-textobj-fold', {'branch': 'foldmarker'},
            \| Plug 'kana/vim-textobj-function'
            \| Plug 'haya14busa/vim-textobj-function-syntax'
            \| Plug 'bps/vim-textobj-python',
            \       {'for': 'python'}
            \| Plug 'kentaro/vim-textobj-function-php',
            \       {'for': 'php'}
            \| Plug 'thinca/vim-textobj-function-javascript',
            \       {'for': 'javascript'}
" 2}}}

" Edition & moving {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'haya14busa/vim-signjk-motion',
            \ {'on': ['<Plug>(signjk-j)', '<Plug>(signjk-k)', '<Plug>(textobj-signjk-lines)']}
Plug 'machakann/vim-sandwich'
Plug 'Raimondi/delimitMate'
Plug 'thinca/vim-visualstar'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" 2}}}

" Misc {{{2
Plug 'junegunn/vader.vim', {'on': 'Vader', 'for': 'vader'}
Plug 'junegunn/vim-emoji', {'for': ['markdown', 'gitcommit']}
Plug 'kana/vim-tabpagecd'
Plug 'mbbill/undotree'   , {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
if g:has_unix | Plug 'tpope/vim-rvm', {'on': 'Rvm'} | endif
" 2}}}

" Interface {{{2
Plug 'itchyny/vim-parenmatch'
Plug 'machakann/vim-highlightedyank',
" 2}}}

" My Plugins {{{2
if !s:lab_mode
    " Plug 'KabbAmine/unite-cmus'
    " Plug 'KabbAmine/gulp-vim'
    Plug $HOME . '/Temp/lab/RAP/'
    Plug $HOME . '/Temp/lab/vfinder/'
    Plug 'KabbAmine/lazyList.vim'
    Plug 'KabbAmine/vZoom.vim'
    Plug 'KabbAmine/vBox.vim'
    Plug 'KabbAmine/vCoolor.vim'
    Plug 'KabbAmine/vullscreen.vim'
    Plug 'KabbAmine/yowish.vim'
    Plug 'KabbAmine/zeavim.vim'
else
    call s:MyPlugs()
endif
" 2}}}
" 1}}}

" End {{{1
call plug#end()
" 1}}}

" =========== MISC  ============================================

" Colors {{{1
let g:yowish = {
            \   'term_italic' : 1,
            \   'colors': {
            \       'background'       : ['#2f343f', 'none'],
            \       'backgroundDark'   : ['#191d27', '16'],
            \       'backgroundLight'  : ['#464b5b', '59'],
            \       'blue'             : ['#5295e2', '68'],
            \       'comment'          : ['#5b6176', '245'],
            \       'lightBlue'        : ['#e39f52', '179'],
            \       'lightYellow'      : ['#80aee3', '110'],
            \       'yellow'           : ['#5295e2', '68'],
            \   }
            \ }
colorscheme yowish
" Manually execute the ColorScheme event (Useful for some plugins)
silent doautocmd ColorScheme
" }}}

" =========== PLUGINS CONFIGS ==================================

" >>> (( closetag )) {{{1
let g:closetag_filenames = '*.html,*.xml,*.php'
" 1}}}

" >>> (( NERDTree )) {{{1
nnoremap <silent> ,N :NERDTreeToggle<CR>
" Close NERTree otherwise delete buffer
" (The delete buffer is already mapped in config/minimal.vim)
nnoremap <silent> <S-q>
            \ :execute (&ft !=# 'nerdtree' ? 'bw' : 'NERDTreeClose')<CR>
let g:NERDTreeBookmarksFile = g:has_win ?
            \ 'C:\Users\k-bag\vimfiles\misc\NERDTreeBookmarks' :
            \ '/home/k-bag/.vim/misc/NERDTreeBookmarks'
let g:NERDTreeIgnore = ['\~$', '\.class$']
" Single-clic for folder nodes and double for files.
let g:NERDTreeMouseMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeCascadeOpenSingleChildDir = 0
" Mappings
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
" 1}}}

" >>> (( python-syntax )) {{{1
let python_highlight_all = 1
" 1}}}

" >>> (( ale )) {{{1
" Disabled by default
let g:ale_enabled = 0
nnoremap <silent> ,E :lopen<CR>:wincmd p<CR>
nmap <silent> <F8> :ALEToggle<CR>
nnoremap <silent> ]e :ALENext<CR>
nnoremap <silent> [e :ALEPrevious<CR>
let g:ale_lint_on_enter = 0
" Do not check in insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = g:checker.error_sign
let g:ale_sign_warning = g:checker.warning_sign
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
exe 'hi! link ALEErrorSign ' . g:checker.error_group
exe 'hi! link ALEWarningSign ' . g:checker.warning_group
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
" let g:emmet_html5 = 1
" let g:user_emmet_install_global = 0
" let g:user_emmet_complete_tag = 1

" augroup EmmetMaps " {{{2
"     autocmd!
"     autocmd FileType html,scss,css,pug,javascript EmmetInstall
"     autocmd FileType scss,css setlocal completefunc=emmet#completeTag
"     autocmd FileType html,scss,css,pug,javascript
"                 \ imap <silent> jhh <plug>(emmet-expand-abbr)
" augroup END " 2}}}

" Add emmet completion as a userfunc to mashtab
" let g:mashtab_patterns.user.css = '^\s*\S\+$'
" let g:mashtab_patterns.user.scss = '^\s*\S\+$'
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
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = '(:),[:],{:}'
" 1}}}

" >>> (( ultisnips )) {{{1
nnoremap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsEditSplit = 'vertical'

" Personal snippets folder.
let g:UltiSnipsSnippetsDir = g:vim_dir . '/misc/ultisnips'
let g:UltiSnipsSnippetDirectories =
            \ ['UltiSnips', g:vim_dir . '/misc/ultisnips']
" 1}}}

" >>> (( gitgutter )) {{{1
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '❙'
let g:gitgutter_sign_modified = '❙'
let g:gitgutter_sign_removed = '❙'
let g:gitgutter_sign_modified_removed = '❙'
nnoremap <silent> <F6> :GitGutterToggle<CR>
command! GP :GitGutterPreviewHunk
if g:has_win | let g:gitgutter_enabled = 0 | endif
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
" mnemonic: h for hunk.
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual
" 1}}}

" >>> (( vim-plug )) {{{1
let g:plug_threads = 10
hi! link PlugDeleted Conceal
" 1}}}

" >>> (( jedi-vim )) {{{1
let g:jedi#completions_command = ''
let g:jedi#completions_enabled = 1
let g:jedi#smart_auto_mappings = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
" Keybindings
let g:jedi#goto_command = 'gd'
let g:jedi#documentation_command = 'gH'
let g:jedi#usages_command = ''
let g:jedi#goto_assignments_command= ''
let g:jedi#show_call_signatures = 2
" Don't use it, buggy as hell
let g:jedi#rename_command = ''
" 1}}}

" >>> (( colorizer )) {{{1
let g:colorizer_colornames = 0
" 1}}}

" >>> (( vim-pydocstring )) {{{1
let g:pydocstring_enable_mapping = 0

augroup PydocStringMaps " {{{2
    autocmd!
    autocmd Filetype python
                \ nnoremap <buffer> <silent> <C-d> <Plug>(pydocstring)
augroup END " 2}}}
" 1}}}

" >>> (( php-doc-modded )) {{{1
let g:pdv_cfg_ClassTags = []
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_autoEndClass = 0

augroup PhpDocMaps " {{{2
    autocmd!
    autocmd Filetype php nnoremap <buffer> <silent> <C-d> :call PhpDoc()<CR>
augroup END " 2}}}
" 1}}}

" >>> (( vim-lion )) {{{1
let g:lion_create_maps = 1
let g:lion_map_right = '<CR>'
let g:lion_map_left = ''
" 1}}}

" >>> (( fugitive )) {{{1
" Split, vsplit & tab
augroup FugitiveMaps " {{{2
    autocmd!
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-s> :norm o<CR>
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-v> :norm S<CR>
    autocmd FileType gitcommit nnoremap <silent> <buffer> <C-t> :norm O<CR>
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
augroup END " 2}}}
" 1}}}

" >>> (( agit )) {{{1
let g:agit_no_default_mappings = 1

augroup Agit " {{{2
    autocmd!
    autocmd Filetype agit,agit_stat,agit_diff
                \ nmap <buffer> ch <Plug>(agit-git-checkout)
    autocmd Filetype agit,agit_stat,agit_diff
                \ nmap <buffer> P <Plug>(agit-print-commitmsg)
    autocmd Filetype agit,agit_stat,agit_diff
                \ nmap <buffer> q <Plug>(agit-exit)
    autocmd Filetype agit,agit_stat,agit_diff
                \ nmap <buffer> R <Plug>(agit-reload)
    autocmd Filetype agit,agit_stat
                \ nmap <buffer> D <Plug>(agit-diff)
    autocmd Filetype agit,agit_stat
                \ nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
    autocmd Filetype agit,agit_stat
                \ nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
    autocmd Filetype agit,agit_stat
                \ nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
    autocmd Filetype agit,agit_stat
                \ nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
augroup END " 2}}}
" 1}}}

" >>> (( vim-rvm )) {{{1
if g:has_unix && executable('rvm')
    augroup Rvm " {{{2
        autocmd!
        autocmd GUIEnter * Rvm
    augroup END " 2}}}
endif
" 1}}}

" >>> (( vim-highlightedyank )) {{{1
let g:highlightedyank_highlight_duration = 200
" 1}}}

" >>> (( vim-sandwich )) {{{1
call operator#sandwich#set('all', 'all', 'cursor', 'keep')
call operator#sandwich#set('all', 'all', 'hi_duration', 150)
call operator#sandwich#set('all', 'all', 'autoindent', 0)
vmap v ab
" Allow using . with the keep cursor option enabled
nmap . <Plug>(operator-sandwich-dot)
hi link OperatorSandwichStuff StatusLine
" 1}}}

" >>> (( vim-jsdoc )) {{{1
augroup JsDoc " {{{2
    autocmd!
    autocmd Filetype javascript nnoremap <buffer> <silent> <C-d> :JsDoc<CR>
augroup END " 2}}}
" 1}}}

" >>> (( tern_for_vim )) {{{1
let g:tern_show_signature_in_pum = 1

augroup Tern " {{{2
    autocmd!
    autocmd Filetype javascript nmap <silent> <buffer> gd :TernDef<CR>
    autocmd Filetype javascript nmap <silent> <buffer> gH :TernDoc<CR>:wincmd k<CR>
augroup END " 2}}}
" 1}}}

" >>> (( vim-parenmatch )) {{{1
let g:parenmatch_highlight = 0
hi! link ParenMatch WarningMsg
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
call textobj#user#map('python', {
            \   'class': {
            \       'select-a': '<buffer>aC',
            \       'select-i': '<buffer>iC',
            \   }
            \ })
" 2}}}
" 1}}}

" >>> (( vim-visualstar )) {{{1
map * <Plug>(visualstar-*)``
map # <Plug>(visualstar-#)
" 1}}}

" >>> (( vim-signjk-motion )) {{{1
nmap gj <Plug>(signjk-j)
nmap gk <Plug>(signjk-k)
" 1}}}

" >>> (( vim-Verdin )) {{{1
let g:Verdin#fuzzymatch = 0
" 1}}}

" >>> (( zeavim )) {{{1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap <leader>z <Plug>ZVKeyDocset
nmap gZ <Plug>ZVKeyDocset<CR>
nmap gz <Plug>ZVOperator
let g:zv_keep_focus = 0
let g:zv_file_types = {
            \   'help'                : 'vim',
            \   'javascript'          : 'javascript,nodejs',
            \   'python'              : 'python3',
            \   '\v^(G|g)ulpfile\.js' : 'gulp,javascript,nodejs',
            \ }
let g:zv_zeal_args = g:has_unix ? '--style=gtk+' : ''
" 1}}}

" >>> (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
let g:vcool_ins_rgb_map = '<A-r>'
" 1}}}

" >>> (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
" 1}}}

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
    exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/README.md ' .
                \ ':VBTemplate README.md-vim'
    exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/**/*.vim ' .
                \ ':VBTemplate vim-plugin'
    exe 'autocmd BufNewFile ' . s:my_plugins_dir . '*/doc/*.txt ' .
                \ ':VBTemplate vim-doc'
    " Misc
    autocmd BufNewFile LICENSE VBTemplate license-MIT
    autocmd BufNewFile Makefile,CHANGELOG.md,.tern-project VBTemplate
    autocmd BufNewFile *.py,*.sh,*.php,*.html,*.js,*.c VBTemplate
augroup END " 2}}}
" 1}}}

" >>> (( vzoom )) {{{1
nmap gsz <Plug>(vzoom)
nnoremap gsZ :VZoomAutoToggle<CR>
let g:vzoom = {'equalise_windows': 1}
" 1}}}

" >>> (( imagePreview )) {{{1
" nmap gi <Plug>(image-preview)
" let g:image_preview = {
"             \   '_': {
"             \       'prg'  : 'feh',
"             \       'args' :
"             \           '--scale-down --no-menus --quiet --magick-timeout 1',
"             \   },
"             \   'gif': {
"             \       'prg'  : 'exo-open',
"             \       'args' : '',
"             \   },
"             \ }
" 1}}}

" >>> (( RAP )) {{{1
let g:rap_cfg = {'runners': {}}
let g:rap_cfg.runners = {
            \   'lua'   : {'cmd' : 'lua5.3'},
            \   'python': {'cmd' : 'python3'},
            \   'sh'    : {'cmd' : 'bash'},
            \ }
nnoremap <silent> gpp :RAP<CR>
xnoremap <silent> gpp :RAP<CR>
nnoremap <silent> gp! :RAP!<CR>
" 1}}}

" >>> (( vfinder )) {{{1
let g:vfinder_fuzzy = 0
let g:vfinder_maps = {}
let g:vfinder_maps._ = {'n': {'window_quit': 'q'}}
call vfinder#maps#define()
nnoremap <silent> ,f :call vfinder#i('files')<CR>
nnoremap <silent> ,b :call vfinder#i('buffers')<CR>
nnoremap <silent> ,d :call vfinder#i('directories')<CR>
nnoremap <silent> ,r :call vfinder#i('mru')<CR>
nnoremap <silent> ,c :call vfinder#i('commands', {'fuzzy': 1})<CR>
nnoremap <silent> ,,c :call vfinder#i('command_history')<CR>
nnoremap <silent> ,t :call vfinder#i('tags')<CR>
nnoremap <silent> ,,f :call vfinder#i('outline')<CR>
nnoremap <silent> z= :call vfinder#i('spell')<CR>
inoremap <silent> <A-z> <Esc>:call vfinder#i('spell')<CR>
nnoremap <silent> ,y :call vfinder#i('yank')<CR>
inoremap <silent> <A-y> <Esc>:call vfinder#i('yank')<CR>
nnoremap <silent> ,m :call vfinder#i('marks')<CR>
" nnoremap <silent> ,C :call vfinder#i('colors')<CR>
" nnoremap <silent> ,,r :call vfinder#i('oldfiles')<CR>
" nnoremap <silent> ,Y :call vfinder#i('registers')<CR>

nnoremap <silent> ,B :call vfinder#i(<SID>BookmarksSource())<CR>
fun! s:BookmarksSource() abort " {{{2
    return {
            \   'name'      : 'bookmarks',
            \   'to_execute': ['~/.vim', '~/Temp/lab'],
            \   'maps'      : {
            \       'i': {'<CR>': {'action': 'cd %s', 'options': {'silent': 1} }},
            \       'n': {'<CR>': {'action': 'cd %s', 'options': {'silent': 1} }}
            \   }
            \ }
endfun " 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
