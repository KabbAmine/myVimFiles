" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2015-08-31
" ================================================================


" Personal vim plugins directory {{{1
if g:hasWin
	let s:myPlugins = "z:\\k-bag\\Projects\\pluginsVim\\"
else
	let s:myPlugins = "$HOME/Projects/pluginsVim/"
endif
" List of my plugins {{{1
let s:myPlugs = [
			\'gulp-vim',
			\'lazyList',
			\'test',
			\'vCoolor',
			\'vimSimpleLib',
			\'vullScreen',
			\'yowish',
			\'zeavim'
			\]
" Useful variables & functions {{{1
function! s:PlugInOs(link, param, os)
	if has(a:os)
		if !empty(a:param)
			execute "Plug '".a:link."', ".a:param.""
		else
			execute "Plug '".a:link."'"
		endif
	endif
endfunction
" }}}

" ========== VIM-PLUG ==============================================
" Initialization {{{1
if g:hasWin
	call plug#begin($HOME . '/vimfiles/plugs')
else
	call plug#begin('~/.vim/plugs')
endif
" Plugins {{{1
" For PHP {{{2
Plug '2072/PHP-Indenting-for-VIm'     , {'for': 'php'}
Plug 'rayburgemeestre/phpfolding.vim'
Plug 'shawncplus/phpcomplete.vim'     , {'for': 'php'}
Plug 'StanAngeloff/php.vim'           , {'for': 'php'}
Plug 'sumpygump/php-documentor-vim'   , {'for': 'php'}
" For HTML, CSS, jade, SASS & markdown {{{2
Plug 'digitaltoad/vim-jade'    , {'for': 'jade'}
Plug 'docunext/closetag.vim'   , {'for': ['html', 'php', 'xml']}
Plug 'JulesWang/css.vim'       , {'for': 'css'}
Plug 'lilydjwg/colorizer'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'        , {'for': ['html', 'php', 'xml']}
Plug 'plasticboy/vim-markdown' , {'for': ['md', 'markdown']}
Plug 'shime/vim-livedown'      , {'on':  ['LivedownToggle', 'LivedownPreview', 'LivedownKill']}
Plug 'tpope/vim-haml'          , {'for': ['sass', 'scss', 'haml']}
" For JavaScript {{{2
Plug 'elzr/vim-json'                          , {'for': 'json' }
Plug 'gavocanov/vim-js-indent'                , {'for': 'javascript'}
Plug 'marijnh/tern_for_vim'                   , {'do': 'npm install', 'for': 'javascript'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'                        , {'for': 'javascript'}	" Js syntax
" For Python {{{2
Plug 'davidhalter/jedi-vim', { 'for': 'python'}
Plug 'hdima/python-syntax' , { 'for': 'python' }
" For Java {{{2
Plug 'javacomplete' , { 'for': 'java' }
" Other syntaxes {{{2
Plug 'smancill/conky-syntax.vim' , {'for': 'conkyrc'}
Plug 'tejr/vim-tmux'             , {'for': 'tmux'}
" For Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'jaxbot/github-issues.vim'
Plug 'PAntoine/vimgitlog'
Plug 'tpope/vim-fugitive'
" (( fuzzyfinder )) {{{2
Plug 'FuzzyFinder' | Plug 'L9'
" (( ultisnips )) {{{2
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" (( ctrlp )) {{{2
" A fork of CtrlP , more active repo.
Plug 'ctrlpvim/ctrlp.vim'
			\| Plug 'fisadev/vim-ctrlp-cmdpalette' , { 'on': 'CtrlPCmdPalette' }
			\| Plug 'tacahiroy/ctrlp-funky'        , { 'on': 'CtrlPFunky' }
" (( syntastic )) & linters {{{2
Plug 'scrooloose/syntastic'
" (( tagbar )) {{{2
Plug 'majutsushi/tagbar'
			\| call s:PlugInOs('vim-php/tagbar-phpctags.vim', "{'do': 'make'}", 'unix')
" Interface {{{2
call s:PlugInOs('ryanoasis/vim-devicons' , ''                 , 'unix')
Plug 'bling/vim-airline'
Plug 'kshenoy/vim-signature'
Plug 'ntpeters/vim-airline-colornum'
Plug 'Yggdroot/indentLine'
Plug 'zhaocai/GoldenView.Vim'          , {'on': 'ToggleGoldenViewAutoResize'}
" Various {{{2
call s:PlugInOs('Shougo/vimproc.vim'   , "{ 'do': 'make' }" , 'unix')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'andy-morris/vim-indented-blocks'
Plug 'Chiel92/vim-autoformat'          , { 'on': 'AutoFormat' }
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-peekaboo'
Plug 'matchit.zip'
Plug 'matze/vim-move'
Plug 'mbbill/undotree'                 , { 'on': 'UndotreeToggle' }
Plug 'Raimondi/delimitMate'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree'             , { 'on': 'NERDTreeToggle' }
Plug 'Shougo/neocomplete.vim'
Plug 'sk1418/Join'                     , { 'on': 'Join' }
Plug 'tcd.vim'                         , {'on': 'Tcd'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rvm'                   , { 'on': 'Rvm' }
Plug 'tpope/vim-surround'
" Colorschemes {{{2
Plug 'ajh17/Spacegray.vim'
Plug 'chriskempson/tomorrow-theme' , { 'rtp': 'vim' }
Plug 'mgutz/gosu-colors'
Plug 'nanotech/jellybeans.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'whatyouhide/vim-gotham'
" My Plugins {{{2
for s:p in s:myPlugs
	exec "Plug '" . s:myPlugins . s:p . "'"
endfor
" }}}
" }}}
" End {{{1
call plug#end()
" }}}

" ========== VARIOUS  ===========================================
" Colorscheme {{{1
if g:hasWin
	colorscheme yowish
elseif has("gui_running") || exists("$TMUX")
	colorscheme yowish
elseif exists("$TERM") && ($TERM =~ "^xterm")
	set term=xterm-256color		" Force using 256 colors.
	colorscheme yowish
endif
" }}}

" =========== MAPPING ==========================================
" Operations on current buffer (Move between errors in (( syntastic )) ) {{{1
" *** <c-F3>	=> lprevious.
" *** <c-F4>	=> lnext.
nmap <silent> <c-F3> :lprevious<CR>
nmap <silent> <c-F4> :lnext<CR>

" =========== OMNIFUNC ==============================
" }}}

" =========== PLUGINS MAPPINGS & OPTIONS =======================
" ******* (( FuzzyFinder )) {{{1
nmap <silent> ,B :FufBookmarkDir<CR>
nmap <silent> ,c :FufMruCmd<CR>
nmap <silent> ,d :FufDir<CR>
nmap <silent> ,F :FufFile<CR>
nmap <silent> ,b :FufBuffer<CR>
let g:fuf_modesDisable = ['mrufile']
let g:fuf_mrufile_maxItem = 40
let g:fuf_patternSeparator = '+'
" Cancel the <Ctrl-s> shortcut to use it in next command.
let g:fuf_keyPrevPattern = ''
let g:fuf_keyOpenSplit = '<C-s>'
let g:fuf_keyOpenVsplit = '<C-v>'
let g:fuf_buffer_keyDelete = '<C-d>'
" Cancel the <Ctrl-t> shortcut to use it in next command.
let g:fuf_keyNextMode = '<>'
let g:fuf_keyOpenTabpage = '<C-t>'
" Define the directory for data files.
execute "let g:fuf_dataDir = '".g:vimDir."/various/fuf-data/'"
" ******* (( NERDTree )) {{{1
nmap <silent> ,N :NERDTreeToggle<CR>
if g:hasWin
	let NERDTreeBookmarksFile='C:\Users\k-bag\vimfiles\various\NERDTreeBookmarks'
else
	let NERDTreeBookmarksFile='/home/k-bag/.vim/various/NERDTreeBookmarks'
endif
" Ignore the following files.
let NERDTreeIgnore=['\~$', '\.class$']
" Remove a buffer when a file is being deleted or renamed.
let NERDTreeAutoDeleteBuffer=1
" Single-clic for folder nodes and double for files.
let NERDTreeMouseMode=2
" Automatically remove a buffer when his file is being deleted/renamed via the menu.
let NERDTreeAutoDeleteBuffer=1
" Case sensitive sorting.
let NERDTreeCaseSensitiveSort=1
let NERDTreeDirArrows=1
let NERDTreeHijackNetrw=1
autocmd FileType nerdtree setlocal nolist
" ******* (( python-syntax )) {{{1
let python_highlight_all=1
" ******* (( tagbar )) & (( tagbar-phpctags )) {{{1
nnoremap <silent> ,T :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" Sort the elements by the order of appearance.
let g:tagbar_sort = 0
" Define the ctags location for windows.
if g:hasWin
	let g:tagbar_ctags_bin = 'C:\Program Files\ctags58\ctags.exe'
endif
" Get a simple list of ((ultisnips)) snippets in snippet files.
let g:tagbar_type_snippets = {
			\ 'ctagstype' : 'snippets',
			\ 'kinds' : [
			\ 's:snippets',
			\ ]
			\ }
" (( tagbar-phpctags )) only in Linux
if g:hasUnix
	let g:tagbar_phpctags_bin = g:vimDir . '/plugs/tagbar-phpctags.vim/bin/phpctags'
endif
" ******* (( airline )) {{{1
let g:airline_theme = 'yowish'
if has("gui_running") || exists("$TMUX")
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	" Automatically populate the symbols dictionary with the powerline symbols.
	let g:airline_powerline_fonts = 1
	" Extensions.
	let g:airline#extensions#tagbar#enabled = 1
	" endif
	" Tabline.
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_buffers = 1
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	" Show splits and tab number in tabline
	let g:airline#extensions#tabline#tab_nr_type = 2
	" Configure the minimum number of buffers needed to show the tabline.
	let g:airline#extensions#tabline#buffer_min_count = 2
	" Configure the minimum number of tabs needed to show the tabline.
	let g:airline#extensions#tabline#tab_min_count = 2
endif
" ******* (( syntastic )) {{{1
map <silent> <F8> :SyntasticCheck<CR>
map <silent> <c-F8> :SyntasticReset<CR>
map <silent> ,E :Errors<CR>
let g:syntastic_always_populate_loc_list = 1
"Skip checks using :wq, :x, and :ZZ
let g:syntastic_check_on_wq = 0
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_javac_checkers = ['javac']
let g:syntastic_javascript_checkers = ['jslint']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_scss_checkers = ['scss_lint', 'sass']
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
if g:hasWin
	let g:syntastic_c_gcc_exec = 'C:\tools\DevKit2\mingw\bin\gcc.exe'
	let g:syntastic_php_checkers = 'php'
	let g:syntastic_php_php_exec = 'C:\tools\xampp\php\php.exe'
endif
let g:syntastic_mode_map = {
			\ "mode": "passive",
			\ "active_filetypes": ["php", "sass", "scss", "html", "c", "java", "python", "html", "javascript", "css", "sh", "json"],
			\ "passive_filetypes": ["vim", "ruby"]
			\ }
" ******* (( emmet )) {{{1
" Enable emmet for specific files.
let g:user_emmet_install_global = 0
augroup emmet
	autocmd!
	autocmd FileType html,scss,css,jade EmmetInstall
	au FileType html,scss,css,jade imap <buffer> <expr> jh emmet#expandAbbrIntelligent("\<tab>")
augroup END
" In INSERT & VISUAL modes only.
let g:user_emmet_mode='iv'
let g:emmet_html5 = 1
" ******* (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" ******* (( delimitmate )) {{{1
" Skip CR expansion on pop-up
imap <S-space> <Plug>delimitMateS-Tab
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = "(:),[:],{:}"
" ******* (( javascript-libraries-syntax )) {{{1
let g:used_javascript_libs = 'jquery'
" ******* (( ultisnips )) {{{1
nmap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
" Personal snippets folder.
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" ******* (( gitgutter )) {{{1
command! GG :GitGutterToggle
command! Gn :GitGutterNextHunk
command! Gp :GitGutterPrevHunk
command! GP :GitGutterPreviewHunk
if g:hasWin | let g:gitgutter_enabled = 0 | endif
" ******* (( ctrlp & cie )) {{{1
nmap <silent> !!   :CtrlPCmdPalette<CR>
nmap <silent> ,f  :CtrlP<CR>
nmap <silent> ,,f   :CtrlPFunky<CR>
nmap <silent> ,l   :CtrlPLine %<CR>
nmap <silent> ,r   :CtrlPMRUFiles<CR>
nmap <silent> ,t   :CtrlPBufTag<CR>
" Disable CtrlP default map.
let g:ctrlp_map = ''
let g:ctrlp_cache_dir = g:vimDir . '/various/ctrlp'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_lazy_update = 1
" Open multiple files in hidden buffers & jump to the 1st one.
let g:ctrlp_open_multiple_files = 'rij'
" Open new file in the current window.
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_prompt_mappings = {
			\ 'ToggleType(1)':		  ['<c-f>'],
			\ 'ToggleType(-1)':		  ['<c-b>'],
			\ 'MarkToOpen()':		  ['<c-z>'],
			\ 'OpenMulti()':		  ['<c-o>'],
			\ 'CreateNewFile()':	  ['<c-y>'],
			\ 'PrtHistory(-1)':		  ['<c-j>'],
			\ 'PrtHistory(1)':		  ['<c-k>'],
			\ 'PrtSelectMove("j")':   ['<c-n>'],
			\ 'PrtSelectMove("k")':   ['<c-p>']
			\ }
" MRU mode
let g:ctrlp_mruf_save_on_update = 1
" Use ag in CtrlP for listing files.
" P.S: Remove option -U make ag respect .gitignore.
if executable('ag')
	let g:ctrlp_user_command =
				\ 'ag %s -U -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif
" (( cmd-palette ))
let g:ctrlp_cmdpalette_execute = 1
" ******* (( vim-plug )) {{{1
command! PI :PlugInstall
command! PU :PlugUpdate
command! PS :PlugStatus
command! PC :PlugClean
let g:plug_threads = g:hasWin ? 5 : 10
" ******* (( clever-f )) {{{1
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
" Fix a direction of search (f & F)
let g:clever_f_fix_key_direction = 1
" ******* (( vim-markdown )) {{{1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Disable folding.
let g:vim_markdown_folding_disabled=1
" Disable default mappings.
let g:vim_markdown_no_default_key_mappings=1
" ******* (( neocomplete )) {{{1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#data_directory = expand(g:vimDir).'/various/neocomplete'
inoremap <expr><C-space>  neocomplete#start_manual_complete('omni')
" inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Up>"
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php =
			\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
" For (( jedi-vim ))
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python =
			\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" ******* (( autoformat )) {{{1
let g:formatprg_html = "html-beautify"
let g:formatprg_args_expr_html = '"--indent-size 2 --indent-inner-html true  --preserve-newlines -f - "'
" ******* (( colorizer )) {{{1
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" ******* (( php-documentor )) {{{1
nnoremap <silent> <C-p> :call PhpDoc()<CR>
inoremap <silent> <C-p> <C-o>:call PhpDoc()<CR>
vnoremap <silent> <C-p> :call PhpDocRange()<CR>
let g:pdv_cfg_ClassTags = []
" ******* (( vim-devicons )) {{{1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
" ******* (( vim-peekaboo )) {{{1
let g:peekaboo_compact = 1
" ******* (( GoldenView )) {{{1
let g:goldenview__enable_at_startup = 0
let g:goldenview__enable_default_mapping = 0
" ******* (( tabular )) {{{1
vmap <CR> :Tabular /
" ******* (( vimgitlog )) {{{1
command! GitLog :call GITLOG_ToggleWindows()
" ******* (( fugitive )) {{{1
" some abbreviations
cab Gb Git branch
cab Gch Git checkout
cab Gco Gcommit
cab Gl Git log
cab Gm Gmerge
cab Gs Gstatus
" ******* (( vim-signature )) {{{1
let g:SignatureMap = {
			\ 'ListLocalMarks'	 :	",m",
			\ }
" ******* (( javacomplete )) {{{1
if has("autocmd")
	autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
endif
" ******* (( vim-json )) {{{1
let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 0
" ******* (( zeavim )) {{{1
nmap gz <Plug>Zeavim
vmap gz <Plug>ZVVisSelection
nmap gZ <Plug>ZVKeyDocset
let g:zv_disable_mapping = 1
let g:zv_docsets_dir = '~/Important!/docsets_Zeal/'
" ******* (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
" ******* (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
" ******* (( vsl )) {{{1
" *** ;t				=> Open terminal in pwd
" *** ;;t				=> Open terminal in dir of current file
" *** ;f				=> Open file manager in pwd
" *** ;;f				=> Open file manager in dir of current file
nmap <silent> ;t :call vsl#general#lib#OpenTerm()<CR>
nmap <silent> ;;f :call vsl#general#lib#OpenFM(expand('%:h:p'))<cr>
nmap <silent> ;f :call vsl#general#lib#OpenFM()<cr>
nmap <silent> ;;t :call vsl#general#lib#openterm(expand('%:h:p'))<cr>
" ******* (( lazyList )) {{{1
nnoremap gli :LazyList 
vnoremap gli :LazyList 
let g:lazylist_maps = [
			\ 'gl',
			\ {
				\ 'l'  : '',
				\ '*'  : '* ',
				\ '-'   : '- ',
				\ 't'   : '- [ ] ',
				\ '2'  : '%2%. ',
				\ '3'  : '%3%. ',
				\ '4'  : '%4%. ',
				\ '5'  : '%5%. ',
				\ '6'  : '%6%. ',
				\ '7'  : '%7%. ',
				\ '8'  : '%8%. ',
				\ '9'  : '%9%. ',
				\ '.1' : '1.%1%. ',
				\ '.2' : '2.%1%. ',
				\ '.3' : '3.%1%. ',
				\ '.4' : '4.%1%. ',
				\ '.5' : '5.%1%. ',
				\ '.6' : '6.%1%. ',
				\ '.7' : '7.%1%. ',
				\ '.8' : '8.%1%. ',
				\ '.9' : '9.%1%. ',
			\ }
		\]
" }}}

" =========== HACKS =======================
" Disable (( neocomplete )) before (( multiple-cursors )) to avoid conflict {{{1
function! Multiple_cursors_before()
	exe 'NeoCompleteLock'
endfunction
" Enable autocompletion again.
function! Multiple_cursors_after()
	exe 'NeoCompleteUnlock'
endfunction
" Refresh (( airline )), useful when vim config files are sourced
if exists(':AirlineRefresh') ==# 2
	:AirlineRefresh
endif
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
