" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-03-29
" ================================================================

" Personal vim plugins directory {{{1
let s:myPlugins = g:hasWin ?
			\ 'z:\\k-bag\\Projects\\pluginsVim\\' :
			\ '$HOME/Projects/pluginsVim/'
" Useful variables & functions {{{1
fun! s:PlugInOs(link, param, os) abort " {{{2
	if has(a:os)
		let l:opt = (!empty(a:param) ? ', ' . a:param : '')	
		exe printf("Plug '%s'%s", a:link, l:opt)
	endif
endfun
fun! <SID>CmdForDispatcher(cmd) abort " {{{2
	" A wrapper to use with dispatcher plugins (Vimux, dispatch...)
	" e.g of a:cmd: "VimuxRunCommand '%s'"
	let g:last_dispatcher_cmd = exists('g:last_dispatcher_cmd') ? g:last_dispatcher_cmd : ''
	echohl Statement
	let l:uc = input('Command> ', g:last_dispatcher_cmd)
	echohl None
	if !empty(l:uc)
		let g:last_dispatcher_cmd = l:uc
		let l:c = printf('cd %s && clear; %s', getcwd(), l:uc)
		silent execute printf(a:cmd, l:c)
		redraw!
	endif
endfun
" My plugins {{{2
let s:myPlugs = {
			\'gulp-vim'    : '',
			\'imgPrev'    : "{'on': ['<Plug>(imgprev-preview)', 'ImgPrev']}",
			\'lazyList'    : '',
			\'vBox'        : '',
			\'vcml'        : '',
			\'vCoolor'     : '',
			\'vullScreen'  : '',
			\'vZoom'       : "{'on': ['<Plug>(vzoom)', 'VZoomAutoToggle']}",
			\'yowish'      : '',
			\'zeavim'      : "{'on': ['<Plug>Zeavim', '<Plug>ZVVisSelection', '<Plug>ZVKeyDocset', '<Plug>ZVMotion']}"
		\ }
fun! s:MyPlugs() abort
	let l:pn = keys(s:myPlugs)
	let l:pl = values(s:myPlugs)
	for l:i in range(0, len(l:pn) - 1)
		let l:opt = (!empty(l:pl[l:i]) ? ', ' . l:pl[l:i] : '')
		exec printf("Plug '%s'%s", expand(s:myPlugins) . l:pn[l:i], l:opt)
	endfor
endfun
" 2}}}
" 1}}}

" ========== VIM-PLUG ==============================================
" Initialization {{{1
let s:plug_home = g:vimDir . '/plugs'
call plug#begin(s:plug_home)
unlet s:plug_home
" Plugins {{{1
" Most syntaxes in one plugin {{{2
call s:PlugInOs('sheerun/vim-polyglot' , "{'do': './build'}" , 'unix')
call s:PlugInOs('sheerun/vim-polyglot' , ''                  , 'win32')
" For PHP {{{2
Plug '2072/PHP-Indenting-for-VIm'     , {'for': 'php'}
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'shawncplus/phpcomplete.vim'     , {'for': 'php'}
Plug 'sumpygump/php-documentor-vim'   , {'for': 'php'}
" For JavaScript {{{2
Plug 'elzr/vim-json'
Plug 'gavocanov/vim-js-indent'
Plug 'heavenshell/vim-jsdoc'
Plug 'marijnh/tern_for_vim'                   , {'do': 'npm install'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
" For Python {{{2
Plug 'davidhalter/jedi-vim', {'do': 'git submodule update --init', 'for': 'python'}
Plug 'hdima/python-syntax'
" Other syntaxes & related-syntax plugins {{{2
Plug 'othree/csscomplete.vim' , {'for': 'css'}
" For web development {{{2
Plug 'docunext/closetag.vim' , {'for': ['html', 'php', 'xml']}
Plug 'lilydjwg/colorizer'    , {'on': 'ColorToggle'}
Plug 'mattn/emmet-vim'
Plug 'shime/vim-livedown'    , {'on':  ['LivedownToggle', 'LivedownPreview', 'LivedownKill']}
" For Git & github {{{2
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'             , {'on': ['Agit', 'AgitFile']}
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin' , {'on': 'NERDTreeToggle'}
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
" (( syntastic )) {{{2
Plug 'scrooloose/syntastic',
			\ {'on': ['SyntasticReset', 'SyntasticCheck', 'SyntasticToggle', 'SyntasticInfo']}
" (( textobj-user )) {{{2
Plug 'kana/vim-textobj-user'
			\| Plug 'glts/vim-textobj-comment'
			\| Plug 'kana/vim-textobj-function'
			\| Plug 'kentaro/vim-textobj-function-php'       , {'for': 'php'}
			\| Plug 'thinca/vim-textobj-function-javascript' , {'for': 'javascript'}
" (( operator-user )) {{{2
Plug 'kana/vim-operator-user'
			\| Plug 'haya14busa/vim-operator-flashy'
" Edition & moving {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'haya14busa/vim-signjk-motion',
			\ {'on': ['<Plug>(signjk-j)', '<Plug>(signjk-k)', '<Plug>(textobj-signjk-lines)']}
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Various {{{2
call s:PlugInOs('benmills/vimux' , ''              , 'unix')
call s:PlugInOs('tpope/vim-rvm'  , "{'on': 'Rvm'}" , 'unix')
Plug 'Chiel92/vim-autoformat'    , {'on': 'Autoformat'}
Plug 'google/vim-searchindex'
Plug 'iwataka/airnote.vim'       , {'on': ['Note', 'NoteDelete']}
Plug 'junegunn/vader.vim'        , {'on': 'Vader', 'for': 'vader'}
Plug 'kana/vim-tabpagecd'
Plug 'matchit.zip'
Plug 'mbbill/undotree'           , {'on': 'UndotreeToggle'}
Plug 'rhysd/clever-f.vim'
Plug 'rhysd/vim-grammarous'
Plug 'scrooloose/nerdtree'       , {'on': 'NERDTreeToggle'}
Plug 'Shougo/neocomplete.vim'
			\| Plug 'Shougo/neco-vim' , {'for': 'vim'}
Plug 'thinca/vim-quickrun'       , {'on': ['QuickRun', 'AutoQR']}
Plug 'tpope/vim-dispatch'
" Interface {{{2
Plug 'itchyny/vim-parenmatch'
Plug 'Yggdroot/indentLine'
call s:PlugInOs('ryanoasis/vim-devicons' , '', 'unix')
" My Plugins {{{2
call s:MyPlugs()
" }}}
" }}}
" End {{{1
call plug#end()
" }}}

" ========== VARIOUS  ===========================================
" Colors {{{1
if exists('$TERM') && $TERM =~# '^xterm' && !exists('$TMUX') && !g:isNvim
	set term=xterm-256color
endif
let g:yowish = {'term_italic': 0}
colo yowish
hi! link TabLineSel Search
" }}}

" =========== PLUGINS MAPPINGS & OPTIONS =======================
" ******* (( NERDTree )) {{{1
nnoremap <silent> ,N :NERDTreeToggle<CR>
" Close NERTree otherwise delete buffer
" (The delete buffer is already mapped in config/minimal.vim)
nnoremap <silent> <S-q> :call <SID>CloseNERDTree()<CR>
fun! <SID>CloseNERDTree() abort
	if exists('b:NERDTree')
		execute 'NERDTreeClose'
	else
		execute ':bd'
	endif
endfun
if g:hasWin
	let NERDTreeBookmarksFile = 'C:\Users\k-bag\vimfiles\various\NERDTreeBookmarks'
else
	let NERDTreeBookmarksFile = '/home/k-bag/.vim/various/NERDTreeBookmarks'
endif
let NERDTreeIgnore = ['\~$', '\.class$']
" Single-clic for folder nodes and double for files.
let NERDTreeMouseMode = 2
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 2
augroup NerdTree
	autocmd!
	autocmd FileType nerdtree setlocal nolist
	" autocmd WinEnter * if exists('b:NERDTree') | silent execute 'normal R' | endif
augroup END
" ******* (( python-syntax )) {{{1
let python_highlight_all = 1
" ******* (( syntastic )) {{{1
nnoremap <silent> <F8> :call <SID>SyntasticToggle()<CR>
function! <SID>SyntasticToggle() abort
	SyntasticToggle
	if g:syntastic_mode_map.mode ==# 'active'
		SyntasticCheck
	else
		SyntasticReset
	endif
endfunction
nnoremap <silent> ,E :Errors<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
" For status line
let g:syntastic_stl_format = '%E{❌ %e}%B{, }%W{⚠ %w}'
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_error_symbol = "❌"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = ""
let g:syntastic_style_warning_symbol = ""
" The cursor will jump to the first error detected (1|2|3)
let g:syntastic_auto_jump = 2
" Checkers
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_python_checkers = ['pep8', 'python']
let g:syntastic_markdown_checkers = ['mdl']
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_javascript_jslint_args = '--white --nomen --regexp --plusplus --bitwise --newcap --sloppy --vars --browser'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_scss_checkers = ['scss-lint', 'sass']
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
if g:hasWin
	let g:syntastic_c_gcc_exec = 'C:\tools\DevKit2\mingw\bin\gcc.exe'
	let g:syntastic_php_checkers = 'php'
	let g:syntastic_php_php_exec = 'C:\tools\xampp\php\php.exe'
endif
" ******* (( emmet )) {{{1
" Enable emmet for specific files.
let g:user_emmet_install_global = 0
augroup emmet
	autocmd!
	autocmd FileType html,scss,css,pug EmmetInstall
	" autocmd FileType html,scss,css,pug imap <buffer> <expr> jhh emmet#expandAbbrIntelligent("\<tab>")
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
" ******* (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" ******* (( delimitmate )) {{{1
imap <S-space> <Plug>delimitMateS-Tab
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"
" ******* (( javascript-libraries-syntax )) {{{1
" let g:used_javascript_libs = 'jquery'
" ******* (( ultisnips )) {{{1
nnoremap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
let g:UltiSnipsEditSplit = 'vertical'
" Personal snippets folder.
let g:UltiSnipsSnippetsDir = g:vimDir . '/various/ultisnips'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', g:vimDir . '/various/ultisnips']
" ******* (( gitgutter )) {{{1
command! GG :GitGutterToggle
command! Gn :GitGutterNextHunk
command! Gp :GitGutterPrevHunk
command! GP :GitGutterPreviewHunk
if g:hasWin | let g:gitgutter_enabled = 0 | endif
" ******* (( Unite )) & plugins {{{1
" SETTINGS {{{2
" General {{{3
let g:unite_data_directory = g:vimDir . '/various/unite'
let g:unite_force_overwrite_statusline = 0
let g:unite_enable_auto_select = 0
let g:unite_quick_match_table = {
			\ '0': 29,
			\ '1': 20,
			\ '2': 21,
			\ '3': 22,
			\ '4': 23,
			\ '5': 24,
			\ '6': 25,
			\ '7': 26,
			\ '8': 27,
			\ '9': 28,
			\ 'a': 8,
			\ 'd': 4,
			\ 'e': 2,
			\ 'f': 0,
			\ 'g': 12,
			\ 'h': 17,
			\ 'i': 3,
			\ 'j': 1,
			\ 'k': 5,
			\ 'l': 7,
			\ 'm': 9,
			\ 'o': 18,
			\ 'p': 19,
			\ 'q': 10,
			\ 'r': 13,
			\ 's': 6,
			\ 't': 14,
			\ 'u': 16,
			\ 'w': 11,
			\ 'y': 15,
		\ }
call unite#custom#source(
			\ 'command, neomru/file, buffer',
			\ 'matchers', 'matcher_fuzzy')
" Default profile
"	* toggle: Close unite buffer if already exists
call unite#custom#profile('default', 'context', {
			\ 'start_insert'      : 1,
			\ 'force_redraw'      : 1,
			\ 'no_empty'          : 1,
			\ 'toggle'            : 1,
			\ 'vertical_preview'  : 1,
			\ 'winheight'         : 20,
			\ 'prompt'            : '▸ ',
			\ 'prompt_focus'      : 1,
			\ 'candidate_icon'    : '  ▫ ',
			\ 'marked_icon'       : '  ▪ ',
			\ 'no_hide_icon'      : 1,
		\ })
" Use ag {{{3
let g:unite_source_rec_async_command =
			\ ['ag', '-i', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
			\ '-i --column --nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
" Converters for source {{{3
let s:filters = {'name' : 'buffer_simple_format'}
function! s:filters.filter(candidates, context)
	for candidate in a:candidates
		let l:num = candidate.action__buffer_nr
		let l:name = bufname(l:num)
		let l:name = !empty(l:name) ? l:name : '[NO NAME]'
		let l:path = fnamemodify(l:name, ':p:h')
		let l:modified = getbufvar(l:name, '&modified') ==# 1 ? '➕' : ' '
		let candidate.abbr = printf('%-*s %s %2s %s',
					\ 15, fnamemodify(l:name, ':p:t'),
					\ l:modified,
					\ l:num,
					\ fnamemodify(l:path, ':.')
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
			\ '/usr/bin/ctags' : 'C:\Program Files\ctags58\ctags.exe'
let g:unite_source_outline_filetype_options = {
			\ '*': {
			\   'auto_update': 1,
			\   'auto_update_event': 'write'
			\ }
		\ }
" MAPPINGS {{{2
function! <SID>Unite(name, source, ...) abort
	" Return unite command with different sources depending of .git directory
	" presence:
	"	Unite -buffer-name=a:name a:source/git
	"	Unite -buffer-name=a:name a:source
	" a:1 is 2nd part of source when git is not used (e.g. '/async')
	" a:2 is options (e.g. ':.')
	let l:args = exists('a:2') ? a:2 : ''
	let l:source = isdirectory(getcwd() . '/.git') ?
				\ ' ' . a:source . '/git' . l:args :
				\ ' ' . a:source . (exists('a:1') ? a:1 : '') . l:args
	execute ':Unite -buffer-name=' . a:name . l:source
endfunction
inoremap <silent> <A-y> <Esc>:Unite -buffer-name=Yanks -default-action=append history/yank<CR>
nnoremap <silent> ,B :Unite -buffer-name=Bookmarks -default-action=cd bookmark:_<CR>
nnoremap <silent> ,b :Unite -buffer-name=Buffers buffer<CR>
nnoremap <silent> ,d :Unite -buffer-name=File file<CR>
nnoremap <silent> ,f :Unite -buffer-name=Files -no-force-redraw file_rec/async<CR>
" nnoremap <silent> ,f :call <SID>Unite('Files', 'file_rec', '/async')<CR>
nnoremap <silent> ,,f :Unite -buffer-name=SearchFor -winheight=10 outline<CR>
nnoremap <silent> ,g :Unite -buffer-name=Grep -no-start-insert -keep-focus -no-quit grep:.<CR>
" nnoremap <silent> ,g :call <SID>Unite('Grep', 'grep', '', ':.')<CR>
nnoremap <silent> ,G :Unite -buffer-name=Gulp -vertical -winwidth=30 -resize gulp<CR>
nnoremap <silent> ,l :Unite -buffer-name=Search -custom-line-enable-highlight line:all<CR>
nnoremap <silent> ,m :Unite -buffer-name=Marks mark<CR>
nnoremap <silent> ,r :Unite -buffer-name=Recent -empty neomru/file<CR>
nnoremap <silent> ,T :Unite -buffer-name=Outline outline -no-focus -keep-focus -no-start-insert -no-quit -winwidth=50 -vertical -direction=belowright<CR>
nnoremap <silent> !! :Unite -buffer-name=Commands -empty command<CR>
nnoremap <silent> ,y :Unite -buffer-name=Yanks -default-action=append history/yank<CR>
nnoremap <silent> z= :Unite -buffer-name=SpellSuggest -vertical -winwidth=40 -empty spell_suggest<CR>
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
	imap <silent> <buffer> <Esc> <Plug>(unite_exit)
	imap <silent> <buffer> <F5> <Plug>(unite_redraw)
	imap <silent> <buffer> jk <Plug>(unite_insert_leave)
	imap <silent> <buffer> <Tab> <Plug>(unite_complete)
	inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
	inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction " 3}}}
" 1}}}
" ******* (( vim-plug )) {{{1
let g:plug_threads = 10
" ******* (( clever-f )) {{{1
let g:clever_f_across_no_line = 1
" Fix a direction of search (f & F)
let g:clever_f_fix_key_direction = 1
let g:clever_f_smart_case = 1
" ******* (( neocomplete )) {{{1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory = g:vimDir . '/various/neocomplete'
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
" ******* (( jedi-vim )) {{{1
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
" let g:jedi#force_py_version = 3
let g:jedi#goto_command = 'gd'
let g:jedi#documentation_command = 'gk'
let g:jedi#usages_command = 'gD'
" Don't use, buggy as hell
let g:jedi#rename_command = 'gr'
augroup jedi
	autocmd!
	autocmd FileType python setlocal omnifunc=jedi#completions
augroup END
" ******* (( autoformat )) {{{1
let g:formatters_html = ['htmlbeautify']
let g:formatdef_htmlbeautify = '"html-beautify --indent-size 2 --indent-inner-html true  --preserve-newlines -f - "'
" let g:autoformat_verbosemode = 1
" Make =ie autoformat for some ft
augroup Autoformat
	autocmd!
	autocmd Filetype html,json,css,javascript,scss nmap <buffer> =ie :Autoformat<CR>
augroup END
" ******* (( colorizer )) {{{1
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" ******* (( php-documentor )) {{{1
augroup PhpDoc
	autocmd!
	autocmd Filetype php nnoremap <buffer> <silent> <C-d> :call PhpDoc()<CR>
	autocmd Filetype php inoremap <buffer> <silent> <C-d> <C-o>:call PhpDoc()<CR>
	autocmd Filetype php vnoremap <buffer> <silent> <C-d> :call PhpDocRange()<CR>
augroup END
let g:pdv_cfg_ClassTags = []
" ******* (( vim-devicons )) {{{1
if g:hasUnix
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:webdevicons_enable_airline_statusline = 0
	let g:webdevicons_enable_unite = 0
endif
" ******* (( tabular )) {{{1
vmap <CR><CR> :Tabularize /
vmap <silent> <CR>: :Tabularize /^[^:]*\zs<CR>
vmap <silent> <CR>, :Tabularize /^[^,]*\zs,/l1r1<CR>
vmap <silent> <CR>. :Tabularize /^[^.]*\zs./l1r1<CR>
" This was better using autocmd, but I had a ******* strange behavior so I used
" a more simple approach
function! <SID>AutoTabularize(pattern) abort
	let l:ip = getpos('.')
	exe ':Tabularize /' . a:pattern
	call setpos('.', l:ip)
endfunction
command! TabularAutoToggle :call <SID>TabularAutoToggle()
function! <SID>TabularAutoToggle() abort
	if !exists('g:tabular_auto_state')
		echo "TabularAuto enabled"
		let g:tabular_auto_state = 1
		inoremap <silent> \| \|<Esc>:call <SID>AutoTabularize('\|')<CR>A
	else
		echo "TabularAuto disabled"
		iunmap \|
		unlet! g:tabular_auto_state
	endif
endfunction
" ******* (( fugitive )) {{{1
" Some abbreviations
cab Gb Git branch
cab Gch Git checkout
cab Gco Gcommit
cab Gl Gllog
cab Gm Gmerge
cab Gs Gstatus
cab Gst Git stash
" ******* (( vim-json )) {{{1
let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 0
" ******* (( vim-commentary )) {{{1
augroup Commentary
	autocmd!
	autocmd FileType vader setlocal commentstring=#\ %s
augroup END
" ******* (( polyglot )) {{{1
let g:polyglot_disabled = ['markdown', 'json', 'javascript', 'python']
" ******* (( quickRun )) {{{1
let g:quickrun_no_default_key_mappings = 0
nnoremap <silent> gR :QuickRun<CR>
vnoremap <silent> gR :QuickRun<CR>
" QuickRun on save file
nnoremap gaR :call <SID>AutoQR()<CR>
fun! <SID>AutoQR() abort
	if !exists('#AQR')
		augroup AQR
			autocmd!
			autocmd BufWritePost,WinEnter * :QuickRun
		augroup END
		echo 'QuickRun auto update enabled'
	else
		augroup AQR
			autocmd!
		augroup END
		augroup! AQR
		echo 'QuickRun auto update disabled'
	endif
endfun
" ******* (( agit )) {{{1
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
" ******* (( nerdtree-git-plugin )) {{{1
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
" ******* (( vim-dispatch )) {{{1
if g:hasWin
	nnoremap <silent> !: :call <SID>CmdForDispatcher('Start! -wait=always %s')<CR>
endif
" ******* (( vim-rvm )) {{{1
" Enable rvm default ruby version in GUI start
if g:hasUnix
	augroup Rvm
		autocmd!
		autocmd GUIEnter * Rvm
	augroup END
endif
" ******* (( vimux )) {{{1
if g:hasUnix
	let g:VimuxHeight = '50'
	let g:VimuxOrientation = 'h'
	let g:VimuxUseNearest = 0		" Split window by default
	nnoremap <silent> <leader>vc :VimuxCloseRunner<CR>
	nnoremap <silent> <leader>vi :VimuxInterruptRunner<CR>
	nnoremap <silent> !: :call <SID>CmdForDispatcher("VimuxRunCommand '%s'")<CR>
endif
" ******* (( vimproc )) {{{1
" Open arg with default system command
command! -complete=file -nargs=1 Open :call vimproc#open(<f-args>)
if g:hasWin
	let g:vimproc#dll_path = g:vimDir . '/various/vimproc_win32.dll'
endif
" ******* (( vim-operator-flashy )) {{{1
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#group = 'Search'
" ******* (( vim-surround )) {{{1
nmap S ys
" ******* (( vim-grammarous )) {{{1
let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-3.2.zip'
let g:grammarous#default_comments_only_filetypes = {
			\ 'vim' : 1,
			\ 'sh' : 1
		\ }
			" \ '*' : 1,
let g:grammarous#hooks = {}
" gn/gp for moving to errors only when GrammarCheck in enabled
function! g:grammarous#hooks.on_check(errs)
	nmap <buffer> gn <Plug>(grammarous-move-to-next-error)
	nmap <buffer> gp <Plug>(grammarous-move-to-previous-error)
endfunction
function! g:grammarous#hooks.on_reset(errs)
	nunmap <buffer> gn
	nunmap <buffer> gp
endfunction
" ******* (( phpfolding )) {{{1
let g:DisableAutoPHPFolding = 1
" ******* (( indentLine )) {{{1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['vim', 'javascript', 'c', 'sh', 'php']
" ******* (( vim-markdown )) {{{1
" Enable syntax highlighting in codeblocks for some file types
" let g:markdown_fenced_languages = ['html', 'vim', 'css', 'python', 'bash=sh', 'javascript', 'scss', 'php']
" ******* (( vim-jsdoc )) {{{1
augroup JsDoc
	autocmd!
	autocmd Filetype javascript nnoremap <buffer> <silent> <C-d> :JsDoc<CR>
	autocmd Filetype javascript inoremap <buffer> <silent> <C-d> <C-o>:JsDoc<CR>
augroup END
" Check doc when needed!!!
" ******* (( tern_for_vim )) {{{1
let tern_show_signature_in_pum = 1
augroup Tern
	autocmd!
	autocmd Filetype javascript nmap <buffer> gk :TernDoc<CR>
	autocmd Filetype javascript nmap <buffer> gd :TernDef<CR>
	autocmd Filetype javascript nmap <buffer> gD :TernRefs<CR>
	autocmd Filetype javascript nmap <buffer> gr :TernRename<CR>
augroup END
" ******* (( airnote )) {{{1
let g:airnote_path = expand(g:vimDir . '/various/memos')
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
" ******* (( vim-signjk-motion )) {{{1
nmap gj <Plug>(signjk-j)
nmap gk <Plug>(signjk-k)
" To use with an operator (c/d/v...)
omap L <Plug>(textobj-signjk-lines)
vmap L <Plug>(textobj-signjk-lines)
" ******* (( zeavim )) {{{1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap gZ <Plug>ZVKeyDocset
nmap gz <Plug>ZVMotion
let g:zv_file_types = {
			\ 'python': 'python 3',
			\ 'help'  : 'vim'
		\ }
let g:zv_docsets_dir = g:hasUnix ?
			\ '~/Important!/docsets_Zeal/' :
			\ 'Z:/k-bag/Important!/docsets_Zeal/'
" ******* (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
let g:vcool_ins_rgb_map = '<A-r>'
" ******* (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
let g:gv_use_dispatch = 0
let g:gv_unite_cmd = 'GulpExt'
let g:gv_custom_cmd = g:hasUnix ?
			\ ['VimuxRunCommand "clear && %s"', 1] :
			\ 'Start! %s'
" ******* (( lazyList )) {{{1
let g:lazylist_omap = 'ii'
nnoremap gli :LazyList ''<Left>
vnoremap gli :LazyList ''<Left>
let g:lazylist_maps = [
			\ 'gl',
			\ {
				\ 'l'  : '',
				\ '*'  : '* ',
				\ '-'   : '- ',
				\ '+'   : '+ ',
				\ 't'   : '- [ ] ',
				\ '2'  : '%2%. ',
				\ '3'  : '%3%. ',
				\ '.1' : '1.%1%. ',
				\ '.2' : '2.%1%. ',
				\ '.3' : '3.%1%. ',
			\ }
		\]
" ******* (( vZoom )) {{{1
nmap gsz <Plug>(vzoom)
let g:vzoom = {}
let g:vzoom.equalise_windows = 1
" ******* (( vBox )) {{{1
nnoremap <S-F2> :VBEdit 
let g:vbox = {
			\ 'dir': g:vimDir . '/various/templates',
			\ 'empty_buffer_only': 0
		\ }
let g:vbox.variables = {
			\ '%NAME%'     : 'Kabbaj Amine',
			\ '%MAIL%'     : 'amine.kabb@gmail.com',
			\ '%LICENSE%'  : 'MIT',
			\ '%PROJECT%'  : 'f=fnamemodify(getcwd(), ":t")',
			\ '%YEAR%'     : 'f=strftime("%Y")',
			\ '%REPO%'     : 'https://github.com/KabbAmine/'
		\ }
augroup VBoxAuto
	autocmd!
	autocmd BufNewFile README.md,CHANGELOG.md,.tern-project  :VBTemplate
	autocmd BufNewFile LICENSE                               :VBTemplate license-MIT
	autocmd BufNewFile *.py,*.sh,*.php,*.html,*.js           :VBTemplate
augroup END
" ******* (( imgPrev )) {{{1
nmap gi <Plug>(imgprev-preview)
let g:imgprev = {
			\ 'gif': {
				\ 'prg'  : 'gpicview',
				\ 'args' : '',
			\ },
		\ }
" ******* (( vSourcePreview )) {{{1
" nnoremap <silent> gP :VSPToggle<CR>
" vnoremap <silent> gP :VSPPreview<CR>
" let g:vsp_config = {
" 			\ 'split'             : 'rightbelow vertical',
" 			\ 'sync_scroll'       : 1,
" 			\ 'update_after_ins'  : 1,
" 			\ 'update_after_save' : 1,
" 			\ 'auto_indent'       : 0
" 			\ }
" let g:vsp_user_provider = {
" 			\ 'javascript' : { 'cmd': 'nodejs', 'type': '' },
" 			\ 'python'     : { 'cmd': 'python3', 'type': '' }
" 			\ }
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
