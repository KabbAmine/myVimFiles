" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-21
" ==============================================================


fun! ka#job#complete(arg, cmd, pos) abort " {{{1
    let opts = {
                \   'silent'  : [0, 1],
                \   'listwin' : ['q', 'l'],
                \   'goback'  : [0, 1],
                \   'realtime': [0, 1],
                \   'std'     : ['out,err', 'out', 'err'],
                \ }

    if a:cmd =~# '^JobStop' || a:cmd =~# '^JobRestart'
        return exists('g:jobs')
                    \ ? filter(keys(g:jobs), 'v:val =~ a:arg')
                    \ : []
    else
        if a:arg =~# '^+\w*$'
            " Complete options
            let f_opts = map(copy(keys(opts)), '"+" . v:val . ":"')
            return filter(f_opts, 'v:val =~ a:arg')
        elseif a:arg =~# '^+\(' . join(keys(opts), '\|') . '\):\S*$'
            " Or option values
            let opt = matchstr(a:arg, '^+\zs\w\+\ze:')
            let values = has_key(opts, opt)
                        \ ? map(opts[opt], '"+" . opt . ":" . v:val')
                        \ : []
            return filter(values, 'v:val =~ a:arg')
        else
            " Or shell commands
            return filter(getcompletion('', 'shellcmd'), 'v:val =~ a:arg')
        endif
    endif
endfun
" 1}}}

fun! ka#job#start(args) abort " {{{1
    let opts = {}
    let cmd = ''
    for e in split(a:args)
        if e =~# '^+\w\+:\S\+$'
            let opt = matchstr(e, '+\zs\w\+\ze:.*$')
            let value = matchstr(e, '+\w\+:\zs\S\+$')
            let opts[opt] = !empty(value) ? value : ''
        else
            let cmd .= ' ' . e
        endif
    endfor
    call call('s:job_start', [cmd] + [opts])
endfun
" 1}}}

fun! ka#job#restart(job) abort " {{{1
    if s:jobs_running() && s:exists_job(a:job)
        let j = g:jobs[a:job]
        call job_stop(j.object, 'kill')
        call ka#ui#E('Log', ['Job: "' . a:job . '" is restarting...'])
        call timer_start(150, {t -> call('ka#job#start', j.args)})
    endif
endfun
" 1}}}

fun! ka#job#stop_all(bang) abort " {{{1
    if s:jobs_running()
        let n_jobs = len(g:jobs)
        let stopped_jobs = 0
        for k in keys(g:jobs)
            let j = g:jobs[k].object
            let how = a:bang is# '!' ? 'kill' : 'term'
            call job_stop(j, how)
            sleep 150m
            if job_status(j) isnot# 'run'
                let stopped_jobs += 1
            endif
        endfor
        call ka#ui#E('Log', [
                    \   printf('Job: %d/%d job(s) stopped', stopped_jobs, n_jobs),
                    \   2
                    \ ])
    endif
endfun
" 1}}}

fun! ka#job#list() abort " {{{1
    if s:jobs_running()
        call ka#ui#E('Log', ['Job(s):', 2])
        for k in sort(keys(g:jobs))
            echo printf('%3s %-10s %-10s %s',
                        \   '[' . toupper(g:jobs[k].listwin) . ']',
                        \   k,
                        \   '[' . join(split(g:jobs[k].object)[1:]) . ']',
                        \   g:jobs[k].cmd
                        \ )
        endfor
    endif
endfun
" 1}}}

fun! ka#job#stop(job, bang, ...) abort " {{{1
    if s:jobs_running() && s:exists_job(a:job)
        let j = g:jobs[a:job].object
        let how = a:bang is# '!' ? 'kill' : 'term'
        call job_stop(j, how)
        sleep 150m
        if job_status(j) isnot# 'run'
            call ka#ui#E('Log', ['Job: "' . a:job . '" stopped'])
        endif
    endif
endfun
" 1}}}

fun! s:job_start(cmd, opts) abort " {{{1
    redraw!

    if !g:has_job
        call ka#ui#E('Log', ['Your vim version does not support "jobs"', 1])
        return 0
    endif

    let g:jobs = get(g:, 'jobs', {})
    let args = [a:cmd] + a:000
    let initialwin = winnr()
    let opts = s:get_opts(a:cmd, a:opts)
    let name = s:set_job_name(opts.name)
    let job_opts = s:get_job_opts(name, initialwin, opts)

    let job = job_start(opts.cmd, job_opts)

    if opts.listwin is# 'l'
        call setloclist(initialwin, [], 'r')
        call setloclist(initialwin, [], 'a', {'title': opts.cmd})
    elseif opts.listwin is# 'q'
        call setqflist([], 'r')
        call setqflist([], 'a', {'title': opts.cmd})
    endif

    if opts.realtime
        if opts.listwin is# 'l'
            lopen
        elseif opts.listwin is# 'q'
            copen
        endif
    endif

    if opts.goback && winnr() isnot# initialwin
        call s:go_to_win(initialwin)
    endif

    let g:jobs[name] = {
                \   'args'   : args,
                \   'cmd'    : opts.cmd,
                \   'object' : job,
                \   'listwin': opts.listwin,
                \ }
endfun
" 1}}}


fun! s:on_error(addexpr_cmd, channel, msg) abort " {{{1
    silent execute printf('%saddexpr "%s"', a:addexpr_cmd, escape(a:msg, '"'))
    silent execute printf('%sbottom "%s"', a:addexpr_cmd, escape(a:msg, '"'))
endfun
" 1}}}

fun! s:on_out(addexpr_cmd, channel, msg) abort " {{{1
    silent execute printf('%saddexpr "%s"', a:addexpr_cmd, escape(a:msg, '"'))
    silent execute printf('%sbottom "%s"', a:addexpr_cmd, escape(a:msg, '"'))
endfun
" 1}}}

fun! s:on_exit(name, silent, listwin, initialwin, goback, job, exit_status) abort " {{{1
    " Note that when using the quickfix/locallist, the output is parsed with
    " the global errorformat.

    let name = s:get_job_name(a:job)
    let j = g:jobs[a:name]

    if !a:silent
        let log_args = a:exit_status
                    \ ? ['exit status ' . a:exit_status, 1]
                    \ : ['finished', 2]
        call ka#ui#E('Log', ['Job [' . name . ']: ' . log_args[0], log_args[1]])
    endif

    if !empty(a:listwin)
        if a:listwin is# 'q' && !empty(getqflist())
            copen
        elseif a:listwin is# 'l' && !empty(getloclist(a:initialwin))
            lopen
        endif

        if a:goback && winnr() isnot# a:initialwin
            call s:go_to_win(a:initialwin)
        endif
    endif

    unlet! g:jobs[a:name]
endfun
" 1}}}


fun! s:jobs_running() abort " {{{1
    if exists('g:jobs')
        return 1
    else
        call ka#ui#E('Log', ['Job: No jobs running'])
        return 0
    endif
endfun
" 1}}}

fun! s:exists_job(job) abort " {{{1
    if has_key(g:jobs, a:job)
        return 1
    else
        call ka#ui#E('Log', ['Job: No "' . a:job . '" found'])
        return 0
    endif
endfun
" 1}}}

fun! s:get_opts(cmd, opts) abort " {{{1
    let name = split(a:cmd)[0]
    let cmd = join(map(split(a:cmd), 'expand(v:val)'))
    let opts = extend({
                \   'silent'  : 0,
                \   'listwin' : 'q',
                \   'goback'  : 1,
                \   'realtime': 0,
                \   'std'     : 'out,err',
                \ }, copy(a:opts), 'force')

    return extend({
                \   'name': name,
                \   'cmd' : cmd
                \ }, opts)
endfun
" 1}}}

fun! s:get_job_opts(name, initialwin, opts, ...) abort " {{{1
    let job_opts = {}
    let addexpr_c = a:opts.listwin is# 'q' ? 'c' : 'l'

    if !empty(a:opts.listwin)
        if a:opts.std =~# 'out'
            let job_opts = extend(job_opts, {
                        \   'out_cb' : function('s:on_out', [addexpr_c])
                        \ })
        endif
        if a:opts.std =~# 'err'
            let job_opts = extend(job_opts, {
                        \   'err_cb' : function('s:on_error', [addexpr_c])
                        \ })
        endif
    endif
    let job_opts = extend(job_opts, {
                \   'exit_cb': function('s:on_exit', [
                \       a:name, a:opts.silent, a:opts.listwin, a:initialwin, a:opts.goback
                \   ])
                \ })

    return job_opts
endfun
" 1}}}

fun! s:set_job_name(name) abort " {{{1
    " If a job 'foo' already exist, we add a count (foo__count) until having a
    " non existing job's name.

    let name = a:name
    if has_key(g:jobs, name)
        let i = 1
        while has_key(g:jobs, name)
            let name = name =~# '__\d\+$'
                        \ ? substitute(name, '\d\+$', i, '')
                        \ : name . '__' . i
            let i += 1
        endwhile
    endif
    return name
endfun
" 1}}}

fun! s:go_to_win(win) abort " {{{1
    silent execute a:win . 'wincmd w'
endfun
" 1 }}}

fun! s:get_job_name(job) abort " {{{1
    for n in keys(g:jobs)
        if g:jobs[n].object is# a:job
            return n
        endif
    endfor
endfun
" 1 }}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
