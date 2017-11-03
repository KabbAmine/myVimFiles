" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-10-31
" ==============================================================


function! ka#buffer#E(fun, ...) abort " {{{1
    let l:params = exists('a:1') ? a:1 : []
    let l:return = exists('a:2') ? 1 : 0

    if l:return
        return call('s:' . a:fun, l:params)
    else
        call call('s:' . a:fun, l:params)
    endif
endfunction
" 1}}}


function! s:AutoFormat(start, end, formatters) abort " {{{1
    let l:p = getpos('.')
    let l:format_cmd = get(a:formatters, &ft, '')
    let l:n_lines = line('$')

    if empty(l:format_cmd)
        silent execute 'normal! ' . a:start . 'ggV' . a:end . 'gg='
        call setpos('.', l:p)
        return
    endif

    let l:executable = split(l:format_cmd)[0]
    if !executable(l:executable)
        call ka#ui#E('Log', [shellescape(l:executable) . ' was not found', 1])
        return
    endif

    let l:msg = 'Formatting [' . l:executable . '] from ' . a:start . ' to ' . a:end . '...'
    call ka#ui#E('Log', [l:msg])

    silent execute a:start . ',' . a:end . '!' . l:format_cmd
    redraw

    if v:shell_error
        if line('$') !=# l:n_lines
            " We undo what was added
            silent normal! u
        endif
        call ka#ui#E('Log', [l:msg . 'Not done :('])
    else
        call ka#ui#E('Log', [l:msg . 'Done'])
    endif

    " Depending of the formatter, it may be not accurate
    call setpos('.', l:p)
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
