" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" ==============================================================


fun! ka#utils#clever_gf(...) abort " {{{1
    " Expand 2 times in case we have $HOME or ~
    let cf = fnamemodify(expand(expand('<cfile>')), '%:p')
    if isdirectory(cf)
        return ''
    endif
    if exists('a:1')
        execute 'vsplit ' . cf
    else
        execute filereadable(cf)
                    \ ? 'normal! gf'
                    \ : 'edit ' . cf
    endif
endfun
" 1}}}

fun! ka#utils#go_to_tag_custom(...) abort " {{{1
    " tjump to a tag <cexpr>, and if it does not exist search for a tag
    " containing the expression with 'tselect /expr'

    let split = get(a:, 1, 0)
    try
        let exp = expand('<cexpr>')
        let cmd = split ? 'vertical stjump' : 'tjump'
        execute cmd . ' ' . exp
        normal! ztzv
    catch /^Vim\%((\a\+)\)\=:E426/
        " E426: no tag found
        try
            let cmd = split ? 'vertical stselect' : 'tselect'
            execute cmd . ' /' . exp
        catch /^Vim\%((\a\+)\)\=:\(E426\|E349\)/
            " E349: no identifier on cursor
            call ka#ui#echo('[E]', v:exception, 'Error')
        endtry
    endtry
endfun
" 1}}}

fun! ka#utils#random_id() abort " {{{1
    " Generate a random number (https://stackoverflow.com/a/12739441)
    return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfun
" 1}}}

fun! ka#utils#make_text_objs(to) abort " {{{1
    let to = a:to

    " For all ft
    for [k, m] in to._
        execute 'onoremap <silent> ' . k . ' :normal! ' . m . '<CR>'
        execute 'xnoremap <silent> ' . k . ' :<C-u>normal! ' . m . '<CR>'
    endfor
    call remove(to, '_')

    augroup MyTextObjects
        autocmd!
        for ft in keys(to)
            for [k, m] in to[ft]
                execute 'autocmd FileType ' . ft .
                            \ ' onoremap <buffer> <silent> ' . k .
                            \ ' :normal! ' . m . '<CR>'
                execute 'autocmd FileType ' . ft .
                            \ ' xnoremap <buffer> <silent> ' . k .
                            \ ' :<C-u>normal! ' . m . '<CR>'
            endfor
        endfor
    augroup END
endfun
" 1}}}

fun! ka#utils#auto_mkdir() abort " {{{1
    let dir = expand('<afile>:p:h')
    let file = expand('<afile>:t')
    if !isdirectory(dir)
        echohl Question
        let ans = input(dir . ' does not exist, create it [y/N]? ')
        echohl None
        if empty(ans) || ans =~? '^n$'
            echomsg 'no'
            return
        endif
        call mkdir(dir, 'p')
        silent execute 'saveas ' . dir . '/' . file
        " Then wipeout the alternative buffer if it have the same name.
        if bufname('#') is# dir . '/' . file
            silent execute 'bwipeout! ' . bufnr('#')
        endif
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
