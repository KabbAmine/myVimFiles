" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-08
" ==============================================================


function! ka#sys#OpenHere(type, ...) abort " {{{1
    " type: (t)erminal, (f)ilemanager
    " a:1: Location (pwd by default)

    let l:cmd = {
                \ 't': (g:is_unix ?
                \   'exo-open --launch TerminalEmulator ' .
                \       '--working-directory %s 2> /dev/null &' :
                \   'start cmd /k cd %s'),
                \ 'f': (g:is_unix ?
                \   'xdg-open %s 2> /dev/null &' :
                \   'start explorer %s')
                \ }
    exe printf('silent !' . l:cmd[a:type], (exists('a:1') ? shellescape(a:1) : getcwd()))

    if !g:is_gui | redraw! | endif
endfunction
" 1}}}

function! ka#sys#OpenUrl() abort " {{{1
    " Open the current URL
    " - If line begins with "Plug" open the github page
    " of the plugin.

    let l:cl = getline('.')
    let l:url = escape(matchstr(l:cl, '[a-z]*:\/\/\/\?[^ >,;()]*'), '#%')
    if l:cl =~# 'Plug'
        let l:pn = l:cl[match(l:cl, "'", 0, 1) + 1 :
                    \ match(l:cl, "'", 0, 2) - 1]
        let l:url = printf('https://github.com/%s', l:pn)
    endif
    if !empty(l:url)
        let l:url = substitute(l:url, "'", '', 'g')
        let l:wmctrl = executable('wmctrl') && v:windowid !=# 0 ?
                    \ ' && wmctrl -ia ' . v:windowid : ''
        exe 'silent :!' . (g:is_unix ?
                    \   'x-www-browser ' . shellescape(l:url) :
                    \   ' start "' . shellescape(l:url)) .
                    \ l:wmctrl .
                    \ (g:is_unix ? ' 2> /dev/null &' : '')
        if !g:is_gui | redraw! | endif
    endif

endfunction
" 1}}}

function! ka#sys#Delete(...) abort " {{{1
    let l:a = map(copy(a:000), 'fnamemodify(v:val, ":p")')
    for l:f in l:a
        if filereadable(l:f)
            if delete(l:f) ==# 0
                call ka#ui#E('Log', ['"' . l:f . '" was deleted', 2])
                let l:b = fnamemodify(l:f, ':.')
                if bufloaded(l:b)
                    if bufname('%') ==# l:b
                        silent enew!
                    endif
                    silent execute 'bwipeout! ' . l:b
                endif
            else
                call ka#ui#E('Log', ['"' . l:f . '" was not deleted', 1])
            endif
        elseif isdirectory(l:f)
            let l:cmd = g:is_unix ?
                        \ 'rm -vr %s' :
                        \ 'RD /S %s'
            echo split(system(printf(l:cmd, escape(l:f, ' '))), "\n")[0]
        endif
    endfor
endfunction
" 1}}}

function! ka#sys#Rename(to) abort " {{{1
    let l:file = expand('%:p')
    if !filereadable(l:file)
        call ka#ui#E('Log', ['Not a valid file', 1])
    else
        let l:buf = expand('%')
        silent execute 'saveas ' . a:to
        silent execute 'bdelete! ' . l:buf
        if delete(l:file) ==# 0
            call ka#ui#E('Log', ['Renamed to "' . a:to . '"', 2])
        else
            call ka#ui#E('Log', ['"' . l:file . '" was not renamed', 1])
        endif
    endif
endfunction
" 1}}}

function! ka#sys#ExecuteCmd(cmd, ...) abort " {{{1
    let cmd = a:cmd . join(a:000)
    if !executable(split(a:cmd)[0])
        call ka#ui#E('Log', [printf(
                    \ '"%s" is not a valid shell command', cmd
                    \ )])
        return ''
    endif
    let res = systemlist(cmd)
    silent execute v:shell_error
                \ ? 'echohl Error'
                \ : 'echohl Question'
    redraw!
    echo join(res, "\n")
    echohl None
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
