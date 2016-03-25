" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-03-26
" ================================================================


" Useful variables  {{{1
let g:hasUnix = has('unix')
let g:hasWin = has('win32')
let g:isNvim = has('nvim')
" Stock the Location of vim's folder in a global variable.
let g:vimDir = g:hasWin ? substitute(expand('$HOME/vimfiles'), '\', '/', 'g') : expand('$HOME/.vim')
" }}}

" Open personal config files for editing {{{1
" *** :Ev		=> ~/.vimrc
" *** :Evm		=> ~/.config/minimal.vim
" *** :Evp		=> ~/.config/plugins.vim
" *** :Eb		=> ~/.dotfiles/bash/bashrc
" *** :Eba		=> ~/.dotfiles/bash/bash_aliases
" *** :Ebf		=> ~/.dotfiles/bash/bash_functions
" *** :Et		=> ~/.dotfiles/tmux/.tmux.conf
command! Ev :e! $MYVIMRC
execute 'command! Evm :e! ' . g:vimDir . '/config/minimal.vim'
execute 'command! Evp :e! ' . g:vimDir . '/config/plugins.vim'
command! Eb :e! $HOME/.dotfiles/bash/bashrc
command! Eba :e! $HOME/.dotfiles/bash/bash_aliases
command! Ebf :e! $HOME/.dotfiles/bash/bash_functions
command! Et :e! $HOME/.dotfiles/tmux/tmux.conf
" Automatically source vimrc & vim config files on save  {{{1
augroup resource
	autocmd!
	autocmd bufwritepost $MYVIMRC source $MYVIMRC
	execute 'autocmd bufwritepost ' . expand(g:vimDir) . '/config/* source $MYVIMRC'
augroup END
" Source external files {{{1
" Minimal vimrc.
execute 'source ' . g:vimDir . '/config/minimal.vim'
" Plugins files.
execute 'source ' . g:vimDir . '/config/plugins.vim'
" Custom statusline (Need the plugins file above)
execute 'source ' . g:vimDir . '/config/statusline.vim'
" }}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
