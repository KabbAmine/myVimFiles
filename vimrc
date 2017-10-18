" ========== Main vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-10-09
" ==============================================================


" Useful checks {{{1
let g:has_unix = has('unix')
let g:has_win = has('win32')
let g:has_gui = has('gui_running')
let g:has_job = has('job')
" 1}}}

" Vim & dotfiles directories {{{1
let g:vim_dir = g:has_win ?
            \ substitute(expand('$HOME/vimfiles'), '\', '/', 'g') :
            \ expand('$HOME/.vim')
let s:vim_cfg_files = ['minimal', 'plugins', 'tabline', 'statusline']
let g:dot_files = expand('$HOME/.dotfiles')
" 1}}}

" Commands for quick access to config files {{{1
" >>> Vim {{{2
command! Ev :e! $MYVIMRC
for s:f in s:vim_cfg_files
    execute 'command! Ev' . s:f[0] .
                \' :e! ' . g:vim_dir . '/config/' . s:f . '.vim'
endfor

" >>> Bash {{{2
execute 'command! Eb :e! ' . g:dot_files . '/bash/bashrc'
for s:f in ['aliases', 'functions']
    execute 'command! Eb' . s:f[0] .
                \ ' :e! ' . g:dot_files . '/bash/bash_' . s:f
endfor

" >>> Tmux {{{2
execute 'command! Et :e! ' . g:dot_files . '/tmux/tmux.conf'
" 2}}}
" 1}}}

" Automatically source vimrc & vim config files on save  {{{1
augroup Resource
    autocmd!
    execute 'autocmd BufWritePost ' . expand($MYVIMRC) .
                \ ' source ' . expand($MYVIMRC)
    execute 'autocmd BufWritePost ' . expand(g:vim_dir) .
                \ '/config/* source $MYVIMRC'
augroup END
" 1}}}

" Source files {{{1
for s:f in s:vim_cfg_files
    execute 'source ' . g:vim_dir . '/config/' . s:f . '.vim'
endfor
" 1}}}

" Cleaning {{{1
unlet! s:vim_cfg_files s:f
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
