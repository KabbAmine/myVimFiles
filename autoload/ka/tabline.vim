" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-25
" ==============================================================


fun! ka#tabline#get() abort " {{{1
    let hi_none = '%#None#'
    let hi_selected = '%#User4#'
    let hi_cwd = '%#TabLine#'

    let tabline = hi_selected . '%( %{ka#tabline#buffer_info()} %)' . hi_none
    let tabline .= hi_none . '%='
    let tabline .= hi_cwd . '%( %{ka#tabline#cwd()} %)'
    let tabline .= hi_selected . '%( %{ka#tabline#nr()} %)'
    return tabline
endfun
" 1}}}

fun! ka#tabline#buffer_info() abort " {{{1
    let current = bufnr('%')
    let modified = getbufvar(current, '&modified') ? '+' : ''
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") isnot# "qf"')
    let count_buffers = len(buffers)
    let index_current = index(buffers, current) + 1
    return count_buffers ># 1
                \ ? '[' . current . modified . '] ' . index_current . '/' . count_buffers
                \ : ''
endfun
" 1}}}

fun! ka#tabline#cwd() abort " {{{1
    let cwd = fnamemodify(getcwd(), ':~')
    if cwd isnot# '~/'
        let cwd = len(cwd) >=# 15 ? pathshorten(cwd) : cwd
        return cwd
    else
        return ''
    endif
endfun
" 1}}}

fun! ka#tabline#nr() abort " {{{1
    return tabpagenr('$') isnot# 1
                \ ? tabpagenr()
                \ : ''
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
