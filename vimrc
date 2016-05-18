" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-05-18
" ================================================================

" Useful variables  {{{1
let g:hasUnix = has('unix')
let g:hasWin = has('win32')
let g:isNvim = has('nvim')
let g:hasGui = has('gui_running')
" 1}}}

" Stock the Location of vim's folder in a global variable {{{1
let g:vimDir = g:hasWin ? substitute(expand('$HOME/vimfiles'), '\', '/', 'g') : expand('$HOME/.vim')
let g:dotFiles = expand('$HOME/.dotfiles')
" 1}}}

" Commands for quick access to my config files {{{1
" > Vim files
command! Ev :e! $MYVIMRC
for s:f in ['/config/minimal', '/config/plugins', '/config/tabline', '/config/statusline', '/autoload/helpers']
	let s:m = 'Ev' . fnamemodify(s:f, ':t:h')[0]
	silent execute 'command! ' . s:m . '  :e! ' . g:vimDir . s:f . '.vim'
endfor
unlet! s:f s:m
" > Bash
execute 'command! Eb   :e! ' . g:dotFiles . '/bash/bashrc'
execute 'command! Eba  :e! ' . g:dotFiles . '/bash/bash_aliases'
execute 'command! Ebf  :e! ' . g:dotFiles . '/bash/bash_functions'
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
for s:f in ['minimal', 'plugins', 'tabline', 'statusline']
	execute 'source ' . g:vimDir . '/config/' . s:f . '.vim'
endfor
unlet! s:f
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
