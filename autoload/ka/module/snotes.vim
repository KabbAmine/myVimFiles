" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let g:snotes_dir = get(g:, 'snotes_dir', '~/snotes_vim/')

fun! ka#module#snotes#enable_date_autocmd() abort " {{{1
    " Update the date when the file is saved
    augroup Notes
        autocmd!
        execute printf('autocmd BufWrite %s/*.md :call setline(1, "> " . strftime("%%d %%b %%Y %%X"))', g:snotes_dir)
    augroup END
endfun
" 1}}}

fun! ka#module#snotes#note(file) abort " {{{1
    let file_name = g:snotes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')

    let add_date = file_readable(file_name) ? 0 : 1
    silent execute 'vnew! ' . file_name
    if add_date
        call setline(1,  ["> " . strftime("%d %b %Y %X"), ''])
        normal! G
    endif
endfun
" 1}}}

fun! ka#module#snotes#delete(file) abort " {{{1
    let file_name = g:snotes_dir . '/' .
                \ (a:file =~# '\.md$' ? a:file : a:file . '.md')
    call ka#sys#delete(file_name)
endfun
" 1}}}

fun! ka#module#snotes#complete(a, c, p) " {{{1
    return filter(map(glob(g:snotes_dir . '/*', 1, 1), {i, v ->
                \   fnamemodify(v, ':p:t')
                \ }),
                \ {i, v -> v =~ a:a })
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
