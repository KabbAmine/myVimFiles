" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-09
" ==============================================================


" ==========================================================
" 	        	Main
" ==========================================================

fun! ka#module#mashtab#i() abort " {{{1
    inoremap <silent> <Plug>(mashtabTab) <C-r>=<SID>complete(1)<CR>
    inoremap <silent> <Plug>(mashtabBS) <C-h><C-r>=<SID>complete(-1)<CR>
endfun
" 1}}}

fun! s:complete(dir, ...) abort " {{{1
    " a:1: types
    " a:2: delay of triggering completion

    let args_l = []
    if exists('a:1')
        call add(args_l, a:1)
    endif
    if exists('a:2')
        call add(args_l, a:2)
    endif

    try
        call s:set_cfg()
        return a:dir ># 0
                    \ ? call('<SID>tab', args_l)
                    \ : s:backspace()
    catch
        call s:echo(v:exception, 'Error', 1)
        return ''
    endtry
endfun
" 1}}}

fun! s:set_cfg() abort " {{{1
    let g:mashtab_ft_chains = get(g:, 'mashtab_ft_chains', {})
    let g:mashtab_patterns = get(g:, 'mashtab_patterns', {})
    let g:mashtab_patterns.user = get(g:mashtab_patterns, 'user', {})
    let g:mashtab_patterns.omni = get(g:mashtab_patterns, 'omni', {})
    call extend(g:mashtab_patterns.omni, {
                \   'css'       : '\w\+\|\w\+[):;]\?\s\+\w*\|[@!]',
                \   'html'      : '<\|\s[[:alnum:]-]*',
                \   'javascript': '[^. \t]\.\w*',
                \   'php'       : '\w\+\|\[^. \t]->\w*\|\w\+::\w*',
                \   'python'    : '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*',
                \   'scss'      : '\w\+\|\w\+[):;]\?\s\+\w*\|[@!]',
                \   'vim'       : '\v%(<SID>)?\k*[^/]$'
                \ }, 'keep')
    call extend(g:mashtab_patterns.omni, {
                \   'javascript.jsx': g:mashtab_patterns.omni.javascript,
                \ }, 'keep')
endfun
" 1}}}

fun! s:tab(...) abort " {{{1
    if !exists('s:def_completions') || empty(s:def_completions)
        let s:def_completions = exists('a:1')
                    \ ? a:1
                    \ : has_key(g:mashtab_ft_chains, &ft)
                    \ ? g:mashtab_ft_chains[&ft]
                    \ : has_key(g:mashtab_ft_chains, '_')
                    \ ? g:mashtab_ft_chains._
                    \ : ['path', 'ulti', 'spell', 'kspell', 'omni',
                    \       'user', 'dict', 'buffer', 'line']
    endif
    let delay = get(a:, '2', 150)

    let to_complete = s:str_to_complete()
    let keys = ""
    let completion_chain = []
    let s:last_completion = get(s:, 'last_completion', 'tab')

    if !pumvisible() && !exists('s:no_candidates')
        let s:last_completion = 'tab'
    endif

    let completion_chain = s:def_completions[
                \ index(s:def_completions, s:last_completion) + 1
                \ :]
    " Close the pmenu when no more items in our chain
    if empty(completion_chain)
        unlet! s:last_completion s:no_candidates s:def_completions
        return s:close_pmenu_keys()
    endif

    " Set the next completion item to use
    for c in (['tab'] + completion_chain)
        if !empty(keys)
            break
        elseif s:last_completion is# c && s:last_completion isnot# 'tab'
            continue
        else
            let keys = s:get_completion_function(c, to_complete)
            let s:last_completion = c
        endif
    endfor

    if s:last_completion is# 'tab'
        return keys
    else
        call timer_start(delay, {t -> s:trigger_completion(keys)})
        call timer_start(delay + 50, {t -> s:after_completion()})
        return ''
    endif
endfun
" 1}}}

fun! s:backspace() abort " {{{1
    if exists('s:last_completion')
        let keys = s:get_completion_function(
                    \   s:last_completion, s:str_to_complete()
                    \ )
        call s:trigger_completion(keys)
    endif
    return ''
endfun
" 1}}}

fun! s:get_completion_function(comp, to_complete) abort " {{{1
    let f = 's:complete_' . a:comp
    return call(f, [a:to_complete])
endfun
" 1}}}

fun! s:str_to_complete() abort " {{{1
    return strpart(getline('.'), 0, col('.') - 1)
endfun
" 1}}}

fun! s:trigger_completion(keys) abort " {{{1
    " e.g. a:keys = [fun, list_of_params]
    " e.g. a:keys = "\<C-x>s"

    if mode() is# 'i'
        if type(a:keys) is# v:t_list
            call call(a:keys[0], a:keys[1])
        else
            call feedkeys(a:keys)
        endif
    endif
endfun
" 1}}}

fun! s:after_completion() abort " {{{1
    " If the pmenu do not appear, that means that the current item in our
    " completion chain did not return candidates, so we execute the next item
    " in our chain.
    " But if the pmenu popped, there is nothing to do apart deleting the
    " 'no_candidates' flag if it exists.
    if !pumvisible() && exists('s:last_completion')
        " For debugging
        " call s:echo('No [' . s:last_completion . ']', 'Comment')
        let s:no_candidates = 1
        return s:tab()
    else
        unlet! s:no_candidates
    endif
endfun
" 1}}}

fun! s:close_pmenu_keys() abort " {{{1
    return pumvisible() ? "\<C-e>" : ''
endfun
" 1}}}

" ==========================================================
" 	        Completion's functions
" ==========================================================

fun! s:complete_tab(to_complete) abort " {{{1
    return a:to_complete =~# '\v^\s*%(%(\\)?\|?)?\s*$' ? "\<Tab>" : ''
endfun
" 1}}}

fun! s:complete_path(to_complete) abort " {{{1
    " Trigger the completion for the following patterns:
    " /file, ./file, ../fi/le

    if a:to_complete =~# '\%(\.\{,2\}\)\?/\%(\f\+\)\?$'
        return "\<C-x>\<C-f>"
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_ulti(to_complete) abort " {{{1
    if g:did_plugin_ultisnips
                \ && s:is_an_ultisnips_snippet() 
                \ && a:to_complete =~# '\S\{1,\}$'
        return ['s:source_ultisnips', [a:to_complete]]
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_kspell(to_complete) abort " {{{1
    " \S used here for supporting non ASCII characters.
    if &spell && a:to_complete =~# '\S\{2,\}$'
        return "\<C-x>\<C-k>"
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_spell(to_complete) abort " {{{1
    " See previous function for why do we use \S.
    if &spell
                \ && a:to_complete =~# '\S\+$
                \ && spellbadword(a:to_complete) isnot# ['', '']
        return "\<C-x>s"
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_omni(to_complete) abort " {{{1
    return !empty(&omnifunc)
                \ && has_key(g:mashtab_patterns.omni, &ft)
                \ && a:to_complete =~# g:mashtab_patterns.omni[&ft]
                \ ? "\<C-x>\<C-o>" : ''
endfun
" 1}}}

fun! s:complete_user(to_complete) abort " {{{1
    return has_key(g:mashtab_patterns.user, &ft)
                \ && a:to_complete =~# g:mashtab_patterns.user[&ft]
                \ ? "\<C-x>\<C-u>" : ''
endfun
" 1}}}

fun! s:complete_dict(to_complete) abort " {{{1
    if !empty(&dictionary)
        return "\<C-x>\<C-k>"
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_buffer(to_complete) abort " {{{1
    if a:to_complete =~# '\w\+'
        return "\<C-x>\<C-n>"
    else
        return ''
    endif
endfun
" 1}}}

fun! s:complete_line(to_complete) abort " {{{1
    if a:to_complete =~# '^\s*\S\+.*$'
        return "\<C-x>\<C-l>"
    else
        return ''
    endif
endfun
" 1}}}

" ==========================================================
" 	                Sources
" ==========================================================

fun! s:source_ultisnips(to_complete) abort " {{{1
    " Knowing here for sure that our pattern in expandable, we reget all the
    " snippets in case the s:all_utli_snipts was lost.
    let all_snips = exists('s:all_ulti_snips')
                \ ? s:all_ulti_snips
                \ : UltiSnips#SnippetsInCurrentScope()
    unlet! s:all_ulti_snips
    let snip_prefix = matchstr(a:to_complete, '\S\+$')

    call complete(col('.') - len(snip_prefix), map(keys(all_snips), '{
                    \   "word" : v:val,
                    \   "menu" : "[ulti] " . all_snips[v:val],
                    \   "info" : all_snips[v:val],
                    \ }'))
    return ''
endfun
" 1}}}

" ==========================================================
" 	                Helpers
" ==========================================================

fun! s:is_an_ultisnips_snippet() abort " {{{1
    " To avoid re-executing the UltiSnips#SnippetsInCurrentScope function, we
    " store the snippets in a variable that will be used in the ultisnips
    " source.
    let s:all_ulti_snips = UltiSnips#SnippetsInCurrentScope()
    return s:all_ulti_snips isnot# {} ? 1 : 0
endfun
" 1}}}

fun! s:echo(msg, hi_group, ...) abort " {{{1
    let echo_cmd = 'echo' . (exists('a:1') ? 'msg' : '')

    silent execute 'echohl ' . a:hi_group
    if exists('a:1')
        echomsg '[mashtab] ' . a:msg
        echohl None
    else
        echon '[mashtab] '
        echohl None
        echon a:msg
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
