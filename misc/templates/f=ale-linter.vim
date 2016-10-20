" Author: %USERNAME% <%MAIL%>
" Description: %FILE% for checking %TYPE% files

if exists('g:loaded_ale_linters_%TYPE%_%FILE%')
    finish
endif

let g:loaded_ale_linters_%TYPE%_%FILE% = 1

function! ale_linters#%TYPE%#%FILE%#Handle(buffer, lines) abort
    " Matches patterns lines like the following:
    " %_%

    let l:pattern = '^line \(\d\+\) column \(\d\+\) - \(Warning\|Error\): \(.\+\)$'
    let l:output = []

    for l:line in a:lines
        let l:match = matchlist(l:line, l:pattern)

        if len(l:match) == 0
            continue
        endif

        let l:line = l:match[1] + 0
        let l:col = l:match[2] + 0
        let l:type = l:match[3] ==# 'Error' ? 'E' : 'W'
        let l:text = l:match[4]

        " vcol is Needed to indicate that the column is a character.
        call add(l:output, {
        \   'bufnr': a:buffer,
        \   'lnum': l:line,
        \   'vcol': 0,
        \   'col': l:col,
        \   'text': l:text,
        \   'type': l:type,
        \   'nr': -1,
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('%TYPE%', {
\   'name': '%FILE%',
\   'executable': g:ale_%TYPE%_%FILE%_executable,
\   'output_stream': 'stderr',
\   'command_callback': 'ale_linters#%TYPE%#%FILE%#GetCommand',
\   'command': '%FILE% foo',
\   'callback': 'ale_linters#%TYPE%#%FILE%#Handle',
\ })
