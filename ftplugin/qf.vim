" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last modification: 2018-11-11
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Misc {{{1
wincmd J
setlocal nowrap
" 1}}}

" Mappings {{{1
nnoremap <silent> <buffer> <CR> :pclose!<CR><CR>zv
nnoremap <silent> <buffer> P :pclose<CR>
" 1}}}

" A pseudo preview mode {{{1
nnoremap <silent> <buffer> p :call <SID>preview_q_item()<CR>

fun! s:preview_q_item() abort " {{{2
    let s:is_loclist = getwininfo(bufwinid('%'))[0].loclist
    let file = matchstr(getline(line('.')), '^\f\+\ze|')
    let to_line = matchstr(getline(line('.')), '^\f\+|\zs\d\+\ze\s\+')
    silent execute printf(
                \ 'vertical pedit! +setlocal\ cursorline\ nobuflisted|%s %s',
                \ to_line, file
                \ )
    wincmd P | wincmd L
    normal! zv
    wincmd p
endfun " 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
