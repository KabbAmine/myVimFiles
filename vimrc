" ========== Main vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-20
" ==============================================================


" Useful checks {{{1
let g:has_unix = has('unix')
let g:has_win = has('win32')
let g:has_gui = has('gui_running')
let g:has_job = has('job')
let g:has_term = has('terminal')
" 1}}}

" Vim & dotfiles directories {{{1
let g:vim_dir = g:has_win
            \ ? substitute(expand('$HOME/vimfiles'), '\', '/', 'g')
            \ : expand('$HOME/.vim')
" let s:vim_cfg_files = ['minimal', 'plugins', 'tabline', 'statusline']
let s:vim_cfg_files = ['minimal', 'plugins', 'statusline']
" 1}}}

" Quick access to my vim config files {{{1
command! Ev :e! $MYVIMRC
for s:f in s:vim_cfg_files
    execute 'command! Ev' . s:f[0] .
                \' :edit! ' . g:vim_dir . '/config/' . s:f . '.vim'
endfor
" 1}}}

" Automatically source vimrc & vim config files on save  {{{1
augroup Resource
    autocmd!
    execute 'autocmd BufWritePost ' . expand($MYVIMRC) .
                \ ' source ' . expand($MYVIMRC)
    execute 'autocmd BufWritePost ' . expand(g:vim_dir) .
                \ '/config/*.vim source $MYVIMRC'
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
