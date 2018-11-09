" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-09
" ==============================================================


fun! ka#utils#get_visual_selection() abort " {{{1
    let pos = getpos("'<")
    call setpos('.', pos)
    return getline('.')[col("'<") - 1 : col("'>") - 1]
endfun
" 1}}}

fun! ka#utils#get_motion_result() abort " {{{1
    return getline('.')[col("'[") - 1 : col("']") - 1]
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

fun! ka#utils#autocmd(name, cmd, events) abort " {{{1
    " Execute a:cmd in a:name augroup when [a:event] is(are) executed.
    " Re-execute the function toggle the state.

    if !exists('#' . a:name)
        execute 'augroup ' . a:name
            autocmd!
            execute 'autocmd ' . join(a:events) . ' <buffer> :' . a:cmd
        augroup END
        echo 'Auto ' . a:name .' update enabled'
        silent execute a:cmd
    else
        execute 'augroup ' . a:name
            autocmd!
        augroup END
        execute 'augroup! ' . a:name
        echo 'Auto ' . a:name .' update disabled'
    endif
endfun
" 1}}}

fun! ka#utils#create_or_go_to_buf(buf_name, ft, split) abort " {{{1
    " Open or move to a:bufname

    let buf_win = bufwinnr(bufnr(a:buf_name))

    if buf_win isnot# -1
        silent execute buf_win . 'wincmd w'
    else
        silent execute a:split . ' ' . a:buf_name
    endif

    if !empty(a:ft)
        let &filetype = a:ft
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
