" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2015-05-16
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
			\'lowly',
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
Plug 'lilydjwg/colorizer'      , {'for': ['html', 'css', 'scss', 'php', 'xml', 'vim']}
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'        , {'for': ['html', 'php', 'xml']}
Plug 'plasticboy/vim-markdown' , {'for': ['md', 'markdown']}
Plug 'shime/vim-livedown'      , {'on':  ['LivedownPreview', 'LivedownKill']}
Plug 'tpope/vim-haml'          , {'for': ['sass', 'scss', 'haml']}
" For JavaScript {{{2
Plug 'leshill/vim-json'        , { 'for': 'json' }
Plug 'marijnh/tern_for_vim'    , {'do': 'npm install', 'for': 'javascript'}
Plug 'pangloss/vim-javascript' , { 'for': 'javascript' }
" For Python {{{2
Plug 'hdima/python-syntax' , { 'for': 'python' }
" For Java {{{2
Plug 'javacomplete' , { 'for': 'java' }
" For Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'PAntoine/vimgitlog'
Plug 'tpope/vim-fugitive'
" (( fuzzyfinder )) {{{2
Plug 'FuzzyFinder'
Plug 'L9'
" (( ultisnips )) {{{2
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" (( airline )) {{{2
Plug 'bling/vim-airline'
" (( nerdtree )) {{{2
Plug 'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' }
" (( ctrlp )) {{{2
Plug 'ctrlpvim/ctrlp.vim'		" A fork of CtrlP , more active repo.
Plug 'fisadev/vim-ctrlp-cmdpalette' , { 'on': 'CtrlPCmdPalette' }
Plug 'tacahiroy/ctrlp-funky'        , { 'on': 'CtrlPFunky' }
" (( syntastic )) & linters {{{2
Plug 'scrooloose/syntastic'
" (( tagbar )) {{{2
Plug 'majutsushi/tagbar' , { 'on': 'TagbarToggle' }
call s:PlugInOs('vim-scripts/tagbar-phpctags', "{'do': 'chmod +x bin/phpctags', 'for': 'php'}", 'unix')
" Various {{{2
call s:PlugInOs('ryanoasis/vim-webdevicons' , '', 'unix')
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Chiel92/vim-autoformat'         , { 'on': 'AutoFormat' }
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-peekaboo'
Plug 'kshenoy/vim-signature'
Plug 'matchit.zip'
Plug 'matze/vim-move'
Plug 'mbbill/undotree'                , { 'on': 'UndotreeToggle' }
Plug 'Raimondi/delimitMate'
Plug 'rhysd/clever-f.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'sk1418/Join'                    , { 'on': 'Join' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rvm'                  , { 'on': 'Rvm' }
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
" Colorschemes {{{2
Plug 'ajh17/Spacegray.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme' , { 'rtp': 'vim' }
Plug 'mgutz/gosu-colors'
Plug 'nanotech/jellybeans.vim'
Plug 'noahfrederick/vim-hemisu'
Plug 'reedes/vim-colors-pencil'
Plug 'sjl/badwolf'
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
" (( php-documentor )) {{{1
nnoremap <silent> <C-p> :call PhpDoc()<CR>
inoremap <silent> <C-p> <C-o>:call PhpDoc()<CR>
vnoremap <silent> <C-p> :call PhpDocRange()<CR>
" (( vim-signature )) {{{1
let g:SignatureMap = {
			\ 'ListLocalMarks'	 :	",m",
			\ }
" (( CtrlP )) & extensions {{{1
nmap <silent> !!   :CtrlPCmdPalette<CR>
nmap <silent> ,,f  :CtrlP<CR>
nmap <silent> ,F   :CtrlPFunky<CR>
nmap <silent> ,l   :CtrlPLine %<CR>
nmap <silent> ,r   :CtrlPMRUFiles<CR>
nmap <silent> ,t   :CtrlPBufTag<CR>
" narrow the list down with a word under cursor
nnoremap <leader>f :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" (( FuzzyFinder )) {{{1
nmap <silent> ,b :FufBookmarkDir<CR>
nmap <silent> ,c :FufMruCmd<CR>
nmap <silent> ,d :FufDir<CR>
nmap <silent> ,f :FufFile<CR>
nmap <silent> <C-space> :FufBuffer<CR>
" (( ultisnips )) {{{1
nmap <C-F2> :UltiSnipsEdit<CR>
" (( NERDTree ))  {{{1
nmap <silent> ,N :NERDTreeToggle<CR>
" (( tagbar )) {{{1
nnoremap <silent> ,T :TagbarToggle<CR>
" (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
" (( tComment )) {{{1
" *** \cc			=> Comment or uncomment a line.
" *** \c{motion}	=> Comment or uncomment a specified motion.
nmap <silent> <leader>cc <c-_><c-_>
vmap <silent> <leader>cc <c-_><c-_>
nmap <silent> <leader>c gc
" (( syntastic )) {{{1
" *** <F8>		=> SyntasticCheck
" *** <c-F8>	=> SyntasticReset
" *** ,E		=> Display an errors window.
map <silent> <F8> :SyntasticCheck<CR>
map <silent> <c-F8> :SyntasticReset<CR>
map <silent> ,E :Errors<CR>
" Operations on current buffer (Move between errors in (( syntastic )) ) {{{1
" *** <c-F3>	=> lprevious.
" *** <c-F4>	=> lnext.
nmap <silent> <c-F3> :lprevious<CR>
nmap <silent> <c-F4> :lnext<CR>
" (( splitjoin )) {{{1
" Disable the default mapping.
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" *** \s				=> Split code.
" *** \j				=> Join code.
nmap <silent> <Leader>j :SplitjoinJoin<CR>
nmap <silent> <Leader>s :SplitjoinSplit<CR>
" (( move )) {{{1
" Disable default mapping.
let g:move_map_keys = 0
vmap <A-up> <Plug>MoveBlockUp
vmap <A-down> <Plug>MoveBlockDown
nmap <A-up> <Plug>MoveLineUp
nmap <A-down> <Plug>MoveLineDown
" (( vsl )) {{{1
" *** ;t				=> Open terminal in pwd
" *** ;;t				=> Open terminal in dir of current file
" *** ;f				=> Open file manager in pwd
" *** ;;f				=> Open file manager in dir of current file
nmap <silent> ;t :call vsl#general#lib#OpenTerm()<CR>
nmap <silent> ;;t :call vsl#general#lib#OpenTerm(expand('%:h:p'))<CR>
nmap <silent> ;f :call vsl#general#lib#OpenFM()<CR>
nmap <silent> ;;f :call vsl#general#lib#OpenFM(expand('%:h:p'))<CR>
" }}}

" =========== (AUTO)COMMANDS ==========================================
" Short commands for (( vim-plug )) {{{1
command! PI :PlugInstall
command! PU :PlugUpdate
command! PS :PlugStatus
command! PC :PlugClean
" (( gitgutter )) {{{1
" *** :GG	=> Toggle GitGutter.
" *** :Gn	=> Next diff.
" *** :Gp	=> Previous diff.
command! GG :GitGutterToggle
command! Gn :GitGutterNextHunk
command! Gp :GitGutterPrevHunk
" (( vimgitlog )) {{{1
command! GitLog :call GITLOG_ToggleWindows()
" Set md files as a markdown files {{{1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" }}}

" =========== OMNIFUNC ==============================
" For (( javacomplete )) {{{1
if has("autocmd")
	autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
endif
" }}}

" =========== PLUGINS OPTIONS =======================
" ******* (( FuzzyFinder )) {{{1
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
" ******* (( python-syntax )) {{{1
let python_highlight_all=1
" ******* (( tagbar )) & (( tagbar-phpctags )) {{{1
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
" ******* (( airline )) {{{1
let g:airline_theme = 'yowish'
if has("gui_running") || exists("$TMUX")
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	" Automatically populate the symbols dictionary with the powerline symbols.
	let g:airline_powerline_fonts = 1
	" Extensions.
	let g:airline#extensions#tagbar#enabled = 0
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
			\ "mode": "active",
			\ "active_filetypes": ["php", "html", "c", "java", "python", "html", "javascript", "css", "sh", "json"],
			\ "passive_filetypes": ["vim", "sass", "scss", "ruby"]
			\ }
" ******* (( emmet )) {{{1
" In INSERT & VISUAL modes only.
let g:user_emmet_mode='iv'
" Enable emmet for specific files.
let g:user_emmet_install_global = 0
autocmd FileType html,scss,css,php EmmetInstall
let g:user_emmet_leader_key = '<c-e>'
" ******* (( undotree )) {{{1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" ******* (( delimitmate )) {{{1
let delimitMate_matchpairs = "(:),[:],{:}"
" ******* (( vim-javascript )) {{{1
let javascript_enable_domhtmlcss = 1
" ******* (( ultisnips )) {{{1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsEditSplit="vertical"
" Personal snippets folder.
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" ******* (( gitgutter )) {{{1
if g:hasWin | let g:gitgutter_enabled = 0 | endif
" ******* (( ctrlp & cie )) {{{1
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
			\ 'PrtHistory(-1)':		  ['<c-down>'],
			\ 'PrtHistory(1)':		  ['<c-up>'],
			\ 'ToggleType(1)':		  ['<s-right>'],
			\ 'ToggleType(-1)':		  ['<s-left>'],
			\ 'CreateNewFile()':	  ['<c-n>'],
			\ 'MarkToOpen()':		  ['<c-z>'],
			\ 'OpenMulti()':		  ['<c-o>'],
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
let g:plug_threads = g:hasWin ? 5 : 10
" ******* (( clever-f )) {{{1
let g:clever_f_across_no_line = 1
" let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1
" Fix a direction of search (f & F)
let g:clever_f_fix_key_direction = 1
" ******* (( vim-markdown )) {{{1
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
inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
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
" ******* (( autoformat )) {{{1
let g:formatprg_html = "html-beautify"
let g:formatprg_args_expr_html = '"--indent-size 2 --indent-inner-html true  --preserve-newlines -f - "'
" ******* (( colorizer )) {{{1
let g:colorizer_nomap = 1
let g:colorizer_startup = 0
" ******* (( php-documentor )) {{{1
let g:pdv_cfg_ClassTags = []
" ******* (( vim-webdevicons )) {{{1
let g:webdevicons_enable_nerdtree = 0
" ******* (( zeavim )) {{{1
let g:zv_docsets_dir = '~/Important!/docsets_Zeal/'
" ******* (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
" ******* (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
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
