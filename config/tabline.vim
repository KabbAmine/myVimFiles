" ========== Custom tabline ====================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-09-08
" ==============================================================


" Not mandatory, but the bufline uses the following plugins:
" * tabpagecd


function! MyBufLine() abort " {{{1
    let l:bl = '%#TablineFill#'
    let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    for l:b in l:bufs
        " Show buffers only when we have more than one
        if len(l:bufs) ==# 1
            break
        endif
        let l:mod = (getbufvar(l:b, '&modified') ==# 1 ? ' +' : '')
        let l:name = (!empty(bufname(l:b)) ?
                    \	pathshorten(fnamemodify(bufname(l:b), ':.')) . l:mod :
                    \	'[No Name]'
                    \ )
        if l:b ==# bufnr('%')
            let l:bl .= '%#TabLineSel# ' . l:name . ' %#TabLineFill# '
        else
            let l:bl .= '%#TabLine# ' . l:name . ' %#TabLineFill# '
        endif
    endfor
    let l:get_cwd = fnamemodify(getcwd(), ':~')
    if l:get_cwd !=# '~/'
        let l:cwd = len(l:get_cwd) >=# 15 ? pathshorten(l:get_cwd) : l:get_cwd
        let l:bl .= '%=%#IncSearch# ' . l:cwd . ' '
    endif

    return l:bl
endfunction
" 1}}}

function! MyTabLine() abort " {{{1
    " :h setting-tabline

    let l:tl = ''
    for i in range(tabpagenr('$'))
        let l:i = i + 1
        let l:tl .= (l:i ==# tabpagenr()) ?
                    \ ' %#TabLineSel#' : ' %#TabLine#'
        " Set the tab page number (for mouse clicks)
        let l:tl .= '%' . l:i . 'T '
        " Get working directory (Use tabpagecd if present, otherwise use
        " getcwd()).
        if !empty(gettabvar(l:i, 'cwd'))
            let l:tl .= tabpagenr('$') >=# 5 ?
                        \ fnamemodify(gettabvar(l:i, 'cwd'), ':t') :
                        \ pathshorten(fnamemodify(gettabvar(l:i, 'cwd'), ':~'))
        else
            let l:tl .= tabpagenr('$') >=# 5 ?
                        \ fnamemodify(getcwd(), ':t') :
                        \ pathshorten(fnamemodify(getcwd(), ':~'))
        endif
        let l:tl .= '%' . l:i . 'X ⨉'
        " Fill with TabLineFill and reset tab page nr
        let l:tl .= ' %#TabLineFill#%T'
    endfor
    let l:tl .= '%=%#TabLineSel# T '

    return l:tl
endfunction
" 1}}}

function! TLInit() abort " {{{1
    set tabline=
    set showtabline=2
    if tabpagenr('$') ==# 1
        let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
        let &showtabline = len(l:bufs) ># 1 ? 2 : &showtabline
        set tabline=%!MyBufLine()
    else
        set showtabline=2
        set tabline=%!MyTabLine()
    endif
endfunction
" 1}}}

" ========== INITIALIZE ========================================

" {{{1
hi! link TablineSel StatusLine
augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,TabEnter,TabLeave,VimEnter * call TLInit()
augroup END
call TLInit()
" 1}}}

" ========== MAPPINGS ==========================================

" Replace default <F5> {{{1
nnoremap <silent> <F5> :tabonly\|call TLInit()<CR>
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
