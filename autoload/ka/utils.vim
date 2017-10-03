" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-09-30
" ==============================================================


function! ka#utils#E(fun, ...) abort " {{{1
    let l:params = exists('a:1') ? a:1 : []
    let l:return = exists('a:2') ? 1 : 0

    if l:return
        return call('s:' . a:fun, l:params)
    else
        call call('s:' . a:fun, l:params)
    endif
endfunction
" 1}}}


function! s:GetVisualSelection() abort " {{{1
    let l:pos = getpos("'<")
    call setpos('.', l:pos)
    return getline('.')[col("'<") - 1 : col("'>") - 1]
endfunction
" 1}}}

function! s:GetMotionResult() abort " {{{1
    return getline('.')[col("'[") - 1 : col("']") - 1]
endfunction
" 1}}}

function! s:MakeTextObjects(to) abort " {{{1
    let l:to = a:to

    " For all ft
    for [l:k, l:m] in l:to._
        execute 'onoremap <silent> ' . l:k . ' :normal! ' . l:m . '<CR>'
        execute 'xnoremap <silent> ' . l:k . ' :<C-u>normal! ' . l:m . '<CR>'
    endfor
    call remove(l:to, '_')

    augroup MyTextObjects
        autocmd!
        for l:ft in keys(l:to)
            for [l:k, l:m] in l:to[l:ft]
                execute 'autocmd FileType ' . l:ft .
                            \ ' onoremap <buffer> <silent> ' . l:k .
                            \ ' :normal! ' . l:m . '<CR>'
                execute 'autocmd FileType ' . l:ft .
                            \ ' xnoremap <buffer> <silent> ' . l:k .
                            \ ' :<C-u>normal! ' . l:m . '<CR>'
            endfor
        endfor
    augroup END

endfunction
" 1}}}

function! s:TabComplete() abort " {{{1
    let l:compl_maps = {
                \   'c': "\<C-x>\<C-v>",
                \   'f': "\<C-x>\<C-f>",
                \   'i': "\<C-x>\<C-i>",
                \   'k': "\<C-x>\<C-k>",
                \   'l': "\<C-x>\<C-l>",
                \   'n': "\<C-x>\<C-n>",
                \   'o': "\<C-x>\<C-o>",
                \   's': "\<C-x>s",
                \   't': "\<C-x>\<C-]>",
                \   'u': "\<C-x>\<C-u>",
                \ }

    let l:inp_char = getchar()

    " 9:<tab> & 13:<CR>
    if l:inp_char ==# 9
        return "\<Tab>"
    elseif l:inp_char ==# 13
        return ''
    endif

    let l:inp_char = nr2char(l:inp_char)
    return has_key(l:compl_maps, l:inp_char) ?
                \ l:compl_maps[l:inp_char] : "\<Tab>" . l:inp_char
endfunction
" 1}}}

function! s:AutoCmd(name, cmd, events) abort " {{{1
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
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
