" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-09-24
" ==============================================================


fun! ka#module#autoformat#run(start, end, formatters) abort " {{{1
    let cmd = get(a:formatters, &ft, '')
    if empty(cmd)
        call s:echo('No formatter found for "' . &ft . '"')
        return
    endif
    let executable = split(cmd)[0]
    if !executable(executable)
        call s:echo('"' .executable . '" was not found')
        return
    endif

    let pos = getpos('.')
    let buf_nr = bufnr('%')
    let msg = 'Formatting using "' . executable . '" '
    call s:echo(msg)
    call setbufvar(buf_nr, 'ctx', {
                \   'cmd': cmd,
                \   'msg': msg,
                \   'start': a:start,
                \   'end': a:end,
                \   'std_out': [],
                \   'err_out': []
                \ })
    call job_start(cmd, {
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
    redraw
    call s:echo(ctx.msg)
    if !empty(ctx.err_out)
        call s:echo_after('[ERR]', 'error')
        call setloclist(win_nr, [], 'r', {
                    \   'title': ctx.cmd,
                    \   'lines': ctx.err_out
                    \ })
        lopen | wincmd p
    else
        call s:echo_after('[OK]', 'question')
        let pos = getpos('.')
        silent execute printf('%d,%ddelete_', ctx.start, ctx.end)
        if getloclist(win_nr, {'title': ''}).title is# ctx.cmd
            call setloclist(win_nr, [], 'r')
            lclose
        endif
        call append(ctx.start - 1, ctx.std_out)
        call setpos('.', pos)
    endif
endfun
" 1}}}


fun! s:echo(msg) abort " {{{1
    echohl ModeMsg
    echon '[AutoFormat] '
    echohl None
    echon a:msg
endfun
" 1}}}

fun! s:echo_after(msg, type) abort " {{{1
    execute 'echohl ' . a:type
    echon a:msg
    echohl None
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
