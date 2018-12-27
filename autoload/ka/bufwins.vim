" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ka#bufwins#create_or_go_to_buf(buf_name, ft, split) abort " {{{1
    " Open or move to a:bufname

    let buf_win = bufwinnr(bufnr(a:buf_name))

    if buf_win isnot# -1
        silent execute buf_win . 'wincmd w'
    else
        silent execute a:split . ' ' . a:buf_name
    endif

    if !empty(a:ft)
        let &filetype = a:ft
    endif
endfun
" 1}}}

fun! ka#bufwins#move_to_buf(dir) abort " {{{1
    let cmd = a:dir ># 0 ? 'bnext!' : 'bprevious!'
    silent execute cmd
    while &l:filetype is# 'qf'
        silent execute cmd
    endwhile
endfun
" 1}}}

fun! ka#bufwins#move_in_qf(l, dir) abort " {{{1
    let [c_l, pre_cmd] = a:l is# 'q'
                \ ? [len(getqflist()), 'c']
                \ : [len(getloclist(0)), 'l']
    try
        execute c_l is# 1
                    \ ? repeat(pre_cmd, 2) . '!'
                    \ : a:dir ># 0
                    \ ? pre_cmd . 'next!'
                    \ : pre_cmd . 'previous'
        normal! zv
    catch /^Vim\%((\a\+)\)\=:\(E42\|E553\)/
        call ka#ui#echo('[E]', v:exception, 'Error')
    endtry
endfun
" 1}}}

" Move between splits & tmux " {{{1
" https://gist.github.com/mislav/5189704#gistcomment-1735600
fun! ka#bufwins#tmux_move(direction) abort
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the winnr is still the same after we moved, it is the last pane
    if wnr is# winnr()
        call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    endif
endfun
" 1}}}

fun! ka#bufwins#echo_in_buf(...) abort " {{{1
    let out = ''
    redir => out
    silent execute 'echo ' . join(a:000, '')
    redir END
    if !empty(out[1:])
        call ka#bufwins#create_or_go_to_buf('__Echo__', 'vim', 'sp')
        setlocal noswapfile buftype=nofile
        call setline(1, out[1:])
    endif
endfun
" 1}}}

fun! ka#bufwins#scratch(...) abort " {{{1
    let bufname = '__Scratch__'
    let ft = get(a:, 1, 'markdown')
    call ka#bufwins#create_or_go_to_buf(bufname, ft, 'topleft split')
    if exists('g:scratch')
        silent %delete_
        call setbufline(bufnr(bufname), 1, g:scratch)
    else
        augroup Scratch
            autocmd!
            autocmd InsertLeave,CursorHold,CursorHoldI,TextChanged __Scratch__
                        \ let g:scratch = getline(1, line('$'))
        augroup END
    endif

    setlocal noswapfile buftype=nofile
endfun
" 1}}}

fun! ka#bufwins#cmd_on_multiple_files(cmd, list_pattern, bang) abort " {{{1
    let cmd = a:cmd . a:bang
    if a:list_pattern ==# []
        execute cmd
        return
    endif
    for p in a:list_pattern
        if match(p, '\v\?|*|\[|\]') >=# 0
            " Expand wildcards only if they exist
            for f in glob(p, 0, 1)
                if filereadable(f)
                    execute cmd . ' ' . f
                endif
            endfor
        else
            " Otherwise execute the command
            execute cmd . ' ' . p
        endif
    endfor
endfun
" 1}}}

fun! ka#bufwins#cmd_on_multiple_bufs(cmd, list_pattern, bang) abort " {{{1
    let cmd = a:cmd . a:bang
    if a:list_pattern ==# []
        execute cmd
        return
    endif
    for p in a:list_pattern
        for f in getcompletion(p, 'buffer', 1)
            if bufloaded(f)
                try
                    execute cmd . ' ' . f
                catch
                    break
                endtry
            endif
        endfor
    endfor
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
