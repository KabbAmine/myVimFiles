" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-01-20
" ==============================================================


function! ka#job#E(fun, ...) abort " {{{1
    let l:params = exists('a:1') ? a:1 : []
    let l:return = exists('a:2') ? 1 : 0

    if l:return
        return call('s:' . a:fun, l:params)
    else
        call call('s:' . a:fun, l:params)
    endif
endfunction
" 1}}}


function! s:Create(cmd, ...) abort " {{{1
    if !g:has_job
        call ka#ui#E('Log', ['Your vim version does not support "jobs"', 1])
        return 0
    endif

    if !exists('g:jobs')
        let g:jobs = {}
    endif

    let l:silent = exists('a:1') && a:1 ? 1 : 0

    let l:cmd = map(split(a:cmd), 'expand(v:val)')
    let l:name = l:cmd[0]
    let l:j_opts = {
                \   'out_cb' : function('s:OnOut'),
                \   'err_cb' : function('s:OnError'),
                \   'exit_cb': function('s:OnExit'),
                \ }
    if exists('a:2')
        call extend(l:j_opts, a:1, 'force')
    endif

    let l:job = job_start(join(l:cmd), l:j_opts)
    call setqflist([], 'r')
    call setqflist([], 'a', {'title': join(l:cmd)})

    let g:jobs[l:name] = {'cmd' : l:cmd, 'object': l:job}
    let s:silent = l:silent
endfunction
" 1}}}

function! s:StopAll(bang) abort " {{{1
    if !exists('g:jobs')
        call ka#ui#E('Log', ['Job: No jobs running'])
        return
    endif

    let l:n_jobs = len(g:jobs)
    let l:stopped_jobs = 0

    for l:n in keys(g:jobs)
        let l:j = g:jobs[l:n].object
        let l:how = a:bang ==# '!' ? 'kill' : 'term'
        call job_stop(l:j, l:how)
        sleep 150m

        if job_status(l:j) !=# 'run'
            let l:stopped_jobs += 1
        endif
    endfor

    call ka#ui#E('Log', [printf('Job: %d/%d job(s) stopped',
                \ l:stopped_jobs, l:n_jobs), 2])
endfunction
" 1}}}

function! s:List() abort " {{{1
    if !exists('g:jobs')
        return
    endif

    call ka#ui#E('Log', ['Job(s):', 2])
    for l:n in keys(g:jobs)
        echo printf('%s [%s] (%s)',
                    \ l:n, join(g:jobs[l:n].cmd), g:jobs[l:n].object)
    endfor
endfunction
" 1}}}

function! s:Stop(job, bang) abort " {{{1
    if !exists('g:jobs')
        call ka#ui#E('Log', ['Job: No jobs running'])
        return
    endif

    if !has_key(g:jobs, a:job)
        call ka#ui#E('Log', ['Job: No "' . a:job . '" found'])
        return
    endif

    let l:j = g:jobs[a:job].object

    let l:how = a:bang ==# '!' ? 'kill' : 'term'
    call job_stop(l:j, l:how)
    sleep 150m

    if job_status(l:j) !=# 'run'
        call ka#ui#E('Log', ['Job: ' . l:j . ' stopped'])
    else
        call ka#ui#E('Log', ['Job: ' . l:j . ' still running', 2])
    endif
endfunction
" 1}}}


function! s:OnError(channel, msg) abort " {{{1
    let l:j = ch_getjob(a:channel)
    for l:n in keys(g:jobs)
        if g:jobs[l:n].object ==# l:j
            let l:job_name = l:n
            break
        endif
    endfor

    if !exists('s:errors') && !exists('s:out')
        let s:errors = 1
    endif
    caddexpr a:msg
endfunction
" 1}}}

function! s:OnOut(channel, msg) abort " {{{1
    let l:j = ch_getjob(a:channel)
    for l:n in keys(g:jobs)
        if g:jobs[l:n].object ==# l:j
            let l:job_name = l:n
            break
        endif
    endfor

    if !exists('s:errors') && !exists('s:out')
        let s:out = 1
    endif
    caddexpr a:msg
endfunction
" 1}}}

function! s:OnExit(job, exit_status) abort " {{{1
    " Populate quickfix window with all the output if there is one (stdout +
    " stderr).
    " The output is parsed with the global errorformat.

    for l:n in keys(g:jobs)
        if g:jobs[l:n].object ==# a:job
            let l:job_name = l:n
            break
        endif
    endfor

    if exists('s:silent') && !s:silent
        let l:log_args = a:exit_status
                    \ ? ['exit status ' . a:exit_status, 1]
                    \ : ['finished', 2]
        call ka#ui#E('Log', ['Job [' . l:job_name . ']: ' . l:log_args[0], l:log_args[1]])

        if exists('s:errors') || exists('s:out')
            cwindow | wincmd p
        endif

        if getqflist() ==# []
            silent cclose
        endif
    endif

    unlet! g:jobs[l:job_name] s:errors s:out s:silent
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
