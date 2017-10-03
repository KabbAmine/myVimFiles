" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-10-03
" ==============================================================


function! ka#ui#E(fun, ...) abort " {{{1
    let l:params = exists('a:1') ? a:1 : []
    let l:return = exists('a:2') ? 1 : 0

    if l:return
        return call('s:' . a:fun, l:params)
    else
        call call('s:' . a:fun, l:params)
    endif
endfunction
" 1}}}


function! s:Log(message, ...) abort " {{{1
    " Echo message with a:1 index hi group.

    let l:t = exists('a:1') ? a:1 : 0
    let l:hi = ['WarningMsg', 'ErrorMsg', 'Question']
    execute 'echohl ' . l:hi[l:t]
    echomsg a:message
    echohl None
endfunction
" 1}}}

function! s:FlashLine(time, repeat, callback) abort " {{{1
    call timer_start(a:time, function(a:callback), {'repeat': a:repeat})
endfunction
" 1}}}

function! s:CreateOrGoTo(buf_name, ft, split,...) abort " {{{1
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


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
