" ========== Helpers & useful functions ========================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-09-17
" ==============================================================


" ========== MISC ==============================================

function! helpers#AutoCmd(name, cmd, events) abort " {{{1
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

function! helpers#Log(message, ...) abort " {{{1
    " Echo message with a:1 index hi group.

    let l:t = exists('a:1') ? a:1 : 0
    let l:hi = ['WarningMsg', 'ErrorMsg', 'DiffAdd']
    execute 'echohl ' . l:hi[l:t]
    echomsg a:message
    echohl None
endfunction
" 1}}}

function! helpers#GetVisualSelection() abort " {{{1
    let l:pos = getpos("'<")
    call setpos('.', l:pos)
    return getline('.')[col("'<") - 1 : col("'>") - 1]
endfunction
" 1}}}

function! helpers#GetMotionResult() abort " {{{1
    return getline('.')[col("'[") - 1 : col("']") - 1]
endfunction
" 1}}}

function! helpers#OpenOrMove2Buffer(buf_name, ft, split,...) abort " {{{1
    " Open or move to a:bufname (non scratch buffer if a:1 exists)

    let l:scratch = !exists('a:1') ? 1 : 0

    if !bufexists(a:buf_name)
        silent execute a:split . ' ' . a:buf_name
    elseif !bufloaded(a:buf_name)
        silent execute a:split . ' ' . a:buf_name
    elseif winnr('$') ># 1
        for l:w in range(1, winnr('$'))
            if bufname(winbufnr(l:w)) ==# a:buf_name
                execute l:w . 'wincmd w'
            endif
        endfor
    endif

    if !empty(a:ft)
        let &filetype = a:ft
    endif

    if l:scratch
        setlocal noswapfile
        setlocal buftype=nofile
    endif
endfunction
" 1}}}

fun! helpers#ExecuteInBuffer(buf_name, start, end, ft_dict, ...) abort " {{{1
    " Execute lines[a:start, a:end] in a:buf_name using values from a:ft_dict
    " a:1 is/are local option(s)
    " a:2 is/are command(s) that will be executed

    " Get content and current filetype
    let l:sel = getline(a:start, a:end)
    let l:ft = &ft

    if l:sel ==# [''] || !has_key(a:ft_dict, l:ft)
        call helpers#Log('No content or provider found', 1)
        return 0
    endif

    let l:_ = get(a:ft_dict, l:ft)

    let l:cmd = get(l:_, 'cmd')
    let l:new_ft = get(l:_, 'ft')
    let l:exec = get(l:_, 'exec')
    let l:tmp = get(l:_, 'tmp')

    " Check if the 1st word in cmd is an executable
    if !executable(split(l:cmd)[0])
        call helpers#Log(split(l:cmd)[0] . ' was not found')
        return 0
    endif

    if l:tmp
        " Use a temporary file
        call helpers#OpenOrMove2Buffer(a:buf_name, l:new_ft, 'vs', 1)
        silent %delete_
        call setline(1, l:sel)

        let l:tmp_file = tempname()

        let l:ext_in = matchstr(l:cmd, '%i\zs.\S*')
        let l:ext_in = !empty(l:ext_in) ? l:ext_in : ''
        let l:in_file = l:tmp_file . l:ext_in

        let l:ext_out = matchstr(l:cmd, '%o\zs.\S*')
        let l:ext_out = !empty(l:ext_out) ? l:ext_out : ''
        let l:out_file = l:tmp_file . l:ext_out

        silent execute 'saveas ' . l:in_file

        let l:cmd = substitute(l:cmd, '%i', l:tmp_file, '')
        let l:cmd = substitute(l:cmd, '%o', l:tmp_file, '')

        call system(l:cmd)

        let l:res = !l:exec ? readfile(l:out_file) :
                    \ systemlist(fnamemodify(l:tmp_file, ':p:h') .
                    \ '/./' . fnamemodify(l:tmp_file, ':t:r') . l:ext_out)

        silent %delete_
        call setline(1, l:res)

        call delete(l:in_file)
        call delete(l:out_file)

        silent execute 'file ' . a:buf_name
    else
        " Filter buffer using :!
        call helpers#OpenOrMove2Buffer(a:buf_name, l:new_ft, 'vs')
        silent %delete_
        call setline(1, l:sel)

        silent execute '%!' . l:cmd
    endif

    " Set options locally if needed
    if exists('a:1')
        for l:o in a:1
            silent execute 'setlocal ' . l:o
        endfor
    endif

    " Execute passed commands
    if exists('a:2')
        for l:o in a:2
            silent execute l:o
        endfor
    endif

    " Go back to initial window
    wincmd p

endfunction
" 1}}}

function! helpers#MakeTextObjects(to) abort " {{{1
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

function! helpers#TabComplete() abort " {{{1
    let l:c = getchar()
    " 9 is a tab
    if empty(l:c) || l:c ==# '9'
        return "\<Tab>"
    endif
    let l:c = nr2char(l:c)
    let l:t_c = {
                \   'f': "\<C-x>\<C-f>",
                \   'o': "\<C-x>\<C-o>",
                \   'n': "\<C-x>\<C-n>",
                \   'i': "\<C-x>\<C-i>",
                \   'k': "\<C-x>\<C-k>",
                \   'u': "\<C-x>\<C-u>",
                \   't': "\<C-x>\<C-]>",
                \   's': "\<C-x>s",
                \   'l': "\<C-x>\<C-l>",
                \ }
    return has_key(l:t_c, l:c) ? l:t_c[l:c] : "\<Tab>" . l:c
endfunction
" 1}}}

" function! helpers#AutoCompleteWithMapTriggers(triggers) abort " {{{1
"     augroup AutoCompletion
"         autocmd!
"         for l:ft in keys(a:triggers)
"             for [l:trigger, l:key] in items(a:triggers[l:ft])
"                 silent execute printf('autocmd FileType %s inoremap <silent> <buffer> %s %s<C-x><C-%s>',
"                             \   l:ft, l:trigger, l:trigger, l:key)
"             endfor
"         endfor
"     augroup END
" endfunction
" 1}}}

" ========== JOBS ==============================================

function! s:hasJob() abort " {{{1
    if !has_unix('job')
        call helpers#Log('Your vim version does not support "jobs"', 1)
        return 0
    else
        return 1
    endif
endfunction
" 1}}}

function! helpers#KillAllJobs() abort " {{{1
    if exists('g:jobs') && !empty(g:jobs)
        let l:n_jobs = len(g:jobs)
        let l:i = 0
        for l:j in keys(g:jobs)
            call job_stop(g:jobs[l:j])
            let l:i += 1
            unlet! g:jobs[l:j]
        endfor
        call helpers#Log(l:i . '/' . l:n_jobs . ' job(s) was(were) terminated',
                    \ 2)
    endif
endfunction
" 1}}}

function! helpers#Job(name, cmd, ...) abort " {{{1
    " $1 is job options: {}

    let l:has_job = s:hasJob()
    if !l:has_job
        return 0
    endif

    if !exists('g:jobs')
        let g:jobs = {}
    endif

    if !has_key(g:jobs, a:name)
        let l:job = exists('a:1') ?
                    \   job_start(a:cmd, a:1) :
                    \   job_start(a:cmd, {'err_cb' : 'helpers#ErrorHandler'})
        if job_status(l:job) ==# 'run'
            call helpers#Log('Job: ' . a:name . ' is running', 2)
            let g:jobs[a:name] = l:job
        else
            call helpers#Log('Job: ' . a:name . ' is not running')
        endif
    else
        call job_stop(g:jobs[a:name], 'kill')
        unlet! g:jobs[a:name]
        call helpers#Log('Job: ' . a:name . ' stopped', 2)
    endif
endfunction
" 1}}}

function! helpers#ErrorHandler(channel, msg) abort " {{{1
    if !empty(a:msg)
        let l:msg = printf('Job: %s: %s', a:channel, a:msg)
        call helpers#Log(l:msg, 1)
    endif
endfunction
" 1}}}

" ========== SYSTEM ============================================

function! helpers#OpenHere(type, ...) abort " {{{1
    " type: (t)erminal, (f)ilemanager
    " a:1: Location (pwd by default)

    let l:cmd = {
                \ 't': (g:has_unix ?
                \   'exo-open --launch TerminalEmulator ' .
                \       '--working-directory %s 2> /dev/null &' :
                \   'start cmd /k cd %s'),
                \ 'f': (g:has_unix ?
                \   'xdg-open %s 2> /dev/null &' :
                \   'start explorer %s')
                \ }
    exe printf('silent !' . l:cmd[a:type], (exists('a:1') ? a:1 : getcwd()))

    if !g:has_gui | redraw! | endif

endfunction
" 1}}}

function! helpers#OpenUrl() abort " {{{1
    " Open the current URL
    " - If line begins with "Plug" or "call s:PlugInOs", open the github page
    " of the plugin.

    let l:cl = getline('.')
    let l:url = escape(matchstr(l:cl, '[a-z]*:\/\/\/\?[^ >,;()]*'), '%')
    if l:cl =~# 'Plug' || l:cl =~# 'call s:PlugInOs'
        let l:pn = l:cl[match(l:cl, "'", 0, 1) + 1 :
                    \ match(l:cl, "'", 0, 2) - 1]
        let l:url = printf('https://github.com/%s', l:pn)
    endif
    if !empty(l:url)
        let l:url = substitute(l:url, "'", '', 'g')
        let l:wmctrl = executable('wmctrl') && v:windowid !=# 0 ?
                    \ ' && wmctrl -ia ' . v:windowid : ''
        exe 'silent :!' . (g:has_unix ?
                    \   'x-www-browser ' . shellescape(l:url) :
                    \   ' start "' . shellescape(l:url)) .
                    \ l:wmctrl .
                    \ (g:has_unix ? ' 2> /dev/null &' : '')
        if !g:has_gui | redraw! | endif
    endif

endfunction
" 1}}}

function! helpers#Delete(...) abort " {{{1
    let l:a = map(copy(a:000), 'fnamemodify(v:val, ":p")')
    for l:f in l:a
        if filereadable(l:f)
            if delete(l:f) ==# 0
                call helpers#Log('"' . l:f . '" was deleted', 2)
            else
                call helpers#Log('"' . l:f . '" was not deleted', 1)
            endif
        elseif isdirectory(l:f)
            let l:cmd = g:has_unix ?
                        \ 'rm -vr %s' :
                        \ 'RD /S %s'
            echo split(system(printf(l:cmd, escape(l:f, ' '))), "\n")[0]
        endif
    endfor
endfunction
" 1}}}

function! helpers#MakeDir(...) abort " {{{1
    for l:d in a:000
        if !isdirectory(l:d)
            call mkdir(l:d, 'p')
            call helpers#Log('"' . l:d . '" was created', 2)
        else
            call helpers#Log('"' . l:d . '" exists already')
        endif
    endfor
endfunction
" 1}}}

function! helpers#Rename(to) abort " {{{1
    let l:file = expand('%:p')
    if !filereadable(l:file)
        call helpers#Log('Not a valid file', 1)
    else
        let l:buf = expand('%')
        silent execute 'saveas ' . a:to
        silent execute 'bdelete! ' . l:buf
        if delete(l:file) ==# 0
            call helpers#Log('Renamed to "' . a:to . '"', 2)
        else
            call helpers#Log('"' . l:file . '" was not renamed', 1)
        endif
    endif
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
