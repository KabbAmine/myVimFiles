" ========== Main vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-08-19
" ================================================================


" Useful checks {{{1
let g:hasUnix = has('unix')
let g:hasWin = has('win32')
let g:hasGui = has('gui_running')
let g:hasJob = has('job')
" 1}}}

" Vim & dotfiles directories {{{1
let g:vimDir = g:hasWin ?
			\	substitute(expand('$HOME/vimfiles'), '\', '/', 'g') :
			\	expand('$HOME/.vim')
let s:vimCfgFiles = ['minimal', 'plugins', 'tabline', 'statusline']
let g:dotFiles = expand('$HOME/.dotfiles')
" 1}}}

" Commands for quick access to config files {{{1
" >>> Vim {{{2
command! Ev :e! $MYVIMRC
execute 'command! Evh :e! ' . g:vimDir . '/autoload/helpers.vim'
for s:f in s:vimCfgFiles
	execute 'command! Ev' . s:f[0] . ' :e! ' . g:vimDir . '/config/' . s:f . '.vim'
endfor
" >>> Bash {{{2
execute 'command! Eb :e! ' . g:dotFiles . '/bash/bashrc'
for s:f in ['aliases', 'functions']
	execute 'command! Eb' . s:f[0] . ' :e! ' . g:dotFiles . '/bash/bash_' . s:f
endfor
" >>> Tmux {{{2
execute 'command! Et :e! ' . g:dotFiles . '/tmux/tmux.conf'
" 2}}}
" 1}}}

" Automatically source vimrc & vim config files on save  {{{1
augroup Resource
	autocmd!
	execute 'autocmd BufWritePost ' . expand($MYVIMRC) . ' source ' . expand($MYVIMRC)
	execute 'autocmd BufWritePost ' . expand(g:vimDir) . '/config/* source $MYVIMRC'
augroup END
" 1}}}

" Source files {{{1
for s:f in s:vimCfgFiles
	execute 'source ' . g:vimDir . '/config/' . s:f . '.vim'
endfor
" 1}}}

" Cleaning {{{1
unlet! s:vimCfgFiles s:f
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
