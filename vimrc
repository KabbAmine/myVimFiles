" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-04-16
" ================================================================


" Useful variables  {{{1
let g:hasUnix = has('unix')
let g:hasWin = has('win32')
let g:isNvim = has('nvim')
let g:hasGui = has('gui_running')
" Stock the Location of vim's folder in a global variable.
let g:vimDir = g:hasWin ? substitute(expand('$HOME/vimfiles'), '\', '/', 'g') : expand('$HOME/.vim')
let g:dotFiles = expand('$HOME/.dotfiles')
" }}}

" Open personal config files for editing {{{1
command! Ev :e! $MYVIMRC
execute 'command! Evm  :e! ' . g:vimDir . '/config/minimal.vim'
execute 'command! Evp  :e! ' . g:vimDir . '/config/plugins.vim'
execute 'command! Evt  :e! ' . g:vimDir . '/config/tabline.vim'
execute 'command! Evs  :e! ' . g:vimDir . '/config/statusline.vim'
execute 'command! Evh  :e! ' . g:vimDir . '/autoload/helpers.vim'
" Bash
execute 'command! Eb   :e! ' . g:dotFiles . '/bash/bashrc'
execute 'command! Eba  :e! ' . g:dotFiles . '/bash/bash_aliases'
execute 'command! Ebf  :e! ' . g:dotFiles . '/bash/bash_functions'
" Tmux
execute 'command! Et   :e! ' . g:dotFiles . '/tmux/tmux.conf'
" Automatically source vimrc & vim config files on save  {{{1
augroup resource
	autocmd!
	autocmd bufwritepost $MYVIMRC source $MYVIMRC
	execute 'autocmd bufwritepost ' . expand(g:vimDir) . '/config/* source $MYVIMRC'
augroup END
" Source files {{{1
execute 'source ' . g:vimDir . '/config/minimal.vim'
execute 'source ' . g:vimDir . '/config/plugins.vim'
execute 'source ' . g:vimDir . '/config/tabline.vim'
execute 'source ' . g:vimDir . '/config/statusline.vim'
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
