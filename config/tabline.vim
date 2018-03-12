" ========== Custom tabline ====================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-12
" ==============================================================


let s:higroup_none = '%#None#'
let s:higroup_selected = '%#User4#'
let s:higroup_non_selected = '%#Comment#'
let s:higroup_cwd = '%#TabLine#'

function! TabLine() abort " {{{1
    let bl = []
    let current_nr = bufnr('%')
    let bufs = s:Buffers()
    let bufs_count = len(bufs)

    " Show 3 buffers maximum when the joined buffer's list string is bigger
    " than the window's width.
    if strlen(join(map(copy(bufs), 'bufname(v:val)'))) ># &columns
        let bl += [s:higroup_cwd, '[' . bufs_count . ']']
        let current_i = index(bufs, current_nr)
        let prev_nr = current_i - 1 >=# 0 ? bufs[current_i - 1] : bufs[0]
        let next_nr = current_i + 1 <# len(bufs) - 1
                    \ ? bufs[current_i + 1]
                    \ : bufs[-1]
        let current = s:higroup_selected . ' <' . s:GetFormattedBuffer(current_nr) . '>'
        let prev = prev_nr isnot# current_nr
                    \ ? s:GetFormattedBuffer(prev_nr)
                    \ : ''
        let next = next_nr isnot# current_nr
                    \ ? s:GetFormattedBuffer(next_nr)
                    \ : ''
        let bl += [prev, current, next]
    else
        for b in bufs
            call add(bl, s:GetFormattedBuffer(b))
        endfor
    endif

    let bl += [s:higroup_none, '%=']

    let cwd = fnamemodify(getcwd(), ':~')
    if cwd isnot# '~/'
        let cwd = len(cwd) >=# 15 ? pathshorten(cwd) : cwd
        let bl += [s:higroup_cwd . ' ' . cwd . ' ']
    endif

    if tabpagenr('$') isnot# 1
        let bl += [s:higroup_selected, tabpagenr() . ' ']
    endif

    return join(bl)
endfunction
" 1}}}

function! s:TLInit() abort " {{{1
    let bufs = s:Buffers()
    if len(s:Buffers()) is# 1 && getcwd() is# $HOME
        set showtabline=0
        return
    endif
    set showtabline=2
    set tabline=%!TabLine()
endfunction
" 1}}}

" ========== HELPERS ========================================

function! s:Buffers() abort " {{{1
    return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction
" 1}}}

function! s:GetFormattedBuffer(buf) abort " {{{1
    let buf_name = pathshorten(fnamemodify(bufname(a:buf), ':.'))
    if empty(buf_name)
        let buf_name = '[No Name]'
    endif
    let modified = getbufvar(a:buf, '&modified') ? '[+]' : ''
    let higroup = a:buf is# bufnr('%')
                \ ? s:higroup_selected
                \ : s:higroup_non_selected
    return printf('%s %d. %s %s', higroup, a:buf, buf_name, modified)
endfunction
" 1}}}

" ========== INITIALIZE ========================================

" {{{1
augroup TabBufLine
    autocmd!
    autocmd BufAdd,BufDelete,TabNew,TabClosed * call <SID>TLInit()
augroup END
call s:TLInit()
" 1}}}

" ========== MAPPINGS ==========================================

" Replace default <F5> {{{1
nnoremap <silent> <F5> :tabonly\|call <SID>TLInit()<CR>
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
