" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-14
" ==============================================================


fun! ka#module#gotohint#go(key) abort " {{{1
    let buf_nr = bufnr('%')
    let cl = &l:cursorline
    let dest_sign = ''

    let lines = a:key is# 'k'
                \ ? range(line('.') - 1, line('w0'), -1)
                \ : range(line('.') + 1, line('w$'))
    " Keep only folded lines
    let lines = filter(lines, {i, v -> foldclosed(v) is# -1})
    " Do not proceed if there are no lines above/below the current one
    if lines ==# []
        return v:null
    endif

    let hint_signs = s:get_hint_signs(lines)
    setlocal cursorline
    call s:define_signs(hint_signs)
    call s:place_signs(hint_signs)

    call ka#ui#echo('Gotohint>', '', 'modemsg')
    let hint = nr2char(getchar())
    if hint =~# '^\h$'
        let dest_sign = hint
    elseif hint =~# '^\(;\|,\)$'
        call ka#ui#echo('Gotohint> ', hint, 'modemsg')
        let next_hint = nr2char(getchar())
        if next_hint =~# '^\h$'
            let dest_sign = hint . next_hint
        endif
    endif

    if !empty(dest_sign)
        call s:goto_sign(dest_sign)
    endif

    let &l:cursorline = cl
    call s:remove_signs(hint_signs)

    redraw!
endfun " 1}}}


let s:hints = 'jklmfdsqhgazertyuiopwxcvbn'

fun! s:get_hint_signs(lines) abort " {{{1
    let def_hints = split(s:hints, '\ze\h')
    let len_def_hints = len(def_hints)
    let count_lines = len(a:lines)
    " Generate a random number (https://stackoverflow.com/a/12739441)
    let id = str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
    let hints = []
    for i in range(0, count_lines - 1)
        let pre_hint = ''
        let temp_i = i
        " It should not exceed 2 semicolons coz the sign's text shoul not be
        " more than 2 cells
        while temp_i >=# len_def_hints
            let pre_hint .= ';'
            let temp_i -= len_def_hints
        endwhile
        " We replace ;;X by ,X and ;;;X by _X if they exist
        if pre_hint =~# '^;;$'
            let pre_hint = ','
        elseif pre_hint =~# '^;;;$'
            let pre_hint = '_'
        endif
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
