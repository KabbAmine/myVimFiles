" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-10-13
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

    let l:cmd = map(split(a:cmd), 'expand(v:val)')
    let l:name = l:cmd[0]
    let l:j_opts = exists('a:1') ? a:1 :
                \ {
                \   'err_cb'  : 'ka#job#OnError',
                \   'exit_cb' : 'ka#job#OnExit',
                \ }

    let l:job = job_start(l:cmd, l:j_opts)

    let g:jobs[l:name] = {
                \   'cmd'   : l:cmd,
                \   'errors': [],
                \   'object': l:job,
                \ }
endfunction
" 1}}}

function! s:StopAll() abort " {{{1
    if !exists('g:jobs')
        call ka#ui#E('Log', ['Job: No jobs running'])
        return
    endif

    let l:n_jobs = len(g:jobs)
    let l:stopped_jobs = 0

    for l:n in keys(g:jobs)
        let l:j = g:jobs[l:n].object
        call job_stop(l:j)
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

function! s:Stop(job) abort " {{{1
    if !exists('g:jobs')
        call ka#ui#E('Log', ['Job: No jobs running'])
        return
    endif

    if !has_key(g:jobs, a:job)
        call ka#ui#E('Log', ['Job: No "' . a:job . '" found'])
        return
    endif

    let l:j = g:jobs[a:job].object

    call job_stop(l:j)
    sleep 150m

    if job_status(l:j) !=# 'run'
        call ka#ui#E('Log', ['Job: ' . l:j . ' stopped'])
    else
        call ka#ui#E('Log', ['Job: ' . l:j . ' still running', 2])
    endif
endfunction
" 1}}}


function! ka#job#OnError(channel, msg) abort " {{{1
    let l:j = ch_getjob(a:channel)
    for l:n in keys(g:jobs)
        if g:jobs[l:n].object ==# l:j
            let l:job_name = l:n
            break
        endif
    endfor

    call add(g:jobs[l:job_name].errors, a:msg)
endfunction
" 1}}}

function! ka#job#OnExit(job, exit_status) abort " {{{1
    for l:n in keys(g:jobs)
        if g:jobs[l:n].object ==# a:job
            let l:job_name = l:n
            break
        endif
    endfor

    let l:log = ''

    if a:exit_status
        let l:log .= '[exit status ' . a:exit_status . ']'
    endif
    let l:log .= join(g:jobs[l:job_name].errors, "\n")

    if !empty(l:log)
        call ka#ui#E('Log', ['Job: ' . l:log, 1])
    endif

    unlet! g:jobs[l:job_name]
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
