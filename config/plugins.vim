" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-09-21
" ================================================================

" Personal vim plugins directory {{{1
let s:myPlugins = g:hasWin ?
			\ 'z:\\k-bag\\Projects\\pluginsVim\\' :
			\ '$HOME/Projects/pluginsVim/'
" Useful variables & functions {{{1
let s:checker = {}
let s:checker.error_sign = '⨉'
let s:checker.warning_sign = '⬥'
let s:checker.error_group = 'Error'
let s:checker.warning_group = 'Function'
fun! s:PlugInOs(link, param, os) abort " {{{2
	if has(a:os)
		let l:opt = (!empty(a:param) ? ', ' . a:param : '')	
		exe printf("Plug '%s'%s", a:link, l:opt)
	endif
endfun
" My plugins {{{2
let s:myPlugs = {
			\	'gulp-vim'      : '',
			\	'imagePreview'  : "{'on': '<Plug>(image-preview)'}",
			\	'lazyList'      : '',
			\	'unite-cmus'    : '',
			\	'vBox'          : '',
			\	'vCoolor'       : '',
			\	'vPreview'      : '',
			\	'vt'            : '',
			\	'yowish'        : '',
			\	'zeavim'        : "{'on': [
			\		'Zeavim', 'Docset',
			\		'<Plug>Zeavim',
			\		'<Plug>ZVVisSelection',
			\		'<Plug>ZVKeyDocset',
			\		'<Plug>ZVMotion'
			\	]}"
			\ }
function! s:MyPlugs() abort
	let l:pn = keys(s:myPlugs)
	let l:pl = values(s:myPlugs)
	for l:i in range(0, len(l:pn) - 1)
		let l:opt = (!empty(l:pl[l:i]) ? ', ' . l:pl[l:i] : '')
		exec printf("Plug '%s'%s", expand(s:myPlugins) . l:pn[l:i], l:opt)
	endfor
endfunction
" 2}}}
" 1}}}

" ========== VIM-PLUG ==============================================
" Initialization {{{1
call plug#begin(g:vimDir . '/plugs')
" Plugins {{{1
" Syntaxes {{{2
Plug 'digitaltoad/vim-pug'
Plug 'gabrielelana/vim-markdown'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'stephpy/vim-yaml'
Plug 'tbastos/vim-lua'
Plug 'tpope/vim-haml'
" For Css {{{2
Plug 'JulesWang/css.vim'
Plug 'othree/csscomplete.vim', {'for': 'css'}
" For PHP {{{2
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'     , {'for': 'php'}
Plug 'shawncplus/phpcomplete.vim'     , {'for': 'php'}
Plug 'sumpygump/php-documentor-vim'   , {'for': 'php'}
" For JavaScript {{{2
Plug 'gavocanov/vim-js-indent'
Plug 'heavenshell/vim-jsdoc'
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
" For Python {{{2
Plug 'davidhalter/jedi-vim', {'do': 'git submodule update --init', 'for': 'python'}
Plug 'hdima/python-syntax'
" For web development {{{2
Plug 'docunext/closetag.vim' , {'for': ['html', 'php', 'xml']}
Plug 'lilydjwg/colorizer'    , {'on': 'ColorToggle'}
Plug 'mattn/emmet-vim'
" For Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim', {'on': ['Agit', 'AgitFile']}
Plug 'tpope/vim-fugitive'
" (( ultisnips )) {{{2
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" (( Unite )) {{{2
Plug 'Shougo/unite.vim'
			\| call s:PlugInOs('Shougo/vimproc.vim' , "{ 'do': 'make' }" , 'unix')
			\| call s:PlugInOs('Shougo/vimproc.vim' , ''                 , 'win32')
			\| Plug 'kopischke/unite-spell-suggest'
			\| Plug 'Shougo/neomru.vim'
			\| Plug 'Shougo/neoyank.vim'
			\| Plug 'Shougo/unite-outline'
			\| Plug 'tacroe/unite-mark'
			\| Plug 'tsukkee/unite-tag'
" Syntax & style checkers {{{2
Plug 'scrooloose/syntastic'
Plug 'maralla/validator.vim'
" (( textobj-user )) {{{2
Plug 'kana/vim-textobj-user'
			\| Plug 'glts/vim-textobj-comment'
			\| Plug 'kana/vim-textobj-fold'
			\| Plug 'kana/vim-textobj-function'
			\| Plug 'bps/vim-textobj-python'                 , {'for': 'python'}
			\| Plug 'kentaro/vim-textobj-function-php'       , {'for': 'php'}
			\| Plug 'thinca/vim-textobj-function-javascript' , {'for': 'javascript'}
" Edition & moving {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'haya14busa/vim-signjk-motion',
			\ {'on': ['<Plug>(signjk-j)', '<Plug>(signjk-k)', '<Plug>(textobj-signjk-lines)']}
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-sandwich'
Plug 'nelstrom/vim-visual-star-search'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Misc {{{2
call s:PlugInOs('tpope/vim-rvm'  , "{'on': 'Rvm'}" , 'unix')
Plug 'Chiel92/vim-autoformat'    , {'on': 'Autoformat'}
Plug 'iwataka/airnote.vim'       , {'on': ['Note', 'NoteDelete']}
Plug 'junegunn/vader.vim'        , {'on': 'Vader', 'for': 'vader'}
Plug 'junegunn/vim-emoji'        , {'for': ['markdown', 'gitcommit']}
Plug 'kana/vim-tabpagecd'
Plug 'matchit.zip'
Plug 'mbbill/undotree'           , {'on': 'UndotreeToggle'}
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree'
			\| Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/neocomplete.vim'
			\| Plug 'Shougo/neco-vim' , {'for': 'vim'}
" Interface {{{2
Plug 'itchyny/vim-parenmatch'
Plug 'machakann/vim-highlightedyank', {'on': '<Plug>(highlightedyank)'}
Plug 'troydm/zoomwintab.vim'        , {'on': ['ZoomWinTabToggle', 'ZoomWinTabIn', 'ZoomWinTab']}
Plug 'Yggdroot/indentLine'
call s:PlugInOs('ryanoasis/vim-devicons' , '', 'unix')
" My Plugins {{{2
call s:MyPlugs()
" }}}
" End {{{1
call plug#end()
" }}}

" ========== MISC  ===========================================
" Colors {{{1
if exists('$TERM') && $TERM =~# '^xterm' && !exists('$TMUX') && !g:isNvim
	set term=xterm-256color
endif
" Custom colors for (( yowish ))
let g:yowish = {
			\	'term_italic' : 0,
			\	'colors': {
			\		'background'       : ['#2f343f', 'none'],
			\		'backgroundDark'   : ['#191d27', '16'],
			\		'backgroundLight'  : ['#464b5b', '59'],
			\		'blue'             : ['#5295e2', '68'],
			\		'comment'          : ['#5b6176', '242'],
			\		'lightBlue'        : ['#e39f52', '179'],
			\		'lightYellow'      : ['#80aee3', '110'],
			\		'yellow'           : ['#5295e2', '68'],
			\	}
			\ }
colo yowish
hi! link TabLineSel Search
hi CursorLine ctermbg=none ctermfg=none cterm=bold
" Manually execute the ColorScheme event (Useful for some plugins)
do ColorScheme
" }}}

" =========== PLUGINS MAPPINGS & OPTIONS =======================
" >>> (( NERDTree )) {{{1
nnoremap <silent> ,N :NERDTreeToggle<CR>
" Close NERTree otherwise delete buffer
" (The delete buffer is already mapped in config/minimal.vim)
nnoremap <silent> <S-q> :execute (&ft !=# 'nerdtree' ? 'bw' : 'NERDTreeClose')<CR>
let NERDTreeBookmarksFile = g:hasWin ?
			\ 'C:\Users\k-bag\vimfiles\misc\NERDTreeBookmarks' :
			\ '/home/k-bag/.vim/misc/NERDTreeBookmarks'
let NERDTreeIgnore = ['\~$', '\.class$']
" Single-clic for folder nodes and double for files.
let NERDTreeMouseMode = 2
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 2
let NERDTreeCascadeSingleChildDir = 0
let NERDTreeCascadeOpenSingleChildDir = 0
" Mappings
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
augroup NerdTree
	autocmd!
	autocmd FileType nerdtree setlocal nolist
augroup END
" >>> (( python-syntax )) {{{1
let python_highlight_all = 1
" >>> (( validator )) {{{1
let g:validator_error_symbol = s:checker.error_sign
let g:validator_warning_symbol = s:checker.warning_sign
let g:validator_error_msg_format = '%d/%d'
exe 'hi! link ValidatorErrorSign ' . s:checker.error_group
exe 'hi! link ValidatorWarningSign ' . s:checker.warning_group
" >>> (( syntastic )) {{{1
nnoremap <silent> <F8> :call <SID>SyntasticToggle()<CR>
function! s:SyntasticToggle() abort
	SyntasticToggle
	execute g:syntastic_mode_map.mode ==# 'active' ? 'SyntasticCheck' : 'SyntasticReset'
endfunction
nnoremap <silent> ,E :Errors<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_stl_format = '%E{' . s:checker.error_sign . ' %e}%B{ }%W{' . s:checker.warning_sign . ' %w}'
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_error_symbol = s:checker.error_sign
let g:syntastic_warning_symbol = s:checker.warning_sign
let g:syntastic_style_error_symbol = g:syntastic_error_symbol
let g:syntastic_style_warning_symbol = g:syntastic_warning_symbol
exe 'hi! link SyntasticErrorSign ' . s:checker.error_group
exe 'hi! link SyntasticWarningSign ' . s:checker.warning_group
" The cursor will jump to the first error detected (1|2|3)
let g:syntastic_auto_jump = 2
" Checkers (The default ones are here just for reference)
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_lua_checkers = ['luac']
let g:syntastic_coffee_checkers = ['coffee']
let g:syntastic_python_checkers = ['flake8', 'python']
let g:syntastic_scss_checkers = ['sass_lint', 'sass']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_yaml_checkers = ['yamllint']
if g:hasWin
	let g:syntastic_c_gcc_exec = 'C:\tools\DevKit2\mingw\bin\gcc.exe'
	let g:syntastic_php_checkers = 'php'
	let g:syntastic_php_php_exec = 'C:\tools\xampp\php\php.exe'
endif
" >>> (( emmet )) {{{1
" Enable emmet for specific files.
let g:user_emmet_install_global = 0
augroup emmet
	autocmd!
	autocmd FileType html,scss,css,pug EmmetInstall
	autocmd FileType html,scss,css,pug imap <buffer> jha <plug>(emmet-anchorize-url)
	autocmd FileType html,scss,css,pug imap <buffer> jhc <plug>(emmet-code-pretty)
	autocmd FileType html,scss,css,pug imap <buffer> jhh <plug>(emmet-expand-abbr)
	autocmd FileType html,scss,css,pug imap <buffer> jhn <plug>(emmet-move-next)
	autocmd FileType html,scss,css,pug imap <buffer> jhN <plug>(emmet-move-prev)
	autocmd FileType html,scss,css,pug imap <buffer> jhu <plug>(emmet-update-tag)
augroup END
" In INSERT & VISUAL modes only.
let g:user_emmet_mode='iv'
let g:emmet_html5 = 1
" >>> (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" >>> (( delimitmate )) {{{1
imap <S-space> <Plug>delimitMateS-Tab
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = '(:),[:],{:}'
" >>> (( javascript-libraries-syntax )) {{{1
" let g:used_javascript_libs = 'jquery'
" >>> (( ultisnips )) {{{1
nnoremap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
let g:UltiSnipsEditSplit = 'vertical'
" Personal snippets folder.
let g:UltiSnipsSnippetsDir = g:vimDir . '/misc/ultisnips'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', g:vimDir . '/misc/ultisnips']
" >>> (( gitgutter )) {{{1
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '❙'
let g:gitgutter_sign_modified = '❙'
let g:gitgutter_sign_removed = '❙'
let g:gitgutter_sign_modified_removed = '❙'
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
command! GP :GitGutterPreviewHunk
if g:hasWin | let g:gitgutter_enabled = 0 | endif
" >>> (( Unite )) & plugins {{{1
" SETTINGS {{{2
" General {{{3
let g:unite_data_directory = g:vimDir . '/misc/unite'
let g:unite_force_overwrite_statusline = 0
let g:unite_enable_auto_select = 0
let g:unite_quick_match_table = {
			\	'0': 29,
			\	'1': 20,
			\	'2': 21,
			\	'3': 22,
			\	'4': 23,
			\	'5': 24,
			\	'6': 25,
			\	'7': 26,
			\	'8': 27,
			\	'9': 28,
			\	'a': 8,
			\	'd': 4,
			\	'e': 2,
			\	'f': 0,
			\	'g': 12,
			\	'h': 17,
			\	'i': 3,
			\	'j': 1,
			\	'k': 5,
			\	'l': 7,
			\	'm': 9,
			\	'o': 18,
			\	'p': 19,
			\	'q': 10,
			\	'r': 13,
			\	's': 6,
			\	't': 14,
			\	'u': 16,
			\	'w': 11,
			\	'y': 15,
		\ }
" Default profile
call unite#custom#profile('default', 'context', {
			\	'start_insert'      : 1,
			\	'no_empty'          : 1,
			\	'toggle'            : 1,
			\	'vertical_preview'  : 1,
			\	'winheight'         : 20,
			\	'prompt'            : '▸ ',
			\	'prompt_focus'      : 1,
			\	'candidate_icon'    : '  ▫ ',
			\	'marked_icon'       : '  ▪ ',
			\	'no_hide_icon'      : 1,
			\ })
" Use ag {{{3
if executable('ag')
	let g:unite_source_rec_async_command = ['ag', '--nocolor', '--nogroup', '--hidden', '-g', '']
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--column --nocolor --nogroup'
	let g:unite_source_grep_recursive_opt = ''
endif
" Converters for source {{{3
let s:filters = {'name' : 'buffer_simple_format'}
function! s:filters.filter(candidates, context)
	for l:candidate in a:candidates
		let l:num = l:candidate.action__buffer_nr
		let l:buffer = !empty(l:candidate.word) ? bufname(l:num) : '[NO NAME]'
		let l:modified = getbufvar(l:buffer, '&modified') ==# 1 ? '➕' : ' '
		let l:path = !empty(l:candidate.word) ? fnamemodify(l:buffer, ':.') : ''
		let l:candidate.abbr = printf('%-*s %s %2s %s',
					\	15, fnamemodify(l:buffer, ':p:t'),
					\	l:modified, l:num, l:path
					\ )
	endfor
	return a:candidates
endfunction
call unite#define_filter(s:filters)
unlet s:filters
call unite#custom#source('buffer', 'converters', 'buffer_simple_format')
" PLUGINS {{{2
let g:neomru#file_mru_path = g:unite_data_directory . '/neomru/file'
let g:neomru#directory_mru_path = g:unite_data_directory . '/neomru/directory'
let g:neoyank#file = g:unite_data_directory . '/neoyank/file'
let g:unite_source_outline_ctags_program = g:hasUnix ?
			\ '/usr/bin/ctags-exuberant' : 'C:\Program Files\ctags58\ctags.exe'
let g:unite_source_outline_filetype_options = {
			\ '*': {
			\   'auto_update': 1,
			\   'auto_update_event': 'write'
			\ }
		\ }
" MAPPINGS {{{2
inoremap <silent> <A-y> <Esc>:Unite -buffer-name=Yanks -default-action=append history/yank<CR>
nnoremap <silent> ,B :Unite -buffer-name=Bookmarks -default-action=cd bookmark:_<CR>
nnoremap <silent> ,b :Unite -buffer-name=Buffers buffer<CR>
nnoremap <silent> ,t :Unite -buffer-name=Tags tag<CR>
nnoremap <silent> ,d :Unite -buffer-name=File -force-redraw file<CR>
function! s:NoFileOnHome() abort " {{{3
	if getcwd() == expand('~')
		echo 'Set your cwd!'
	else
		Unite -buffer-name=Files -no-force-redraw file_rec/async
	endif
endfunction " 3}}}
nnoremap <silent> ,f :call <SID>NoFileOnHome()<CR>
nnoremap <silent> ,,f :Unite -buffer-name=SearchFor -winheight=10 outline<CR>
" nnoremap <silent> ,g :Unite -buffer-name=Grep -no-start-insert -direction=botright -no-focus -no-quit grep<CR>
nnoremap <silent> ,G :Unite -buffer-name=Gulp -vertical -winwidth=30 -force-redraw -resize gulp<CR>
nnoremap <silent> ,l :Unite -buffer-name=Search -custom-line-enable-highlight line:all<CR>
nnoremap <silent> ,m :Unite -buffer-name=Marks -force-redraw mark<CR>
nnoremap <silent> ,r :Unite -buffer-name=Recent -empty -force-redraw neomru/file<CR>
nnoremap <silent> ,T :Unite -buffer-name=Outline outline -no-focus -force-redraw -keep-focus -no-start-insert -no-quit -winwidth=50 -vertical -direction=belowright<CR>
nnoremap <silent> ,! :Unite -buffer-name=Commands -force-redraw -empty command<CR>
nnoremap <silent> ,y :Unite -buffer-name=Yanks -force-redraw -default-action=append history/yank<CR>
nnoremap <silent> z= :Unite -buffer-name=SpellSuggest -vertical -force-redraw -winwidth=40 -empty spell_suggest<CR>
if g:hasUnix
	nnoremap <silent> ,C :Unite -buffer-name=Cmus cmus/album<CR>
endif
" Inside unite buffers
augroup UniteMaps
	autocmd!
	autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings() " {{{3
	" NORMAL
	nunmap <buffer> <C-h>
	nunmap <buffer> <C-k>
	nunmap <buffer> <C-l>
	nunmap <buffer> <space>
	nmap <silent> <buffer> <F5> <Plug>(unite_redraw)
	nmap <silent> <buffer> <Esc> <Plug>(unite_exit)
	nmap <silent> <buffer> ? <Plug>(unite_quick_help)
	nnoremap <silent><buffer><expr> cd unite#do_action('cd')
	nnoremap <silent><buffer><expr> s unite#do_action('split')
	nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
	nmap <silent> <buffer> <space> <Plug>(unite_toggle_mark_current_candidate)k
	" INSERT
	imap <silent> <buffer> <C-space> <Plug>(unite_toggle_mark_current_candidate)
	imap <silent> <buffer> <C-Tab> <Plug>(unite_choose_action)
	imap <silent> <buffer> <Esc> <Plug>(unite_exit)
	imap <silent> <buffer> <F5> <Plug>(unite_redraw)
	imap <silent> <buffer> jk <Plug>(unite_insert_leave)
	imap <silent> <buffer> <Tab> <Plug>(unite_complete)
	inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
	inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
	inoremap <silent><buffer><expr> <C-q> unite#do_action('queue')
endfunction " 3}}}
" 1}}}
" >>> (( vim-plug )) {{{1
let g:plug_threads = 10
" >>> (( clever-f )) {{{1
let g:clever_f_across_no_line = 1
" Fix a direction of search (f & F)
let g:clever_f_fix_key_direction = 1
let g:clever_f_smart_case = 1
let g:clever_f_mark_char_color = 'IncSearch'
" >>> (( neocomplete )) {{{1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory = g:vimDir . '/misc/neocomplete'
inoremap <silent> <expr> <C-space> pumvisible() ? "\<Down>" :
			\ neocomplete#start_manual_complete()
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.php =
			\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
let g:neocomplete#force_omni_input_patterns.python =
			\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.markdown = ':'
let g:neocomplete#force_omni_input_patterns.gitcommit = ':'
" >>> (( jedi-vim )) {{{1
let g:jedi#completions_enabled = 1
let g:jedi#smart_auto_mappings = 0
let g:jedi#auto_vim_configuration = 0
" Keybindings
let g:jedi#goto_command = 'gd'
let g:jedi#documentation_command = ''
let g:jedi#usages_command = 'gD'
let g:jedi#goto_assignments_command= ''
let g:jedi#show_call_signatures = 2
" Don't use, buggy as hell
let g:jedi#rename_command = 'gr'
" >>> (( autoformat )) {{{1
let g:formatters_html = ['htmlbeautify']
let g:formatdef_htmlbeautify = '"html-beautify --indent-size 2 --indent-inner-html true  --preserve-newlines -f - "'
" let g:autoformat_verbosemode = 1
" Make =ie autoformat for some ft
augroup Autoformat
	autocmd!
	autocmd Filetype python,html,json,css,javascript,scss nnoremap <buffer> =ie :Autoformat<CR>
augroup END
" >>> (( colorizer )) {{{1
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" >>> (( php-documentor )) {{{1
augroup PhpDoc
	autocmd!
	autocmd Filetype php nnoremap <buffer> <silent> <C-d> :call PhpDoc()<CR>
	autocmd Filetype php inoremap <buffer> <silent> <C-d> <C-o>:call PhpDoc()<CR>
	autocmd Filetype php vnoremap <buffer> <silent> <C-d> :call PhpDocRange()<CR>
augroup END
let g:pdv_cfg_ClassTags = []
" >>> (( vim-devicons )) {{{1
if g:hasUnix
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:webdevicons_enable_airline_statusline = 0
	let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
	let g:webdevicons_enable_unite = 0
	" After a re-source, fix syntax matching issues (concealing brackets):
	if exists('g:loaded_webdevicons')
		call webdevicons#refresh()
	endif
endif
" >>> (( vim-lion )) {{{1
let g:lion_create_maps = 1
let g:lion_map_right = '<CR>'
let g:lion_map_left = ''
" >>> (( fugitive )) {{{1
" Split, vsplit & tab
augroup FugitiveMaps
	autocmd!
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-s> :norm o<CR>
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-v> :norm S<CR>
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-t> :norm O<CR>
augroup END
" Aliases
cabbrev Ga Git add
cabbrev Gb Git branch
cabbrev Gch Git checkout
cabbrev Gco Gcommit
cabbrev Gt Git tag
cabbrev Gm Gmerge
cabbrev Gs Gstatus
cabbrev Gst Git stash
" >>> (( vim-commentary )) {{{1
augroup Commentary
	autocmd!
	autocmd FileType vader,cmusrc setlocal commentstring=#\ %s
	autocmd FileType xdefaults setlocal commentstring=!\ %s
augroup END
" >>> (( agit )) {{{1
let g:agit_no_default_mappings = 1
augroup Agit
	autocmd!
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> ch <Plug>(agit-git-checkout)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> P <Plug>(agit-print-commitmsg)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> q <Plug>(agit-exit)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> R <Plug>(agit-reload)
	autocmd Filetype agit,agit_stat nmap <buffer> D <Plug>(agit-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
augroup END
" >>> (( nerdtree-git-plugin )) {{{1
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ "Unknown"   : "?"
"     \ }
" >>> (( vim-rvm )) {{{1
" Enable rvm default ruby version in GUI start
if g:hasUnix
	augroup Rvm
		autocmd!
		autocmd GUIEnter * Rvm
	augroup END
endif
" >>> (( vimproc )) {{{1
" Open arg with default system command
command! -complete=file -nargs=1 Open :call vimproc#open(<f-args>)
let g:vimproc#download_windows_dll = 1
" >>> (( vim-highlightedyank )) {{{1
let g:highlightedyank_highlight_duration = 200
map <silent> y <Plug>(highlightedyank)
map <silent> Y <Plug>(highlightedyank)$
" The following mappings are already defined in /config/minimal.vim
nmap <silent> cy "+<Plug>(highlightedyank)
nmap <silent> cY "+<Plug>(highlightedyank)$
" >>> (( vim-sandwich )) {{{1
call operator#sandwich#set('all', 'all', 'cursor', 'keep')
call operator#sandwich#set('all', 'all', 'hi_duration', 50)
vmap v ab
" Allow using . with the keep cursor option enabled
nmap . <Plug>(operator-sandwich-dot)
hi link OperatorSandwichStuff StatusLine
" >>> (( indentLine )) {{{1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['json', 'vim', 'javascript', 'c', 'sh', 'php']
" >>> (( vim-markdown )) {{{1
let g:markdown_enable_mappings = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_input_abbreviations = 0
" >>> (( vim-jsdoc )) {{{1
augroup JsDoc
	autocmd!
	autocmd Filetype javascript nnoremap <buffer> <silent> <C-d> :JsDoc<CR>
	autocmd Filetype javascript inoremap <buffer> <silent> <C-d> <C-o>:JsDoc<CR>
augroup END
" Check doc when needed!!!
" >>> (( tern_for_vim )) {{{1
let tern_show_signature_in_pum = 1
augroup Tern
	autocmd!
	autocmd Filetype javascript nmap <buffer> gk :TernDoc<CR>
	autocmd Filetype javascript nmap <buffer> gd :TernDef<CR>
	autocmd Filetype javascript nmap <buffer> gD :TernRefs<CR>
	autocmd Filetype javascript nmap <buffer> gr :TernRename<CR>
augroup END
" >>> (( airnote )) {{{1
let g:airnote_path = expand(g:vimDir . '/misc/memos')
let g:airnote_suffix = 'md'
let g:airnote_date_format = '%d %b %Y %X'
let g:airnote_open_prompt = 'Open note > '
let g:airnote_delete_prompt = 'Delete note > '
let g:airnote_default_open_cmd = 'vsplit'
" Auto-generate the date when the file is saved
augroup Airnote
	autocmd!
	execute printf(
				\ 'autocmd BufWrite %s/*.%s :call setline(1,  "> " . strftime(g:airnote_date_format))',
				\ g:airnote_path,
				\ g:airnote_suffix
			\ )
augroup END
" >>> (( vim-signjk-motion )) {{{1
nmap gj <Plug>(signjk-j)
nmap gk <Plug>(signjk-k)
" To use with an operator (c/d/v...)
omap L <Plug>(textobj-signjk-lines)
vmap L <Plug>(textobj-signjk-lines)
" >>> (( vim-parenmatch )) {{{1
let g:parenmatch_highlight = 0
hi! link ParenMatch WarningMsg
" >>> (( vim-emoji )) {{{1
augroup Emoji
	autocmd!
	autocmd FileType markdown,gitcommit :setl omnifunc=emoji#complete
augroup END
" >>> (( zoomwintab )) {{{1
nnoremap gsz :ZoomWinTabToggle<CR>
" >>> (( textobj-usr )) & its plugins {{{1
" (( vim-textobj-comment )) {{{2
let g:textobj_comment_no_default_key_mappings = 1
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)
" (( vim-textobj-python )) {{{2
let g:textobj_python_no_default_key_mappings = 1
call textobj#user#map('python', {
			\	'class': {
			\		'select-a': '<buffer>aC',
			\		'select-i': '<buffer>iC',
			\	}
			\ })
" >>> (( vim-gutentags )) {{{1
let g:gutentags_ctags_executable = 'ctags-exuberant'
let g:gutentags_cache_dir = g:vimDir . '/misc/tags/'
let g:gutentags_define_advanced_commands = 1
" >>> (( zeavim )) {{{1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap <leader>z <Plug>ZVKeyDocset
nmap gZ <Plug>ZVKeyDocset<CR>
nmap gz <Plug>ZVMotion
let g:zv_file_types = {
			\	'help'               : 'vim',
			\	'.htaccess'          : 'apache http server',
			\	'javascript'         : 'javascript,nodejs',
			\	'python'             : 'python 3',
			\	'\v^(G|g)ulpfile\.'  : 'gulp,javascript,nodejs',
			\ }
let g:zv_docsets_dir = g:hasUnix ?
			\ '~/Important!/docsets_Zeal/' :
			\ 'Z:/k-bag/Important!/docsets_Zeal/'
" >>> (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
let g:vcool_ins_rgb_map = '<A-r>'
" >>> (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
let g:gv_unite_cmd = 'GulpExt'
" >>> (( lazyList )) {{{1
let g:lazylist_omap = 'ii'
nnoremap gli :LazyList ''<Left>
vnoremap gli :LazyList ''<Left>
let g:lazylist_maps = [
			\	'gl',
			\	{
			\		'l'  : '',
			\		'*'  : '* ',
			\		'-'   : '- ',
			\		'+'   : '+ ',
			\		't'   : '- [ ] ',
			\		'2'  : '%2%. ',
			\		'3'  : '%3%. ',
			\		'.1' : '1.%1%. ',
			\		'.2' : '2.%1%. ',
			\		'.3' : '3.%1%. ',
			\	}
			\ ]
" >>> (( vBox )) {{{1
nnoremap <S-F2> :VBEdit 
let g:vbox = {
			\	'dir': g:vimDir . '/misc/templates',
			\	'empty_buffer_only': 0
			\ }
let g:vbox.variables = {
			\	'%NAME%'     : 'Kabbaj Amine',
			\	'%MAIL%'     : 'amine.kabb@gmail.com',
			\	'%LICENSE%'  : 'MIT',
			\	'%PROJECT%'  : 'f=fnamemodify(getcwd(), ":t")',
			\	'%YEAR%'     : 'f=strftime("%Y")',
			\	'%REPO%'     : 'https://github.com/KabbAmine/'
			\ }
augroup VBoxAuto
	autocmd!
	" For vim plugins
	exe 'autocmd BufNewFile ' . s:myPlugins . '*/README.md :VBTemplate README.md-vim'
	exe 'autocmd BufNewFile ' . s:myPlugins . '*/**/*.vim :VBTemplate vim-plugin'
	exe 'autocmd BufNewFile ' . s:myPlugins . '*/doc/*.txt :VBTemplate vim-doc'
	" Misc
	autocmd BufNewFile LICENSE                          :VBTemplate license-MIT
	autocmd BufNewFile CHANGELOG.md,.tern-project       :VBTemplate
	autocmd BufNewFile *.py,*.sh,*.php,*.html,*.js,*.c  :VBTemplate
augroup END
" >>> (( vt )) {{{1
nnoremap <silent> !: :VT<CR>
" >>> (( imagePreview )) {{{1
nmap gi <Plug>(image-preview)
let g:image_preview = {
			\	'_': {
			\		'prg'  : 'feh',
			\		'args' : '--scale-down --no-menus --quiet --magick-timeout 1',
			\	},
			\	'gif': {
			\		'prg'  : 'exo-open',
			\		'args' : '',
			\	},
			\ }
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
