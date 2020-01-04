" ========== Custom statusline + mappings ======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2020-01-05

" The used plugins are (They are not mandatory):
" * Fugitive
" * Signify
" * ALE
" * coc

" ========== CONFIGURATION =====================================

" {{{1
let s:sl  = {
            \   'separator': '︱',
            \   'ignore': ['pine', 'vfinder', 'qf', 'undotree', 'diff'],
            \   'apply': {},
            \   'checker': get(g:, 'checker', {
            \       'error_sign'   : '⨉',
            \       'warning_sign' : '⬥',
            \       'success_sign' : '',
            \       'error_group'  : 'Error',
            \       'warning_group': 'Function',
            \   }),
            \   'colors': {
            \       'background'      : ['#2f343f', 'none'],
            \       'backgroundDark'  : ['#191d27', '16'],
            \       'backgroundLight' : ['#464b5b', '59'],
            \       'green'           : ['#2acf2a', '40'],
            \       'main'            : ['#5295e2', '68'],
            \       'red'             : ['#f01d22', '160'],
            \       'text'            : ['#cbcbcb', '251'],
            \       'textDark'        : ['#8c8c8c', '244'],
            \   },
            \   'modes': {
            \       'n'     : '',
            \       'i'     : '',
            \       'R'     : 'R',
            \       'v'     : '',
            \       'V'     : 'V-L',
            \       'c'     : 'C',
            \       't'     : '>_',
            \       "\<C-v>": 'V-B',
            \       's'     : 'S',
            \       'S'     : 'S-L',
            \       "\<C-s>": 'S-B',
            \       '?'     : '',
            \   }
            \ }
" 1}}}

" ========== GENERAL ===========================================

fun! SL_bufnr() abort " {{{1
    return '[' . bufnr('%') . ']'
endfun
" 1}}}

fun! SL_path() abort " {{{1
    if !empty(expand('%:t'))
        let fn = winwidth(0) <# 55
                    \ ? '../'
                    \ : winwidth(0) ># 85
                    \ ? expand('%:~:.:h') . '/'
                    \ : pathshorten(expand('%:~:.:h')) . '/'
    else
        let fn = ''
    endif
    return fn
endfun
" 1}}}

fun! SL_previewwindow() abort " {{{1
    return &previewwindow ? '[Prev]' : ''
endfun
" 1}}}

fun! SL_filename() abort " {{{1
    let fn = !empty(expand('%:t'))
                \ ? expand('%:p:t')
                \ : '[No Name]'
    return fn . (&readonly ? ' ' : '')
endfun
" 1}}}

fun! SL_modified() abort " {{{1
    return &modified ? '+' : ''
endfun
" 1}}}

fun! SL_format_and_encoding() abort " {{{1
    let encoding = winwidth(0) <# 55
                \ ? ''
                \ : strlen(&fenc)
                \ ? &fenc
                \ : &enc
    let format = winwidth(0) ># 85
                \ ? &fileformat
                \ : winwidth(0) <# 55
                \ ? ''
                \ : &fileformat[0]
    return printf('%s[%s]', encoding, format)
endfun
" 1}}}

fun! SL_filetype() abort " {{{1
    return strlen(&filetype) ? &filetype : ''
endfun
" 1}}}

fun! SL_hi_group() abort " {{{1
    return '> ' . synIDattr(synID(line('.'), col('.'), 1), 'name') . ' <'
endfun
" 1}}}

fun! SL_mode() abort " {{{1
    return get(s:sl.modes, mode())
endfun
" 1}}}

fun! SL_paste() abort " {{{1
    if &paste
        return winwidth(0) <# 55 ? '[P]' : '[PASTE]'
    else
        return ''
    endif
endfun
" 1}}}

fun! SL_spell() abort " {{{1
    return &spell ? &spelllang : ''
endfun
" 1}}}

fun! SL_indentation() abort " {{{1
    return winwidth(0) <# 55
                \ ? ''
                \ : &expandtab
                \ ? 's:' . &shiftwidth
                \ : 't:' . &shiftwidth
endfun
" 1}}}

fun! SL_column_and_percent() abort " {{{1
    " The percent part was inspired by vim-line-no-indicator plugin.
    let chars = ['꜒', '꜓', '꜔', '꜕', '꜖',]
    let [c_l, l_l] = [line('.'), line('$')]
    let index = float2nr(ceil((c_l * len(chars) * 1.0) / l_l)) - 1
    let perc = chars[index]
    return winwidth(0) ># 55 ? printf('%s%2d', perc, col('.')) : ''
endfun
" 1}}}

fun! SL_jobs() abort " {{{1
    let n_jobs = exists('g:jobs') ? len(g:jobs) : 0
    return winwidth(0) <# 55
                \ ? ''
                \ : n_jobs
                \ ? ' ' . n_jobs
                \ : ''
endfun
" 1}}}

fun! SL_toggled() abort " {{{1
    if !exists('g:SL_toggle')
        return ''
    endif
    let sl = ''
    for [k, v] in items(g:SL_toggle)
        let str = call(v, [])
        let sl .= empty(sl)
                    \ ? str . ' '
                    \ : s:sl.separator . ' ' . str . ' '
    endfor
    return sl[:-2]
endfun
" 1}}}

fun! SL_terminal() abort " {{{1
    if !g:has_term
        return ''
    endif
    let term_buf_nr = get(g:, 'term_buf_nr', 0)
    return term_buf_nr && index(term_list(), term_buf_nr) isnot# -1
                \ ? '' : ''
endfun
" 1}}}

fun! SL_qf() abort " {{{1
    return printf('[q:%d l:%d]',
                \ len(getqflist()),
                \ len(getloclist(bufnr('%')))
                \ )
endfun
" 1}}}

" ========== PLUGINS ===========================================

fun! SL_fugitive() abort " {{{1
    let i = ''
    if exists('*fugitive#head') && !empty(fugitive#head()) && winwidth(0) ># 55
        return fugitive#head() isnot# 'master' ? i . ' ' . fugitive#head() : i
    else
        return ''
    endif
endfun
" 1}}}

fun! SL_signify() abort " {{{1
    if exists('*sy#repo#get_stats')
        let h = sy#repo#get_stats()
        return h !=# [-1, -1, -1] && winwidth(0) ># 55 && h !=# [0, 0, 0]
                    \ ? printf('+%d ~%d -%d', h[0], h[1], h[2])
                    \ : ''
    else
        return ''
    endif
endfun
" 1}}}

fun! SL_ale(mode) abort " {{{1
    " a:mode: 1/0 = errors/ok

    if !exists('g:loaded_ale')
        return ''
    endif

    if !g:loaded_ale
        return ''
    endif

    if !g:ale_enabled || empty(ale#linter#Get(&ft))
        return ''
    endif

    let counts = ale#statusline#Count(bufnr('%'))
    let total = counts.total
    let errors = counts.error + counts.style_error
    let warnings = counts.warning + counts.style_warning

    return s:get_parsed_linting_str(errors, warnings, total, a:mode)
endfun
" 1}}}

fun! SL_coc_diagnostic(mode) abort " {{{1
    " a:mode: 1/0 = errors/ok

    if !exists('g:coc_enabled')
        return ''
    endif

    if !g:coc_enabled
        return ''
    endif

    let infos = get(b:, 'coc_diagnostic_info', {})
    if empty(infos) | return '' | endif

    let errors = get(infos, 'error', 0)
    let warnings = get(infos, 'warning', 0)
    let total = errors + warnings

    return s:get_parsed_linting_str(errors, warnings, total, a:mode)
endfun
" 1}}}

fun! SL_coc_status() abort " {{{1
    " No linting involved

    let status = get(g:, 'coc_status', '')
    let first_word = matchstr(status, '^\s*\zs\S*')

    " Replace the long strings by some fancy characters
    return empty(status)
                \ ? ''
                \ : first_word is# 'Python'
                \ ? ''
                \ : first_word is# 'TSC'
                \ ? ''
                \ : first_word
endfun
" 1}}}

" ========== HELPERS ===========================================

fun! s:hi(group, bg, fg, opt) abort " {{{1
    let bg = type(a:bg) is# v:t_string ? ['none', 'none' ] : a:bg
    let fg = type(a:fg) is# v:t_string ? ['none', 'none'] : a:fg
    let opt = empty(a:opt) ? ['none', 'none'] : [a:opt, a:opt]
    let mode = ['gui', 'cterm']
    let cmd = 'hi ' . a:group . ' term=' . opt[1]
    for i in (range(0, len(mode)-1))
        let cmd .= printf(' %sbg=%s %sfg=%s %s=%s',
                    \ mode[i], bg[i],
                    \ mode[i], fg[i],
                    \ mode[i], opt[i]
                    \ )
    endfor
    execute cmd
endfun
" 1}}}

fun! s:set_sl_colors() abort " {{{1
    call s:hi('User1',
                \   s:sl.colors['main'], s:sl.colors['background'], 'bold'
                \ )
    call s:hi('User2',
                \   s:sl.colors['backgroundLight'], s:sl.colors['text'], 'none'
                \ )
    call s:hi('User3',
                \   s:sl.colors['backgroundLight'], s:sl.colors['textDark'],
                \   'none'
                \ )
    call s:hi('User4',
                \   s:sl.colors['main'], s:sl.colors['background'], 'none'
                \ )
    " Modified state
    call s:hi('User5',
                \   s:sl.colors['backgroundLight'], s:sl.colors['main'], 'bold'
                \ )
    " Success & error states
    call s:hi('User6',
                \   s:sl.colors['backgroundLight'], s:sl.colors['green'],
                \   'bold'
                \ )
    call s:hi('User7',
                \   s:sl.colors['backgroundLight'], s:sl.colors['red'], 'bold'
                \ )
    " Inactive statusline
    call s:hi('User8',
                \   s:sl.colors['backgroundDark'],
                \   s:sl.colors['backgroundLight'],
                \   'none'
                \ )
endfun
" 1}}}

fun! s:toggle_sl_item(var, funcref) abort " {{{1
    if !exists('g:SL_toggle')
        let g:SL_toggle = {}
    endif
    if has_key(g:SL_toggle, a:var)
        call remove(g:SL_toggle, a:var)
    else
        let g:SL_toggle[a:var] = a:funcref
    endif
endfun
" 1}}}

fun! Get_SL(...) abort " {{{1
    let sl = ''

    " Custom functions
    " """"""""""""""""
    if has_key(s:sl.apply, &ft)
        let fun = get(s:sl.apply, &ft)
        let len_f = len(fun)
        if len_f is# 1
            let sl = '%{' . fun[0] . '}'
        elseif len_f is# 2
            let sl = '%{' . fun[0] . '}'
            let sl .= '%=%{' . fun[-1] . '}'
        else
            for i in range(0, len_f - 2)
                if exists('*' . fun[i])
                    let sl .= (i isnot# 0 ? s:sl.separator . ' ' : '') .
                                \ '%{' . fun[i] . '}'
                endif
            endfor
            let sl .= '%=%{' . fun[-1] . '}'
        endif
        return sl
    endif

    " Inactive statusline
    " """""""""""""""""""
    if exists('a:1')
        let sl .= '%1*%( %{SL_previewwindow()} %)'
        let sl .= '%8* %{SL_bufnr()} '
        let sl .= '%{SL_path()}'
        let sl .= '%{SL_filename()}'
        let sl .= '%( %{SL_modified()}%)'
        let sl .= '%=%( %{SL_filetype()} %)'
        return sl
    endif

    " Active statusline
    " """""""""""""""""
    " let sl .= '%1* %-{SL_mode()} %(%{SL_paste()} %)'
    let sl .= '%1*%( %{SL_previewwindow()} %)'
    let sl .= '%( %{SL_paste()} %)'
    let sl .= '%3* %{SL_bufnr()} '
    let sl .= '%{SL_path()}'
    let sl .= '%2*%{SL_filename()}'
    let sl .= '%5*%(%{SL_modified()}%) '

    " ALE (1st group for no errors)
    let sl .= '%6*%(%{SL_ale(0)} %)'
    let sl .= '%7*%([%{SL_ale(1)}] %)'

    " or coc (1st group for no errors)
    let sl .= '%6*%(%{SL_coc_diagnostic(0)} %)'
    let sl .= '%7*%([%{SL_coc_diagnostic(1)}] %)'

    let sl .= '%3*'
    let sl .= '%='

    " Git stuffs
    let sl .= '%( %{SL_signify()} %)'
    let sl .= '%(%{SL_fugitive()} ' . s:sl.separator . '%)'

    let sl .= '%( %{SL_spell()} ' . s:sl.separator . '%)'
    let sl .= '%( %{SL_filetype()} %)'

    let sl .= '%4*'

    " Toggled elements
    let sl .= '%( %{SL_toggled()} %)'

    " Terminal jobs
    let sl .= '%( %{SL_terminal()} %)'

    " Jobs
    let sl .= '%( %{SL_jobs()} %)'

    " coc status
    let sl .= '%( %{SL_coc_status()} %)'

    return sl
endfun
" 1}}}

fun! s:sl_init() abort " {{{1
    set noshowmode
    set laststatus=2
    call s:set_sl_colors()
    call s:apply_sl()
    augroup SL
        autocmd!
        autocmd WinEnter,BufEnter * call <SID>apply_sl()
        autocmd WinLeave * call <SID>apply_sl(1)
        if g:has_term
            autocmd TerminalOpen * call <SID>apply_sl()
        endif
    augroup END
endfun
" 1}}}

fun! s:apply_sl(...) abort " {{{1
    if &buftype is# 'terminal'
        setlocal statusline&
    elseif index(s:sl.ignore, &ft) is# -1
        silent execute !exists('a:1')
                    \ ? 'setlocal statusline=%!Get_SL()'
                    \ : 'setlocal statusline=%!Get_SL(0)'
    endif
endfun
" 1}}}

fun! s:get_parsed_linting_str(errors, warnings, total, mode) abort " {{{1
    let errors_str = a:errors isnot# 0
                \ ? printf('%s %s', s:sl.checker.error_sign, a:errors)
                \ : ''
    let warnings_str = a:warnings isnot# 0
                \ ? printf('%s %s', s:sl.checker.warning_sign, a:warnings)
                \ : ''

    let def_str = printf('%s %s', errors_str, warnings_str)
    " Trim spaces
    let def_str = substitute(def_str, '^\s*\(.\{-}\)\s*$', '\1', '')
    let success_str = s:sl.checker.success_sign

    if a:mode
        return a:total is# 0 ? '' : def_str
    else
        return a:total is# 0 ? success_str : ''
    endif
endfun
" 1}}}

" ========== COMMANDS ==========================================

" {{{1
let s:args = [
            \   ['toggle', 'clear'],
            \   [
            \       'column_and_percent', 'format_and_encoding', 'indentation',
            \       'hi_group', 'qf'
            \   ]
            \ ]
command! -nargs=? -complete=custom,s:sl_complete_args SL
            \ call s:sl_command(<f-args>)

fun! s:sl_command(...) abort " {{{2
    let arg = exists('a:1') ? a:1 : 'clear'

    if arg is# 'toggle'
        let &laststatus = (&laststatus isnot# 0 ? 0 : 2)
        let &showmode = (&laststatus is# 0 ? 1 : 0)
        return
    elseif arg is# 'clear'
        unlet! g:SL_toggle
        return
    endif

    " Split args in case we have many
    let args = split(arg, ' ')

    " Check the 1st one only
    if index(s:args[1], args[0], 0) is# -1
        return
    endif

    for a in args
        let fun_ref = 'SL_' . arg
        call s:toggle_sl_item(arg, fun_ref)
    endfor
endfun " 2}}}

fun! s:sl_complete_args(a, l, p) abort " {{{2
    return join(s:args[0] + s:args[1], "\n")
endfun " 2}}}
" 1}}}

" ========== INITIALIZE ========================================

call <SID>sl_init()


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
