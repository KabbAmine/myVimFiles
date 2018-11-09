" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-09
" ==============================================================


fun! ka#module#fixnformat#run(start, end, formatters) abort " {{{1
    let cmd = get(a:formatters, &ft, '')
    if empty(cmd)
        call s:echo('No formatter found for "' . &ft . '"')
        return v:null
    endif

    let cmds_l = type(cmd) is# v:t_list ? cmd : [cmd]
    let [valid_cmds_l, executables, no_executables] =
                \   s:get_cmd_str_and_executables(cmds_l)

    let err_msg = !empty(no_executables)
                \ ? 'executable(s) "' . join(no_executables, ', ')
                \   . '" not found '
                \ : ''

    " Stop if no executables at all
    if len(no_executables) is# len(cmds_l)
        call s:echo_err(err_msg)
        return v:null
    endif

    let pos = getpos('.')
    let buf_nr = bufnr('%')
    let msg = join(executables, ' | ') . ' '
    " TODO: windows
    let cmd_str = printf('%s -c "%s"',
                \   $SHELL,
                \   join(map(valid_cmds_l, {i, v -> escape(v, '"')}), ' | ')
                \ )
    call s:echo(msg)

    call setbufvar(buf_nr, 'ctx', {
                \   'cmd': cmd_str,
                \   'msg': msg,
                \   'err_msg': err_msg,
                \   'start': a:start,
                \   'end': a:end,
                \   'initial_lines': getline(a:start, a:end),
                \   'marks': s:get_marks(),
                \   'std_out': [],
                \   'err_out': []
                \ })
    call job_start(cmd_str, {
                \   'in_io': 'buffer',
                \   'in_buf': buf_nr,
                \   'in_top': a:start,
                \   'in_bot': a:end,
                \   'out_cb': function('<SID>on_out', [buf_nr]),
                \   'err_cb': function('<SID>on_err', [buf_nr]),
                \   'exit_cb': function('<SID>on_exit', [buf_nr])
                \ })
endfun
" 1}}}


fun! s:on_out(buf_nr, ch, msg) abort " {{{1
    let ctx = getbufvar(a:buf_nr, 'ctx')
    call add(ctx.std_out, a:msg)
    call setbufvar(a:buf_nr, 'ctx', ctx)
endfun
" 1}}}

fun! s:on_err(buf_nr, ch, msg) abort " {{{1
    let ctx = getbufvar(a:buf_nr, 'ctx')
    call add(ctx.err_out, a:msg)
    call setbufvar(a:buf_nr, 'ctx', ctx)
endfun
" 1}}}

fun! s:on_exit(buf_nr, job, ex_st) abort " {{{1
    let ctx = getbufvar(a:buf_nr, 'ctx')
    let win_nr = bufwinnr(a:buf_nr)
    let [error_msgs, post_msgs] = [[], []]

    if !empty(ctx.err_msg)
        let error_msgs += [ctx.err_msg]
        call add(post_msgs, {
                    \   'txt': '[ERR EXEC]',
                    \   'hg': 'error',
                    \ })
    endif

    if !empty(ctx.err_out)
        if empty(error_msgs)
            let error_msgs += ctx.err_out
        else
            let error_msgs += ['---'] + ctx.err_out
        endif
        call add(post_msgs, {
                    \   'txt': '[ERR]',
                    \   'hg': 'error',
                    \ })
    else
        let pos = getpos('.')
        if ctx.std_out !=# ctx.initial_lines
            silent execute printf('%d,%ddelete_', ctx.start, ctx.end)
            " A simple trick to avoid inserting an empty line after the
            " 'delete' command
            call setline(ctx.start, ctx.std_out[0])
            call append(ctx.start, ctx.std_out[1:])
            let post_msgs = [{
                        \   'txt': '[OK]',
                        \   'hg': 'question'
                        \ }] + post_msgs
        else
            let post_msgs = [{
                        \   'txt': '[OK - no changes]',
                        \   'hg': 'question'
                        \ }] + post_msgs
        endif

        call setpos('.', pos)
    endif

    call s:echo_final_msg(error_msgs, ctx.msg, post_msgs)
    call s:set_marks(ctx.marks)
    " Use a delay before cleaning the buf-local variable in case our job is
    " still running
    call timer_start(2000, {t -> setbufvar(a:buf_nr, 'ctx', {})})
endfun
" 1}}}


fun! s:get_cmd_str_and_executables(cmds_l) abort " {{{1
    let [executables, no_executables] = [[], []]
    let valid_cmds_l = []

    for cmd in a:cmds_l
        let executable = split(cmd)[0]
        if !executable(executable)
            call add(no_executables, executable)
        else
            call add(executables, executable)
            call add(valid_cmds_l, cmd)
        endif
    endfor
    return [valid_cmds_l, executables, no_executables]
endfun
" 1}}}

fun! s:get_marks() abort " {{{1
    let marks = {}
    for m in range(0, 9)
        let pos = getpos("'" . m)
        if pos !=# [0, 0, 0, 0]
            let marks[m] = pos
        endif
    endfor
    " a-z
    for m in map(copy(range(97, 122)), 'nr2char(v:val)')
        let pos = getpos("'" . m)
        if pos !=# [0, 0, 0, 0]
            let marks[m] = pos
        endif
    endfor
    return marks
endfun
" 1}}}

fun! s:set_marks(marks) abort " {{{1
   for m in keys(a:marks)
       call setpos("'" . m, a:marks[m])
   endfor
endfun
" 1}}}

fun! s:echo(msg) abort " {{{1
    call ka#ui#echo('[fixnformat]', a:msg, 'modemsg')
endfun
" 1}}}

fun! s:echo_err(msg) abort " {{{1
    call ka#ui#echo('[fixnformat]', a:msg, 'error', 1)
endfun
" 1}}}

fun! s:echo_after(msg, type) abort " {{{1
    execute 'echohl ' . a:type
    echon a:msg
    echohl None
endfun
" 1}}}

fun! s:echo_final_msg(err_msgs, pre_msg, post_msgs) abort " {{{1
    if !empty(a:err_msgs)
        call s:echo_err('--- START ---')
        for e in a:err_msgs
            call s:echo_err(e)
        endfor
        call s:echo_err('--- END ---')
        redraw
    endif

    call s:echo(a:pre_msg)
    for msg in a:post_msgs
        call s:echo_after(msg.txt . ' ', msg.hg)
    endfor

    if !empty(a:err_msgs)
        call s:echo_after('(see :messages)', 'error')
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
