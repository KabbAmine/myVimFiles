" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-17
" ==============================================================


fun! ka#job#complete(arg, cmd, pos) abort " {{{1
    let opts = {
                \   'expand'           : [0, 1],
                \   'goback'           : [0, 1],
                \   'listwin'          : ['q', 'l'],
                \   'openwin'          : [0, 1],
                \   'realtime'         : [0, 1],
                \   'silent'           : [0, 1],
                \   'std'              : ['out,err', 'out', 'err'],
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
        elseif a:arg =~# '\f\+$'
            " Or file(s)/path(s)
            let files = getcompletion(a:arg, 'file')
            if a:arg =~# '\~'
                let files = map(copy(files), 'fnamemodify(v:val, ":~")')
            endif
            return filter(files, {i, v -> v =~ escape(v, '~')})
        else
            " Or shell commands
            return filter(getcompletion('', 'shellcmd'), 'v:val =~ a:arg')
        endif
    endif
endfun
" 1}}}

fun! ka#job#start_from_cmdline(args) abort " {{{1
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
    call call('ka#job#start', [cmd] + [opts])
endfun
" 1}}}

fun! ka#job#start(cmd, opts, ...) abort " {{{1
    " redraw!

    if !g:has_job
        call s:echo('Your vim version does not support "jobs"', 'error')
        return 0
    endif

    let g:jobs = get(g:, 'jobs', {})
    let args = [a:cmd, a:opts]
    let initialwin = winnr()
    let After_exit_cb = exists('a:1') ? a:1 : ''
    let opts = s:get_opts(a:cmd, a:opts)
    let name = s:set_job_name(opts.name)
    let job_opts = s:get_job_opts(name, initialwin, opts, After_exit_cb)
    let cmd = opts.expand
                \ ? join(map(split(opts.cmd), 'expand(v:val)'))
                \ : opts.cmd

    let job = job_start(cmd, job_opts)

    if opts.listwin is# 'l'
        call setloclist(initialwin, [], 'r', {'title': cmd, 'items': []})
    elseif opts.listwin is# 'q'
        call setqflist([], 'r', {'nr': 0, 'title': cmd, 'items': []})
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
                \   'cmd'    : cmd,
                \   'object' : job,
                \   'listwin': opts.listwin,
                \ }

    return name
endfun
" 1}}}

fun! ka#job#restart(job) abort " {{{1
    if s:jobs_running() && s:exists_job(a:job)
        let j = g:jobs[a:job]
        call job_stop(j.object, 'kill')
        call s:echo('"' . a:job . '" is restarting...')
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
        call s:echo(printf('%d/%d job(s) stopped', stopped_jobs, n_jobs))
    endif
endfun
" 1}}}

fun! ka#job#list() abort " {{{1
    if s:jobs_running()
        call s:echo('')
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

fun! ka#job#stop(job, bang) abort " {{{1
    if s:jobs_running() && s:exists_job(a:job)
        let j = g:jobs[a:job].object
        let how = a:bang is# '!' ? 'kill' : 'term'
        call job_stop(j, how)
        sleep 150m
        if job_status(j) isnot# 'run'
            call s:echo('"' . a:job . '" stopped', 'question')
        endif
    endif
endfun
" 1}}}

fun! ka#job#clean() abort " {{{1
    if s:jobs_running()
        for k in keys(g:jobs)
            if job_status(g:jobs[k].object) isnot# 'run'
                call remove(g:jobs, k)
            endif
        endfor
    endif
endfun
" 1}}}


fun! s:on_error(listwin, initialwin, channel, msg) abort " {{{1
    call s:append_to_list(a:listwin, a:initialwin, a:msg)
endfun
" 1}}}

fun! s:on_out(listwin, initialwin, channel, msg) abort " {{{1
    call s:append_to_list(a:listwin, a:initialwin, a:msg)
endfun
" 1}}}

fun! s:on_exit(name, initialwin, opts, After_exit_cb, job, exit_status) abort " {{{1
    " Note that when using the quickfix/locallist, the output is parsed with
    " the global errorformat.

    let name = s:get_job_name(a:job)
    let j = g:jobs[a:name]

    if !a:opts.silent
        let log_args = a:exit_status
                    \ ? ['finished with exit status ' . a:exit_status, 'error']
                    \ : ['finished', 'question']
        call s:echo('"' . name . '" ' . log_args[0], log_args[1])
    endif

    if a:opts.listwin =~# 'q\|l'
        let c = a:opts.listwin is# 'q' ? 'c' : 'l'
        let noempty = a:opts.listwin is# 'q'
                    \ ? !empty(getqflist())
                    \ : !empty(getloclist(a:initialwin))
        if a:opts.openwin && noempty
            silent execute c . 'open'
        endif

        if a:opts.goback && winnr() isnot# a:initialwin
            call s:go_to_win(a:initialwin)
        endif
    endif

    unlet! g:jobs[a:name]

    if a:After_exit_cb isnot# ''
        call call(a:After_exit_cb, [])
    endif
endfun
" 1}}}


fun! s:jobs_running() abort " {{{1
    if exists('g:jobs')
        return 1
    else
        call s:echo('No jobs running')
        return 0
    endif
endfun
" 1}}}

fun! s:exists_job(job) abort " {{{1
    if has_key(g:jobs, a:job)
        return 1
    else
        call s:echo('No job named "' . a:job . '" found', 'error')
        return 0
    endif
endfun
" 1}}}

fun! s:get_opts(cmd, opts) abort " {{{1
    " Description of options:
    " - expand  : expand special vim expressions
    " - goback  : go back to initial window
    " - listwin : (q)uickfix or (l)ocation list window
    " - openwin : open q/l window after job completion
    " - realtime: open q/l window and output in realtime
    " - silent  : echo or not messages
    " - std     : out/err/out,err

    let name = split(a:cmd)[0]
    let opts = extend({
                \   'expand'           : 1,
                \   'goback'           : 1,
                \   'listwin'          : 'q',
                \   'openwin'          : 1,
                \   'realtime'         : 0,
                \   'silent'           : 1,
                \   'std'              : 'err',
                \ }, copy(a:opts), 'force')

    return extend({
                \   'name': name,
                \   'cmd' : a:cmd
                \ }, opts)
endfun
" 1}}}

fun! s:get_job_opts(name, initialwin, opts, After_exit_cb) abort " {{{1
    let job_opts = {}
    " let addexpr_c = a:opts.listwin is# 'q' ? 'c' : 'l'

    if !empty(a:opts.listwin)
        if a:opts.std =~# 'out'
            let job_opts = extend(job_opts, {
                        \   'out_cb' : function('s:on_out', [a:opts.listwin, a:initialwin])
                        \ })
        endif
        if a:opts.std =~# 'err'
            let job_opts = extend(job_opts, {
                        \   'err_cb' : function('s:on_error', [a:opts.listwin, a:initialwin])
                        \ })
        endif
    endif
    let job_opts = extend(job_opts, {
                \   'exit_cb': function('s:on_exit', [
                \       a:name, a:initialwin, a:opts, a:After_exit_cb
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

fun! s:append_to_list(listwin, initialwin, msg) abort " {{{1
    if a:listwin is# 'q'
        call setqflist([], 'a', {'lines': [a:msg]})
        cbottom
    else
        call setloclist(a:initialwin, [], 'a', {'lines': [a:msg]})
        lbottom
    endif
endfun
" 1}}}

fun! s:echo(msg, ...) abort " {{{1
    let higroup = get(a:, '1', 'modemsg')
    call ka#ui#echo('[Jobs] ', a:msg, higroup)
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
