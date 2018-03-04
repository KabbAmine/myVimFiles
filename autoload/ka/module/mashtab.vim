" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-04
" ==============================================================


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DESCRIPTION
" A simple vim completion engine using timers() and external grep programs if
" they exist.

" USAGE
" Chain & list all possible completion by mashing <Tab>

" REQUIREMENTS
" has('timers') && has('lambda')
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Utilities {{{1
let s:has_ultisnips = g:did_plugin_ultisnips ? 1 : 0
let s:grepper = executable('rg') ? 'rg --no-messages -Nio' :
            \ executable('ag') ? 'ag --silent --nonumber -io' :
            \ executable('grep') ? 'grep -io -E' :
            \ ''
" 1}}}

" ==========================================================
" 	        	Main
" ==========================================================

function! ka#module#mashtab#Complete() " {{{1
    try
        call s:SetConfig()
        return s:Tab()
    catch
        call s:Echo(v:exception, 'Error', 1)
        return ''
    endtry
endfunction
" 1}}}

function! s:SetConfig() abort " {{{1
    let g:mashtab_custom_sources = get(g:, 'mashtab_custom_sources', {})
    let g:mashtab_custom_sources.path = get(g:mashtab_custom_sources, 'path', 1)
    let g:mashtab_custom_sources.spell = get(g:mashtab_custom_sources, 'spell', 1)
    let g:mashtab_custom_sources.kspell = get(g:mashtab_custom_sources, 'kspell', 1)
    let g:mashtab_custom_sources.dict = get(g:mashtab_custom_sources, 'dict', 1)
    let g:mashtab_custom_sources.buffer = get(g:mashtab_custom_sources, 'buffer', 1)
    let g:mashtab_custom_sources.line = get(g:mashtab_custom_sources, 'line', 1)

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
                \   'vim'       : '\v(<SID>)?\k*[^/]$'
                \ }, 'keep')
endfunction
" 1}}}

function! s:Tab() abort " {{{1
    let l:def_completions = has_key(g:mashtab_ft_chains, &ft)
                \ ? g:mashtab_ft_chains[&ft]
                \ : has_key(g:mashtab_ft_chains, '_')
                \ ? g:mashtab_ft_chains._
                \ : ['path', 'ulti', 'spell', 'kspell', 'omni', 'user', 'dict', 'buffer', 'line']

    let l:to_complete = strpart(getline('.'), 0, col('.')-1)
    let l:keys = ""
    let l:completions = []
    let s:last_completion = get(s:, 'last_completion', 'tab')

    if !pumvisible() && !exists('s:no_candidates')
        let s:last_completion = 'tab'
    endif

    let l:last_completion_i = index(l:def_completions, s:last_completion)
    if l:last_completion_i !=# -1 || l:last_completion_i <# len(l:def_completions) - 1
        let l:from = l:last_completion_i + 1
        let l:completions = l:from <# len(l:def_completions)
                    \ ? l:def_completions[l:from :]
                    \ : []
    endif

    if empty(l:completions)
        unlet! s:last_completion s:no_candidates
        " Close the pmenu
        return pumvisible() ? "\<C-e>" : ''
    endif

    for l:c in (['tab'] + l:completions)
        if !empty(l:keys)
            break
        elseif s:last_completion ==# l:c && s:last_completion !=# 'tab'
            continue
        else
            " For debugging
            " call s:Echo('[' . l:c . ']', 'Normal', 1)
            let l:f = 's:Complete' . toupper(l:c[0]) . l:c[1:]
            let l:keys = call(l:f, [l:to_complete])
            let s:last_completion = l:c
        endif
    endfor

    if s:last_completion ==# 'tab'
        return l:keys
    else
        call timer_start(200, {t -> s:HasPopped()})
        call timer_start(150, {t -> s:Complete(l:keys)})
        return ''
    endif
endfunction
" 1}}}

function! s:Complete(keys) abort " {{{1
    if type(a:keys) ==# type([])
        " e.g. a:keys = [fun, list_of_params]
        call call(a:keys[0], a:keys[1])
    else
        " e.g. a:keys = "\<C-x>s"
        call feedkeys(a:keys)
    endif
endfunction
" 1}}}

function! s:HasPopped() abort " {{{1
    if !pumvisible() && exists('s:last_completion')
        " For debugging
        " call s:Echo('No [' . s:last_completion . ']', 'Comment')
        let s:no_candidates = 1
        return s:Tab()
    else
        unlet! s:no_candidates
    endif
endfunction
" 1}}}

" ==========================================================
" 	        Completion's functions
" ==========================================================

function! s:CompleteTab(to_complete) abort " {{{1
    return a:to_complete =~# '\v^\s*((\\)?\|?)?\s*$' ? "\<Tab>" : ''
endfunction
" 1}}}

function! s:CompletePath(to_complete) abort " {{{1
    if a:to_complete =~# '\f\+/\?$'
        return g:mashtab_custom_sources.path
                \ ? ['s:SourcePath', [a:to_complete]]
                \ : "\<C-x>\<C-f>"
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteUlti(to_complete) abort " {{{1
    if s:has_ultisnips && s:IsAnUltisnipsSnippet() && a:to_complete =~# '\w\{1,\}$'
        return ['s:SourceUltisnips', [a:to_complete]]
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteKspell(to_complete) abort " {{{1
    " \S used here for supporting non ASCII characters.
    if &spell && a:to_complete =~# '\S\{2,\}$'
        return g:mashtab_custom_sources.kspell && !empty(s:grepper)
                    \ ? ['s:SourceKSpell', [a:to_complete]]
                    \ : "\<C-x>\<C-k>"
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteSpell(to_complete) abort " {{{1
    " See previous function for why do we use \S.
    if &spell && a:to_complete =~# '\S\+$' && spellbadword(a:to_complete) !=# ['', '']
        return g:mashtab_custom_sources.spell
                \ ? ['s:SourceSpell', [a:to_complete]]
                \ : "\<C-x>s"
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteOmni(to_complete) abort " {{{1
    return !empty(&l:omnifunc) && has_key(g:mashtab_patterns.omni, &ft) && a:to_complete =~# g:mashtab_patterns.omni[&ft]
                \ ? "\<C-x>\<C-o>" : ''
endfunction
" 1}}}

function! s:CompleteUser(to_complete) abort " {{{1
    return has_key(g:mashtab_patterns.user, &ft) && a:to_complete =~# g:mashtab_patterns.user[&ft]
                \ ? "\<C-x>\<C-u>" : ''
endfunction
" 1}}}

function! s:CompleteDict(to_complete) abort " {{{1
    if !empty(&dictionary)
        return g:mashtab_custom_sources.dict
                    \ ? ['s:SourceDict', [a:to_complete]]
                    \ : "\<C-x>\<C-k>"
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteBuffer(to_complete) abort " {{{1
    if a:to_complete =~# '\w\+'
        return g:mashtab_custom_sources.buffer
                \ ? ['s:SourceBuffer', [a:to_complete]]
                \ : "\<C-x>\<C-n>"
    else
        return ''
    endif
endfunction
" 1}}}

function! s:CompleteLine(to_complete) abort " {{{1
    if a:to_complete =~# '^\s*\S\+.*$'
        return g:mashtab_custom_sources.line
                \ ? ['s:SourceLine', [a:to_complete]]
                \ : "\<C-x>\<C-l>"
    else
        return ''
    endif
endfunction
" 1}}}

" ==========================================================
" 	                Sources
" ==========================================================

function! s:SourceUltisnips(to_complete) abort " {{{1
    let l:all_snips = s:all_ulti_snips
    unlet! s:all_ulti_snips
    let l:snip_prefix = matchstr(a:to_complete, '\S\+$')

    call complete(col('.') - len(l:snip_prefix), map(keys(l:all_snips), '{
                    \   "word": v:val,
                    \   "menu": "[ulti]",
                    \   "info": l:all_snips[v:val]
                    \ }'))
    return ''
endfunction
" 1}}}

function! s:SourcePath(to_complete) abort " {{{1
    let l:path = matchstr(a:to_complete, '\f\+$')
    let l:contain_tilde = l:path =~# '\~' ? 1 : 0
    let l:parent = l:path =~# '/$'
                \ ? l:path : fnamemodify(l:path, ':p:h') . '/'
    let l:parent = l:path =~# '//$' ? l:path[:-2] : l:path
    let l:all_files = glob(l:parent . '*', '', 1)

    call complete(col('.') - len(l:path), map(l:all_files, '{
                    \   "word": !l:contain_tilde ? v:val : substitute(v:val, $HOME, "~", ""),
                    \   "menu": "[" . getftype(v:val) . "]",
                    \ }'))
    return ''
endfunction
" 1}}}

function! s:SourceKSpell(to_complete) abort " {{{1
    if !exists('s:complete_spell') || (exists('s:complete_spell') && (s:complete_spell.lang !=# &l:spelllang || !filereadable(s:complete_spell.tmp_file)))
        let l:winview = winsaveview()

        " Save spelldump content to a temporary file the 1st time can be slow
        " sometimes.
        let s:complete_spell = {
                    \   'lang'    : &l:spelllang,
                    \   'tmp_file': tempname()
                    \ }
        let l:pos = getpos('.')
        silent spelldump
        let l:buf = bufnr('%')
        call writefile(getline(2, line('$')), s:complete_spell.tmp_file)
        silent wincmd p
        silent execute l:buf . 'bwipeout!'
        call setpos('.', l:pos)
        call winrestview(l:winview)
    endif

    " We use \S instead of \w to temporary handle non-ascii characters.
    let l:word = matchstr(a:to_complete, '\S\+$')
    let l:words = s:Grep('^' . l:word . '.*$', s:complete_spell.tmp_file)

    " Be sure to remove region indices if they exist (word/==>12<==)
    call complete(col('.') - len(l:word), map(l:words, '{
                \   "word" : s:MatchCase(l:word, split(v:val, "/")[0]),
                \   "menu" : "[kspell]"
                \ }'))
    return ''
endfunction
" 1}}}

function! s:SourceSpell(to_complete) abort " {{{1
    let l:word = matchstr(a:to_complete, '\S\+$')
    let l:all_suggestions = spellsuggest(l:word)

    call complete(col('.') - len(l:word), map(l:all_suggestions, '{
                    \   "word": v:val,
                    \   "menu": "[spell]"
                    \ }'))
    return ''
endfunction
" 1}}}

function! s:SourceBuffer(to_complete) abort " {{{1
    let l:cl = line('.')
    let l:word = matchstr(a:to_complete, '\k\+$')
    let l:words = []
    for l:w in split(join(s:GetLines(), "\n"), '\W\+')
        if l:w !=# l:word && l:w =~# '^\c\V' . escape(l:word, '%') && len(l:w) ># 1
            call add(l:words, {
                        \   'word': s:MatchCase(l:word, l:w),
                        \   'menu': '[buffer]'
                        \ })
        endif
    endfor

    call complete(col('.') - len(l:word), l:words)
    return ''
endfunction
" 1}}}

function! s:SourceDict(to_complete) abort " {{{1
    let l:word = matchstr(a:to_complete, '\k\+$')
    let l:words = []
    for l:f in split(&dictionary, ',')
        if !filereadable(l:f)
            continue
        endif
        let l:file_name = fnamemodify(l:f, ':t:r')

        let l:words += map(readfile(l:f),
                    \ {i, v -> {
                    \   'word': (v =~# '\c^\V' . l:word ? s:MatchCase(l:word, v) : ''),
                    \   'menu': '[' . l:file_name . ']'
                    \ }})
    endfor

    call complete(col('.') - len(l:word), l:words)
    return ''
endfunction
" 1}}}

function! s:SourceLine(to_complete) abort " {{{1
    let l:all_lines = s:GetLines()
    let l:line_without_start_spaces = substitute(a:to_complete, '^\s*', '', '')
    let l:indent = matchstr(a:to_complete, '^\s*')
    let l:lines = []
    for l:l in l:all_lines
        " Trim starting whitespace characters.
        let l:l = substitute(l:l, '^\s*', '', '')
        " The line could contain '\' so we escape it coz it can be interpreted
        " as a regex atom.
        if l:l !=# l:line_without_start_spaces && l:l =~# '^\s*\c\V' . escape(l:line_without_start_spaces, '\')
            call add(l:lines, {
                        \   'word': l:indent . s:MatchCase(l:line_without_start_spaces, l:l),
                        \   'menu': '[line]'
                        \ })
        endif
    endfor

    call complete(col('.') - len(a:to_complete), l:lines)
    return ''
endfunction
" 1}}}

" ==========================================================
" 	                Helpers
" ==========================================================

function! s:IsAnUltisnipsSnippet() abort " {{{1
    " The s:all_ulti_snips will be used in the ultisnips source.
    let s:all_ulti_snips = UltiSnips#SnippetsInCurrentScope()
    return s:all_ulti_snips !=# {} ? 1 : 0
endfunction
" 1}}}

function! s:MatchCase(str_in, str_out) abort " {{{1
    let l:res = ''
    for l:i in range(0, len(a:str_in) - 1)
        if !empty(a:str_out[l:i])
            let l:res .= a:str_in[l:i] =~# '\u'
                        \ ? toupper(a:str_out[l:i])
                        \ : a:str_out[l:i]
        endif
    endfor
    return l:res . a:str_out[len(l:res):]
endfunction
" 1}}}

function! s:Echo(msg, hi_group, ...) abort " {{{1
    let l:echo_cmd = 'echo' . (exists('a:1') ? 'msg' : '')
    let l:msg = '[mashtab] ' . a:msg

    silent execute 'echohl ' . a:hi_group
    if exists('a:1') | echomsg l:msg | else | echo l:msg | endif
    echohl None
endfunction
" 1}}}

function! s:Grep(pattern, file) abort " {{{1
    return systemlist(printf('%s "%s" %s', s:grepper, a:pattern, a:file))
endfunction
" 1}}}

function! s:GetLines() abort " {{{1
    let l:cl = line('.')
    return getline(l:cl + 1, '$') + getline(1, l:cl)
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
