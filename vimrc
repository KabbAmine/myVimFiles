" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-07-24
" ================================================================

" Useful variables  {{{1
let g:hasUnix = has('unix')
let g:hasWin = has('win32')
let g:isNvim = has('nvim')
let g:hasGui = has('gui_running')
let g:hasJob = has('job')
" 1}}}

" Stock the Location of vim's folder in a global variable {{{1
let g:vimDir = g:hasWin ? substitute(expand('$HOME/vimfiles'), '\', '/', 'g') : expand('$HOME/.vim')
let g:dotFiles = expand('$HOME/.dotfiles')
" 1}}}

" Commands for quick access to my config files {{{1
" > Vim files
command! Ev :e! $MYVIMRC
call helpers#ExecFor(
			\	'e!', 'Ev', g:vimDir,
			\	[
			\		'/config/minimal.vim',
			\		'/config/plugins.vim',
			\		'/config/tabline.vim',
			\		'/config/statusline.vim',
			\		'/autoload/helpers.vim'
			\	],
			\ )
" > Bash
execute 'command! Eb :e! ' . g:dotFiles . '/bash/bashrc'
call helpers#ExecFor(
			\	'e!', 'Eb',
			\	g:dotFiles . '/bash/bash_',
			\	['aliases', 'functions'],
			\ )
" > Tmux
execute 'command! Et   :e! ' . g:dotFiles . '/tmux/tmux.conf'
" 1}}}

" Automatically source vimrc & vim config files on save  {{{1
augroup Resource
	autocmd!
	execute 'autocmd BufWritePost ' . expand($MYVIMRC) . ' source ' . expand($MYVIMRC)
	execute 'autocmd BufWritePost ' . expand(g:vimDir) . '/config/* source $MYVIMRC'
augroup END
" 1}}}

" Source files {{{1
call helpers#ExecFor(
			\	'source ', '',
			\	g:vimDir . '/config/',
			\	['minimal.vim', 'plugins.vim', 'tabline.vim', 'statusline.vim'],
			\ )
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
