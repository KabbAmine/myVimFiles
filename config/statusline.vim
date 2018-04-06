" ========== Custom statusline + mappings ======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-04-06
" ==============================================================


" The used plugins are (They are not mandatory):
" * Fugitive
" * GitGutter
" * Rvm
" * ALE

" ========== CONFIGURATION =====================================

" {{{1
let s:sl  = {
            \   'separator': '',
            \   'ignore': ['vfinder', 'qf', 'nerdtree', 'undotree', 'diff'],
            \   'apply': {},
            \   'checker': g:checker,
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
            \       'n'     : 'N',
            \       'i'     : 'I',
            \       'R'     : 'R',
            \       'v'     : 'V',
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

fun! SLFilename() abort " {{{1
    if !empty(expand('%:t'))
        let fn = winwidth(0) <# 55
                    \ ? expand('%:t')
                    \ : winwidth(0) ># 85
                    \ ? expand('%:.')
                    \ : pathshorten(expand('%:.'))
    else
        let fn = '[No Name]'
    endif
    return fn . (&readonly ? ' ' : '')
endfun
" 1}}}

fun! SLModified() abort " {{{1
    return &modified ? '+' : ''
endfun
" 1}}}

fun! SLFormatAndEncoding() abort " {{{1
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

fun! SLFiletype() abort " {{{1
    return strlen(&filetype) ? &filetype : ''
endfun
" 1}}}

fun! SLHiGroup() abort " {{{1
    return '> ' . synIDattr(synID(line('.'), col('.'), 1), 'name') . ' <'
endfun
" 1}}}

fun! SLMode() abort " {{{1
    return get(s:sl.modes, mode())
endfun
" 1}}}

fun! SLPaste() abort " {{{1
    if &paste
        return winwidth(0) <# 55 ? '[P]' : '[PASTE]'
    else
        return ''
    endif
endfun
" 1}}}

fun! SLPython() abort " {{{1
    let p = executable('python') ? system('python --version')[7:-2] : ''
    let p3 = executable('python3') ? system('python3 --version')[7:-2] : ''
    return printf('[py %s - %s]', p, p3)
endfun
" 1}}}

fun! SLSpell() abort " {{{1
    return &spell ? &spelllang : ''
endfun
" 1}}}

fun! SLIndentation() abort " {{{1
    return winwidth(0) <# 55
                \ ? ''
                \ : &expandtab
                \ ? 's:' . &shiftwidth
                \ : 't:' . &shiftwidth
endfun
" 1}}}

fun! SLColumnAndPercent() abort " {{{1
    " The percent part was inspired by vim-line-no-indicator plugin.

    let chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let [c_l, l_l] = [line('.'), line('$')]
    let index = float2nr(ceil((c_l * len(chars) * 1.0) / l_l)) - 1
    let perc = chars[index]
    return winwidth(0) ># 55 ? perc . ' ' . col('.') : ''
endfun
" 1}}}

fun! SLJobs() abort " {{{1
    let n_jobs = exists('g:jobs') ? len(g:jobs) : 0
    return winwidth(0) <# 55
                \ ? ''
                \ : n_jobs
                \ ? ' ' . n_jobs
                \ : ''
endfun
" 1}}}

fun! SLToggled() abort " {{{1
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

" ========== PLUGINS ===========================================

fun! SLFugitive() abort " {{{1
    let i = ''
    if exists('*fugitive#head') && !empty(fugitive#head()) && winwidth(0) ># 55
        return fugitive#head() isnot# 'master' ? i . ' ' . fugitive#head() : i
    else
        return ''
    endif
endfun
" 1}}}

fun! SLGitGutter() abort " {{{1
    " Note that it uses Fugitive to be sure being in a git project.
    if exists('g:gitgutter_enabled') && g:gitgutter_enabled
        let h = GitGutterGetHunkSummary()
        return !empty(SLFugitive()) && !empty(h) && h !=# [0,0,0] && winwidth(0) ># 55
                    \ ? printf('+%d ~%d -%d', h[0], h[1], h[2])
                    \ : ''
    else
        return ''
    endif
endfun
" 1}}}

fun! SLRuby() abort " {{{1
    if g:has_gui && exists('*rvm#statusline()') && !empty(rvm#statusline())
        let r = matchstr(rvm#statusline(), '\d.*[^\]]')
    elseif executable('ruby')
        let r = matchstr(system('ruby -v')[5:], '[a-z0-9.]*\s')[:-2]
    else
        let r = ''
    endif
    return printf('[ruby %s]', r)
endfun
" 1}}}

fun! SLAle(mode) abort " {{{1
    " a:mode: 1/0 = errors/ok

    if exists('g:loaded_ale') && !g:loaded_ale
        return ''
    endif

    if !g:ale_enabled || empty(ale#linter#Get(&ft))
        return ''
    endif

    let counts = ale#statusline#Count(bufnr('%'))
    let total = counts.total
    let errors = counts.error + counts.style_error
    let warnings = counts.warning + counts.style_warning

    let errors_str = errors isnot# 0
                \ ? printf('%s %s', s:sl.checker.error_sign, errors)
                \ : ''
    let warnings_str = warnings isnot# 0
                \ ? printf('%s %s', s:sl.checker.warning_sign, warnings)
                \ : ''

    let def_str = printf('%s %s', errors_str, warnings_str)
    " Trim spaces
    let def_str = substitute(def_str, '^\s*\(.\{-}\)\s*$', '\1', '')
    let success_str = s:sl.checker.success_sign

    if a:mode
        return total is# 0 ? '' : def_str
    else
        return total is# 0 ? success_str : ''
    endif
endfun
" 1}}}

" ========== HELPERS ===========================================

fun! s:Hi(group, bg, fg, opt) abort " {{{1
    let bg = type(a:bg) is# type('') ? ['none', 'none' ] : a:bg
    let fg = type(a:fg) is# type('') ? ['none', 'none'] : a:fg
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

fun! s:SetSLColors() abort " {{{1
    call s:Hi('User1', s:sl.colors['main'], s:sl.colors['background'], 'bold')
    call s:Hi('User2', s:sl.colors['backgroundLight'], s:sl.colors['text'], 'none')
    call s:Hi('User3', s:sl.colors['backgroundLight'], s:sl.colors['textDark'], 'none')
    call s:Hi('User4', s:sl.colors['main'], s:sl.colors['background'], 'none')
    " Modified state
    call s:Hi('User5', s:sl.colors['backgroundLight'], s:sl.colors['main'], 'bold')
    " Success & error states
    call s:Hi('User6', s:sl.colors['green'], s:sl.colors['backgroundLight'], 'bold')
    call s:Hi('User7', s:sl.colors['red'], s:sl.colors['text'], 'bold')
    " Inactive statusline
    call s:Hi('User8', s:sl.colors['backgroundDark'], s:sl.colors['backgroundLight'], 'none')
endfun
" 1}}}

fun! s:ToggleSLItem(var, funcref) abort " {{{1
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

fun! GetSL(...) abort " {{{1
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
        let sl .= '%8* %{SLFilename()}'
        let sl .= '%( %{SLModified()}%)'
        let sl .= '%=%( %{SLFiletype()} %)'
        return sl
    endif

    " Active statusline
    " """""""""""""""""
    let sl .= '%1* %-{SLMode()} %(%{SLPaste()} %)'
    let sl .= '%2* %{SLFilename()}'
    let sl .= '%5*%( %{SLModified()}% %)'

    let sl .= '%3*'
    let sl .= '%='

    " Git stuffs
    let sl .= '%( %{SLGitGutter()} %)'
    let sl .= '%(%{SLFugitive()} ' . s:sl.separator . '%)'

    let sl .= '%( %{SLSpell()}' . s:sl.separator . '%)'
    let sl .= '%( %{SLFiletype()} %)'

    " ALE (1st group for no errors)
    let sl .= '%6*%( %{SLAle(0)} %)'
    let sl .= '%7*%( %{SLAle(1)} %)'

    let sl .= '%4*'

    " Jobs
    let sl .= '%( %{SLJobs()} %)'

    " Toggled elements
    let sl .= '%( %{SLToggled()} %)'

    return sl
endfun
" 1}}}

fun! s:SLInit() abort " {{{1
    set noshowmode
    set laststatus=2
    call s:SetSLColors()
    call s:ApplySL()
    augroup SL
        autocmd!
        autocmd WinEnter,BufEnter * call <SID>ApplySL()
        autocmd WinLeave * call <SID>ApplySL(1)
    augroup END
endfun
" 1}}}

fun! s:ApplySL(...) abort " {{{1
    if index(s:sl.ignore, &ft) is# -1
        silent execute !exists('a:1')
                    \ ? 'setlocal statusline=%!GetSL()'
                    \ : 'setlocal statusline=%!GetSL(0)'
    endif
endfun
" 1}}}

" ========== COMMANDS ==========================================

" {{{1
let s:args = [
            \   ['toggle', 'clear'],
            \   [
            \       'column-and-percent', 'format-and-encoding', 'indentation',
            \       'hi-group', 'ruby', 'python'
            \   ]
            \ ]
command! -nargs=? -complete=custom,s:SLCompleteArgs SL :call s:SLCommand(<f-args>)

fun! s:SLCommand(...) abort " {{{2
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
        let arg = substitute(a, '\v(-(\a))', '\=toupper(submatch(2))', 'g')
        let fun_ref = 'SL' . toupper(arg[0]) . arg[1:]
        call s:ToggleSLItem(arg, fun_ref)
    endfor
endfun " 2}}}

fun! s:SLCompleteArgs(a, l, p) abort " {{{2
    return join(s:args[0] + s:args[1], "\n")
endfun " 2}}}
" 1}}}

" ========== INITIALIZE ========================================

call <SID>SLInit()


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
