" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ka#terminal#toggle(...) abort " {{{1
    let term_buf_nr = get(g:, 'term_buf_nr', 0)
    if !term_buf_nr
        let cwd = exists('a:1') ? expand('%:p:h') : getcwd()
        let g:term_buf_nr = term_start(&shell, {
                    \   'term_name': 'term',
                    \   'cwd': cwd
                    \ })
        augroup Term
            autocmd!
            autocmd BufDelete,BufWipeout <buffer>
                        \ unlet! g:term_buf_nr
        augroup END
    elseif bufexists(term_buf_nr)
        let term_win_nr = bufwinnr(term_buf_nr)
        silent execute term_win_nr isnot# -1
                    \ ? term_win_nr . 'hide'
                    \ : term_buf_nr . 'sbuffer'
    endif
endfun " 2}}}

fun! ka#terminal#kill() abort " {{{1
    let term_buf_nr = get(g:, 'term_buf_nr', 0)
    if term_buf_nr && index(term_list(), term_buf_nr) isnot# -1
                \ && bufloaded(term_buf_nr)
        silent execute term_buf_nr . 'bwipeout!'
        unlet! g:term_buf_nr
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
