" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2014-12-07
" ================================================================


" Personal vim plugins directory.
" {
    if g:hasWin
        let s:myPlugins = "Z:\\k-bag\\Projects\\pluginsVim\\"
    else
        let s:myPlugins = "$HOME/Projects/pluginsVim/"
    endif
" }
" Useful variables & functions
" {
    function! s:PlugInOs(link, param, os)
        if has(a:os)
            if !empty(a:param)
                execute "Plug '".a:link."', ".a:param.""
            else
                execute "Plug '".a:link."'"
            endif
        endif
    endfunction
" }

" ========== VIM-PLUG ==============================================
if g:hasWin
    call plug#begin($HOME.'/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

" Plugins:
" {
    " For PHP
        Plug '2072/PHP-Indenting-for-VIm'
        Plug 'StanAngeloff/php.vim'
        Plug 'shawncplus/phpcomplete.vim'
    " For HTML/CSS & markdown
        Plug 'docunext/closetag.vim'
        Plug 'lilydjwg/colorizer', { 'for': ['css', 'scss', 'html', 'php'] }
        Plug 'mattn/emmet-vim'
        Plug 'othree/html5.vim'
        Plug 'plasticboy/vim-markdown'
        Plug 'shime/vim-livedown'
        Plug 'tpope/vim-haml'
    " For JavaScript
        Plug 'pangloss/vim-javascript'
    " For Python
        Plug 'hdima/python-syntax'
    " For Java
        Plug 'javacomplete'
    " For Git
        Plug 'airblade/vim-gitgutter'
        Plug 'tpope/vim-fugitive'
    " (( fuzzyfinder ))
        Plug 'L9'
        Plug 'FuzzyFinder'
    " (( ultisnips ))
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
    " (( airline ))
        Plug 'bling/vim-airline'
    " (( nerdtree ))
        Plug 'scrooloose/nerdtree'
    " (( ctrlp ))
        Plug 'ctrlpvim/ctrlp.vim'       " A fork of CtrlP, more active repo.
        Plug 'fisadev/vim-ctrlp-cmdpalette'
        Plug 'mattn/ctrlp-register'
        Plug 'tacahiroy/ctrlp-funky'
    " (( syntastic )) & linters
        Plug 'scrooloose/syntastic'
        Plug 'syngan/vim-vimlint', {'for': 'vim'}
        Plug 'ynkdir/vim-vimlparser', {'for': 'vim'}
    " Various
        Plug 'AndrewRadev/splitjoin.vim'
        Plug 'kyuhi/vim-emoji-complete'
        Plug 'Lokaltog/vim-easymotion'
        Plug 'Raimondi/delimitMate'
        Plug 'godlygeek/tabular'
        Plug 'kshenoy/vim-signature'
        Plug 'majutsushi/tagbar'
        Plug 'matchit.zip'
        Plug 'matze/vim-move'
        Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
        Plug 'rhysd/clever-f.vim'
        Plug 'sk1418/Join'
        Plug 'terryma/vim-multiple-cursors'
        Plug 'tommcdo/vim-exchange'
        Plug 'tomtom/tcomment_vim'
        Plug 'tpope/vim-surround'
        call s:PlugInOs('Valloric/YouCompleteMe', '', 'unix')
    " Colorschemes
        Plug 'altercation/vim-colors-solarized'
        Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
        Plug 'gosukiwi/vim-atom-dark'
        Plug 'jnurmine/Zenburn'
        Plug 'mgutz/gosu-colors'
        Plug 'nanotech/jellybeans.vim'
        Plug 'noahfrederick/vim-hemisu'
        Plug 'reedes/vim-colors-pencil'
        Plug 'sjl/badwolf'
    " My Plugins
        execute "Plug '".s:myPlugins."termivator' "
        execute "Plug '".s:myPlugins."vCoolor' "
        execute "Plug '".s:myPlugins."vullScreen' "
        execute "Plug '".s:myPlugins."zeavim' "
 " }

call plug#end()


" ========== VARIOUS  ===========================================
" Themes.
" {
    if g:hasWin
        colorscheme Tomorrow-Night-Eighties
    elseif has("gui_running") || exists("$TMUX")
        colorscheme Tomorrow-Night-Eighties
    elseif exists("$TERM") && ($TERM =~ "^xterm")
        set term=xterm-256color     " Force using 256 colors.
        colorscheme Tomorrow-Night-Eighties
    endif
" }


" =========== MAPPING ==========================================
" (( vim-signature )) *******
" {
      let g:SignatureMap = {
              \ 'ListLocalMarks'     :  ",m",
              \ }
" }

" (( termivator )) shortcuts *******
" {
    " *** ;t    => Terminal.
    " *** ;f    => File manager.
    " *** ;g    => Gitg.
    " *** ;h    => Haroopad
        nmap <silent> ;t :Tt<CR>
        nmap <silent> ;f :Tf<CR>
        nmap <silent> ;g :Tg<CR>
        nmap <silent> ;h :Th<CR>
" }

" (( CtrlP )) & extensions shortcuts *******
" {
        nmap <silent> ,,f  :CtrlP<CR>
        nmap <silent> ,F   :CtrlPFunky<CR>
        nmap <silent> ,t   :CtrlPBufTag<CR>
        nmap <silent> ,l   :CtrlPLine %<CR>
        nmap <silent> ,y   :CtrlPRegister<CR>
        nmap <silent> !!   :CtrlPCmdPalette<CR>
" }

" (( FuzzyFinder )) shortcuts *******
" {
        nmap <silent> <C-space> :FufBuffer<CR>
        nmap <silent> ,r :FufMruFile<CR>
        nmap <silent> ,d :FufDir<CR>
        nmap <silent> ,c :FufMruCmd<CR>
        nmap <silent> ,f :FufFile<CR>
        nmap <silent> ,b :FufBookmarkDir<CR>
" }

" (( ultisnips )) *******
" {
    " <C-F2>        => Open the custom snippet file of the current file.
        nmap <C-F2> :UltiSnipsEdit<CR>
" }

" (( NERDTree )) shortcut *******
" {
    " *** ,N        => Toggle NERDTree.
        nmap <silent> ,N :NERDTreeToggle<CR>
" }

" (( tagbar )) shortcut *******
" {
    " *** ,T        => TagbarToggle
        nnoremap <silent> ,T :TagbarToggle<CR>
" }

" (( undotree )) shortcut *******
" {
    " *** ,U        => UndotreeToggle
        nnoremap <silent> ,U :UndotreeToggle<CR>
" }

" (( tComment )) shortcut *******
" {
    " *** \cc           => Comment or uncomment a line.
    " *** \c{motion}    => Comment or uncomment a specified motion.
        nmap <silent> <leader>cc <c-_><c-_>
        vmap <silent> <leader>cc <c-_><c-_>
        nmap <silent> <leader>c gc
" }

" (( syntastic )) shortcuts *******
" {
    " *** <F8>      => SyntasticCheck
    " *** <c-F8>    => SyntasticReset
    " *** ,E        => Display an errors window.
        map <silent> <F8> :SyntasticCheck<CR>
        map <silent> <c-F8> :SyntasticReset<CR>
        map <silent> ,E :Errors<CR>
" }

" Operations on current buffer (Move between errors in
" (( syntastic )) *******
" {
    " *** <c-F3>    => lprevious.
    " *** <c-F4>    => lnext.
        nmap <silent> <c-F3> :lprevious<CR>
        nmap <silent> <c-F4> :lnext<CR>
" }

" (( easymotion )) shortcuts *******
" {
    " *** ù             => Leader key of easymotion.
    " *** ù<Down>       => j motion.
    " *** ù<Up>         => k motion.
    " *** ù<Right>      => w motion.
    " *** ù<Left>       => b motion.
    " *** ùù            => Anywhere in the same line.
    " *** ùf            => Search for a character in both directions (f equivalent).
        " Disable default mappings
            let g:EasyMotion_do_mapping = 0
        map <silent> ù        <Plug>(easymotion-prefix)
        map <silent> ù<Down>  <Plug>(easymotion-sol-j)
        map <silent> ù<Up>    <Plug>(easymotion-sol-k)
        map <silent> ù<Right> <Plug>(easymotion-iskeyword-w)
        map <silent> ù<Left>  <Plug>(easymotion-iskeyword-b)
        map <silent> ùù       <Plug>(easymotion-lineanywhere)
        map <silent> ùf       <Plug>(easymotion-bd-f)
" }

" (( splitjoin )) mappings *******
" {
    " *** \s                => Split code.
    " *** \j                => Join code.
        " Disable the default mapping.
            let g:splitjoin_split_mapping = ''
            let g:splitjoin_join_mapping = ''
        nmap <silent> <Leader>j :SplitjoinJoin<CR>
        nmap <silent> <Leader>s :SplitjoinSplit<CR>
" }

" (( move )) *******
" {
    " Disable default mapping.
        let g:move_map_keys = 0
    vmap <A-up> <Plug>MoveBlockUp
    vmap <A-down> <Plug>MoveBlockDown
    nmap <A-up> <Plug>MoveLineUp
    nmap <A-down> <Plug>MoveLineDown
" }

" Short commands for (( vim-plug ))
" {
    " *** :PI           => Install new plugins.
    " *** :PU           => Update all plugins.
    " *** :PS           => Show plugin status.
    " *** :PC           => Clean the plugin directories.
        command! PI :PlugInstall
        command! PU :PlugUpdate
        command! PS :PlugStatus
        command! PC :PlugClean
" }
" Toggle (( gitgutter )) *******

" {
    " *** :GG   => Toggle GitGutter.
    " *** :Gn   => Next diff.
    " *** :Gp   => Previous diff.
        command! GG :GitGutterToggle
        command! Gn :GitGutterNextHunk
        command! Gp :GitGutterPrevHunk
" }


" =========== OMNIFUNC ==============================
" For (( javacomplete ))
" {
    if has("autocmd")
        autocmd! Filetype java setlocal omnifunc=javacomplete#Complete
    endif
" }


" =========== PLUGINS OPTIONS =======================
" ******* (( FuzzyFinder )) *******
" {
        let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|\.(png|jpg|jpeg|gif|xcf|svg)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|\.(cbp|depend)$'
    " Enable all the modes (MRU mode was disabled).
        let g:fuf_modesDisable = []
    let g:fuf_mrufile_maxItem = 40
    " Separator for a primary and refining patterns.
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
" }

" ******* (( NERDTree )) *******
" {
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
    let NERDTreeDirArrows=1
" }

" " ******* (( python-syntax )) *******
    let python_highlight_all=1

" ******* (( tagbar )) *******
" {
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
" }

" ******* (( airline )) *******
" {
    if has("gui_running") || exists("$TMUX")
        let g:airline_theme = 'jellybeans'
        " Customization.
        if !exists('g:airline_symbols')
            let g:airline_symbols = {}
        endif
        " Automatically populate the symbols dictionary with the powerline symbols.
        let g:airline_powerline_fonts = 1
        " Tabline.
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#show_buffers = 1
        " Configure the minimum number of buffers needed to show the tabline.
        let g:airline#extensions#tabline#buffer_min_count = 2
        " Configure the minimum number of tabs needed to show the tabline.
        let g:airline#extensions#tabline#tab_min_count = 2
    endif
" }

" ******* (( syntastic )) *******
" {
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_html_checkers = ['w3']
    let g:syntastic_javascript_checkers = ['jslint']
    let g:syntastic_mode_map = { "mode": "passive",
                \ "active_filetypes": [],
                \ "passive_filetypes": ["c", "java", "php", "python", "sh", "tex", "javascript", "html", "xhtml", "css", "sass", "scss"]
                \ }
" }

" ******* (( emmet )) *******
" {
    " Only in INSERT mode.
        let g:user_emmet_mode='iv'
    " Enable emmet for specific files.
        let g:user_emmet_install_global = 0
        autocmd FileType html,scss,css,php EmmetInstall
    let g:user_emmet_leader_key = '<c-e>'
" }

" ******* (( undotree )) *******
" {
    let g:undotree_SetFocusWhenToggle = 1
    let g:undotree_WindowLayout = 'botright'
    " Automatically remove a buffer when his file is being deleted/renamed via the menu.
        let NERDTreeAutoDeleteBuffer=1
    " Case sensitive sorting.
        let NERDTreeCaseSensitiveSort=1
" }

" ******* (( delimitmate )) *******
" {
    let delimitMate_matchpairs = "(:),[:],{:}"
" }

" ******* (( vim-javascript )) *******
" {
    let javascript_enable_domhtmlcss = 1
" }

" ******* (( easymotion )) *******
" {
    " Keep cursor in the same column for JK motions
        let g:EasyMotion_startofline = 0
    " Matching target keys by smartcase.
        let g:EasyMotion_smartcase = 1
    let g:EasyMotion_use_upper = 1
    let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" }

" ******* (( ultisnips )) *******
" {
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
    " :UltiSnipsEdit splits the window.
        let g:UltiSnipsEditSplit="vertical"
    " Define directory for my personal snippets.
        let g:UltiSnipsSnippetDirectories=["UltiSnips"]
" }

" ******* (( youcompleteme )) *******
" {
    let g:ycm_show_diagnostics_ui = 0       " To get (( syntastic )) working
    let g:ycm_complete_in_comments = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_key_list_select_completion = ['<Down>']
    let g:ycm_key_list_previous_completion = ['<Up>']
    let g:ycm_filetype_specific_completion_to_disable = {'vim': 1}
" }

" ******* (( gitgutter )) *******
" {
    let g:gitgutter_enabled = 0
" }

" ******* (( ctrlp & cie )) *******
" {
	" Disable CtrlP default map.
		let g:ctrlp_map = ''
    let g:ctrlp_cache_dir = g:vimDir.'/various/ctrlp'
    let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30'
    let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_max_files = 0
    let g:ctrlp_max_depth = 40
    let g:ctrlp_follow_symlinks = 0
    let g:ctrlp_lazy_update = 1
    " Open multiple files in hidden buffers & jump to the 1st one.
        let g:ctrlp_open_multiple_files = 'ij'
    " Open new file in the current window.
        let g:ctrlp_open_new_file = 'r'
    " " Make available extensions.
        let g:ctrlp_extensions = ['funky']
	" CtrlP (( cmd-palette ))
		let g:ctrlp_cmdpalette_execute = 1
" }

" ******* (( vim-plug )) *******
" {
    if has('win32') || has('win64')
        let g:plug_threads = 1
    else
        let g:plug_threads = 10
    endif
" }

" ******* (( clever-f )) *******
" {
    let g:clever_f_across_no_line = 1
    let g:clever_f_ignore_case = 1
    let g:clever_f_smart_case = 1
    " Fix a direction of search (f & F)
    let g:clever_f_fix_key_direction = 1
" }

" ******* (( zeavim )) *******
" {
	let g:zv_lazy_docset_list = [ 'Compass', 'Bootstrap', 'Vagrant', 'Font Awesome' ]
    " let g:ZV_zeal_directory = ""
    " let g:ZV_disable_mapping = 1
    " let g:ZV_added_files_type = {
    "           \ 'extension': 'docset',
    "           \}
" }

" ******* (( vcoolor )) *******
" {
    let g:vcoolor_lowercase = 1
    " let g:vcoolor_map = {
    "           \ 'h': ';c',
    "           \ 'r': ';r',
    "           \ 'v': ';v'
    "           \ }
" }

" ******* (( termivator )) *******
" {
    let g:T_list_comm = {
                \ "cmder": {
                    \ "w": "start \"C:\\Program Files\\cmder\\Cmder.exe\" /START" }
                \ }
" }

" ******* (( PHP-Indenting-for-VIm )) *******
" {
  " Set a tab after <?php line.
    " let g:PHP_default_indenting = 1
" }

" ******* (( vim-markdown )) *******
" {
    " Disable folding.
        let g:vim_markdown_folding_disabled=1
    " Disable default mappings.
        let g:vim_markdown_no_default_key_mappings=1
" }
