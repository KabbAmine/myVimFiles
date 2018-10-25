" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-26
" ==============================================================


fun! ka#tabline#get() abort " {{{1
    let hi_selected = '%#User4#'
    let hi_cwd = '%#TabLine#'

    let tabline = '%=' . hi_selected . '%( %{ka#tabline#buffer_info()} %)'
    let tabline .= hi_cwd . '%( %{ka#tabline#cwd()} %)'
    let tabline .= hi_selected . '%( %{ka#tabline#tab()} %)'
    return tabline
endfun
" 1}}}

fun! ka#tabline#buffer_info() abort " {{{1
    let current = bufnr('%')
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") isnot# "qf"')
    let index_current = index(buffers, current) + 1
    let modified = getbufvar(current, '&modified') ? '+' : ''
    let count_buffers = len(buffers)
    return index_current isnot# 0 && count_buffers ># 1
                \ ? printf('[%s%s] %s/%s',
                \   current,
                \   modified,
                \   index_current,
                \   count_buffers)
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

fun! ka#tabline#tab() abort " {{{1
    let count_tabs = tabpagenr('$')
    return count_tabs isnot# 1
                \ ? printf('%d/%d', tabpagenr(), count_tabs)
                \ : ''
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
