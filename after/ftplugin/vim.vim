" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last modification: 2018-11-28
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Source current file {{{1
nnoremap <buffer> <F9> :so %<CR>
" 1}}}

" Custom vim help mappings {{{1
" Those mappings are overwritten in config/plugins
nnoremap <silent> <buffer> gzz :call <SID>vim_help()<CR>
xnoremap <silent> <buffer> gzz :call <SID>vim_help('v')<CR>
nnoremap <silent> <buffer> gz <Esc>:setlocal operatorfunc=<SID>vim_help<CR>g@

fun! s:vim_help(...) abort " {{{2
    " !a:1: <cexpr>
    " a:1 = v: visual
    " else: motion

    let q = !exists('a:1')
                \ ? expand('<cexpr>')
                \ : a:1 is# 'v'
                \ ? ka#utils#get_visual_selection()
                \ : ka#utils#get_motion_result()
    let candidates = getcompletion(q, 'help')
    if len(candidates) ># 1
        redraw
        call inputsave()
        " Do not exceed the vim window height, even if we need to remove items
        let ind = inputlist(map(copy(candidates)[: &lines - 3], {
                    \   i, v -> (i + 1) . '. ' . v
                    \ }))
        call inputrestore()
        " Ensure to empty 'q' in case we cancel
        let q = ind ># 0 ? get(candidates, ind - 1, '') : ''
    endif
    if empty(q)
        return
    endif
    try
        execute 'help ' . q
    catch /^Vim\%((\a\+)\)\=:\(E149\)/
        call ka#ui#echo('[E]', v:exception, 'Error')
    endtry
endfun " 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
