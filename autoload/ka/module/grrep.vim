" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ka#module#grrep#grep(...) abort " {{{1
    " a:1: query if non empty
    " a:2: use regex
    " a:3: use visual/motion ('v', 'm')

    let q = get(a:, 1, '')
    let use_regex = get(a:, 2, 0)
    let selection = get(a:, 3, 0)

    if empty(q)
        if type(selection) is# v:t_string
            let q = selection is# 'v'
                        \ ? ka#selection#get_visual_selection()
                        \ : ka#selection#get_motion_result()
        else
            let inp_msg = use_regex
                        \ ? 'grrep[reg]>'
                        \ : 'grrep>'
            echohl ModeMsg | let q = input(inp_msg . ' ') | echohl None
        endif
    endif

    " note that those flags are for ag/rg only
    if use_regex
        let old_grepprg = &grepprg
        let &grepprg = substitute(&grepprg, '-SF', '-S', '')
    endif

    if !empty(q)
        let [query, path] = matchlist(q, '\v^(".*"|\S+)%(\s+(\f+)$)?')[1:2]
        let query = escape(query, '%#')
        if empty(path)
            let path = '.'
        endif

        if g:has_job
            let cmd = printf('%s %s %s', &grepprg, query, path)
            call ka#job#start(cmd, {'realtime': 1, 'std': 'out'})
        else
            " Revert escaping
            let query = substitute(query, '\#', '#', 'g')
            let query = substitute(query, '\\%', '%', 'g')
            silent execute 'grep! "' . query . '" ' . path
            botright cwindow 10 | wincmd p
        endif
    endif

    if use_regex
        let &grepprg = old_grepprg
    endif
endfun
" 1}}}

fun! ka#module#grrep#grep_motion(...) abort " {{{1
    call ka#module#grrep#grep('', 0, 'm')
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:

