" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-01
" ==============================================================


let s:hints = 'jklmfdsqhgazertyuiopwxcvbn'
let s:semicolons_to_replace = {
            \   '1': ';',
            \   '2': ',',
            \   '3': '_',
            \   '4': '"',
            \   '5': "/",
            \   '6': ":",
            \   '7': "!",
            \   '8': "*",
            \   '9': "+"
            \ }

fun! ka#module#gotohint#go(key) abort " {{{1
    let buf_nr = bufnr('%')
    let cl = &l:cursorline

    let lines = a:key is# 'k'
                \ ? s:get_lines_nr(-1)
                \ : s:get_lines_nr(1)
    if lines ==# []
        return v:null
    endif

    let hint_signs = s:get_hint_signs(lines)
    call s:define_signs(hint_signs)
    call s:place_signs(hint_signs)
    setlocal cursorline

    let destination_sign = s:get_destination_sign()
    if !empty(destination_sign)
        call s:goto_sign(destination_sign)
    endif

    let &l:cursorline = cl
    call s:remove_signs(hint_signs)

    redraw!
endfun " 1}}}


fun! s:get_lines_nr(direction) abort " {{{1
    let lines = a:direction is# -1
                \ ? range(line('.') - 1, line('w0'), -1)
                \ : range(line('.') + 1, line('w$'))
    " Keep only non folded lines
    let lines = filter(lines, {i, v -> foldclosed(v) is# -1})
    return lines
endfun
" 1}}}

fun! s:get_hint_signs(lines) abort " {{{1
    let def_hints = split(s:hints, '\ze\h')
    let len_def_hints = len(def_hints)
    let count_lines = len(a:lines)
    let id = ka#utils#random_id()
    let hints = []
    for i in range(0, count_lines - 1)
        let pre_hint = ''
        let temp_i = i
        while temp_i >=# len_def_hints
            let pre_hint .= ';'
            let temp_i -= len_def_hints
        endwhile
        " A sign's text should not be more than 2 cells, so we replace the ones
        " with more than 2 semicolons:
        " ;{2}X -> ,X
        " ;{3}X -> _X
        " ;{4}X -> "X
        " ;{5}X -> 'X
        " ;{6}X -> /X
        " ;{7}X -> :X
        " ;{8}X -> !X
        " ;{9}X -> *X
        for [count_sc, replace_by] in items(s:semicolons_to_replace)
            if pre_hint =~# '\v^;{' . count_sc . '}$'
                let pre_hint = replace_by
            endif
        endfor
        let hint = pre_hint . def_hints[temp_i]
        call add(hints, {
                    \   'name': 'gotohint-' . hint,
                    \   'text': hint,
                    \   'line': a:lines[i],
                    \   'id': id
                    \ })
        let id += 1
    endfor
    return hints
endfun
" 1}}}

fun! s:define_signs(hint_signs) abort " {{{1
    for h in a:hint_signs
        let defined = !empty(execute('sign list ' . h.name, 'silent!'))
        if !defined
            let higroup = h.text =~# '^,\h$'
                        \ ? 'DiffChange'
                        \ : h.text =~# '^;\h$'
                        \ ? 'IncSearch'
                        \ : h.text =~# '^_\h$'
                        \ ? 'DiffAdd'
                        \ : 'Search'
            silent execute printf('sign define %s text=%s texthl=%s',
                        \   h.name, h.text, higroup)
        endif
    endfor
endfun
" 1}}}

fun! s:place_signs(hint_signs) abort " {{{1
    let buf_nr = bufnr('%')
    for h in a:hint_signs
        silent execute printf('sign place %d line=%d name=%s buffer=%d',
                    \   h.id,
                    \   h.line,
                    \   h.name,
                    \   buf_nr
                    \ )
    endfor
endfun
" 1}}}

fun! s:get_destination_sign() abort " {{{1
    let dest_sign = ''
    call ka#ui#echo('Gotohint>', '', 'modemsg')
    let hint = nr2char(getchar())
    if hint =~# '^\h$'
        let dest_sign = hint
    elseif hint =~# '^[' . join(values(s:semicolons_to_replace), '') . ']$'
        call ka#ui#echo('Gotohint> ', hint, 'modemsg')
        let next_hint = nr2char(getchar())
        if next_hint =~# '^\h$'
            let dest_sign = hint . next_hint
        endif
    endif
    return dest_sign
endfun
" 1}}}

fun! s:remove_signs(hint_signs) abort " {{{1
    let buf_nr = bufnr('%')
    for h in a:hint_signs
        silent execute printf('sign unplace %d buffer=%d', h.id, buf_nr)
    endfor
endfun
" 1}}}

fun! s:goto_sign(dest) abort " {{{1
    let buf_nr = bufnr('%')
    let sign_name = 'gotohint-' . a:dest
    let id = matchstr(
                \   filter(
                \       split(execute('sign place buffer=' . buf_nr), "\n"),
                \       {i, v -> v =~# sign_name})[0],
                \   'id=\zs\d\+\ze\s\+'
                \   )
    silent execute printf('sign jump %s buffer=%d', id, buf_nr)
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
