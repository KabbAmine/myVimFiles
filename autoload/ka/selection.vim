" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ka#selection#get_visual_selection() abort " {{{1
    let pos = getpos("'<")
    call setpos('.', pos)
    return getline('.')[col("'<") - 1 : col("'>") - 1]
endfun
" 1}}}

fun! ka#selection#get_motion_result() abort " {{{1
    return getline('.')[col("'[") - 1 : col("']") - 1]
endfun
" 1}}}

fun! ka#selection#move(to) range " {{{1
    " a:to : -1/1 <=> up/down
    let fl = a:firstline | let ll = a:lastline
    let cl = line('.')
    let to = a:to is# -1 ?
                \ fl - 2 : (ll + 1 >=# line('$') ? line('$') : ll + 1)
    " unfold the target line before moving there
    silent execute to ' | normal! zv | ' . cl
    execute printf(':%d,%dm%d', fl, ll, to)
endfun " 1}}}

fun! ka#selection#duplicate() abort " {{{1
    let ip = getpos('.') | silent .t. | call setpos('.', ip)
endfun
" 1}}}

" Use * for visual selection {{{1
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
fun! ka#selection#visual_set_search() abort
    let temp = @@
    normal! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:

