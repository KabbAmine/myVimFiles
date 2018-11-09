" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-09
" ==============================================================


fun! ka#sys#open_here(type, ...) abort " {{{1
    " type: (t)erminal, (f)ilemanager
    " a:1: Location (pwd by default)

    let cmd = {
                \ 't': (g:is_unix ?
                \   'exo-open --launch TerminalEmulator ' .
                \       '--working-directory %s 2> /dev/null &' :
                \   'start cmd /k cd %s'),
                \ 'f': (g:is_unix ?
                \   'xdg-open %s 2> /dev/null &' :
                \   'start explorer %s')
                \ }
    exe printf('silent !' . cmd[a:type],
                \   (exists('a:1') ? shellescape(a:1) : getcwd())
                \ )

    if !g:is_gui | redraw! | endif
endfun
" 1}}}

fun! ka#sys#open_url() abort " {{{1
    " Open the current URL
    " - If line begins with "Plug" open the github page
    " of the plugin.

    let cl = getline('.')
    let url = escape(matchstr(cl, '[a-z]*:\/\/\/\?[^ >,;()]*'), '#%')
    if cl =~# 'Plug'
        let pn = cl[match(cl, "'", 0, 1) + 1 :
                    \ match(cl, "'", 0, 2) - 1]
        let url = printf('https://github.com/%s', pn)
    endif
    if !empty(url)
        let url = substitute(url, "'", '', 'g')
        let wmctrl = executable('wmctrl') && v:windowid isnot# 0 ?
                    \ ' && wmctrl -ia ' . v:windowid : ''
        exe 'silent :!' . (g:is_unix ?
                    \   'x-www-browser ' . shellescape(url) :
                    \   ' start "' . shellescape(url)) .
                    \ wmctrl .
                    \ (g:is_unix ? ' 2> /dev/null &' : '')
        if !g:is_gui | redraw! | endif
    endif

endfun
" 1}}}

fun! ka#sys#delete(...) abort " {{{1
    let a = map(copy(a:000), 'fnamemodify(v:val, ":p")')
    for f in a
        if filereadable(f)
            if delete(f) ==# 0
                call s:echo('"' . f . '" was deleted', 'question')
                let b = fnamemodify(f, ':.')
                if bufloaded(b)
                    if bufname('%') is# b
                        silent enew!
                    endif
                    silent execute 'bwipeout! ' . b
                endif
            else
                call s:echo('"' . f . '" was not deleted', 'error')
            endif
        elseif isdirectory(f)
            let cmd = g:is_unix ?
                        \ 'rm -vr %s' :
                        \ 'RD /S %s'
            echo split(system(printf(cmd, escape(f, ' '))), "\n")[0]
        endif
    endfor
endfun
" 1}}}

fun! ka#sys#rename(to) abort " {{{1
    let file = expand('%:p')
    if !filereadable(file)
        call s:echo('Not a valid file', 'error')
    else
        let buf = expand('%')
        silent execute 'saveas ' . a:to
        silent execute 'bdelete! ' . buf
        if delete(file) is# 0
            call s:echo('renamed to "' . a:to . '"', 'question')
        else
            call s:echo('"' . file . '" was not renamed', 'error')
        endif
    endif
endfun
" 1}}}

fun! ka#sys#execute_cmd(cmd, ...) abort " {{{1
    let cmd = a:cmd . join(a:000)
    if !executable(split(a:cmd)[0])
        call s:echo(printf(
                    \ '"%s" is not a valid shell command', cmd
                    \ ), 'error')
        return ''
    endif
    let res = systemlist(cmd)
    silent execute v:shell_error
                \ ? 'echohl Error'
                \ : 'echohl Question'
    redraw!
    echo join(res, "\n")
    echohl None
endfun
" 1}}}

fun! s:echo(msg, ...) abort " {{{1
    let higroup = get(a:, '1', 'normal')
    call ka#ui#echo('->', a:msg, higroup)
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
