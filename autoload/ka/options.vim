" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


fun! ka#options#indent(...) abort " {{{1
    let pos = getpos('.')
    let opts = ['softtabstop', 'shiftwidth']
    let old_i = []
    for o in opts
        call add(old_i, getbufvar('%', '&' . o))
    endfor
    echohl Question
    let new_i = exists('a:1') ? a:1 :
                \ input(printf('%d:%d> ',
                \   old_i[0], old_i[1]))
    echohl None
    if !empty(new_i)
        for o in opts
            execute printf('setlocal %s=%d', o, new_i)
        endfor
    endif
    silent execute '%normal! =='
    call setpos('.', pos)
endfun
" 1}}}

fun! ka#options#set_spell(...) abort " {{{1
    if !&l:spell
        let s:spelllang = &l:spelllang
        let l = get(a:, 1, 'fr')
        let &l:spelllang = l
        setlocal spell
    else
        setlocal nospell
        let &l:spelllang = get(s:, 'spelllang', &l:spelllang)
    endif
endfun
" 1}}}

fun! ka#options#fold(indentations) abort " {{{1
    if !has_key(a:indentations, &filetype)
        call ka#ui#echo(
                    \   '[fold]',
                    \   'no folding method for "' . &filetype . '"',
                    \   'Error'
                    \ )
        return
    endif
    let ft = a:indentations[&filetype]
    let type = ft[0]
    let marker = len(ft) ># 1 ? ft[1] : ''
    let [foldmethod, foldmarker] = [&foldmethod, &foldmarker]

    if empty(getbufvar('%', 'fold_by_marker'))
        silent execute 'setlocal foldmethod=' . type
        if !empty(marker)
            silent execute 'setlocal foldmarker=' . escape(marker, ' ')
        endif
        setlocal foldenable
        normal! zR
        call setbufvar('%', 'fold_by_marker', 1)
        " Be sure to have foldcolumn enabled
        setlocal foldcolumn=1
        call ka#ui#echo('[fold-' . type . ']', 'enabled', 'ModeMsg')
    else
        setlocal nofoldenable
        silent execute 'setlocal foldmethod=' . foldmethod
        silent execute 'setlocal foldmarker=' . escape(foldmarker, ' ')
        call setbufvar('%', 'fold_by_marker', 0)
        setlocal foldcolumn=0
        call ka#ui#echo('[fold-' . type . ']', 'disabled', 'ModeMsg')
    endif
endfun
" 1}}}

fun! ka#options#auto_fold_column() abort " {{{1
    let pos = getpos('.')
    let c_l = line('.')
    let there_are_folds = 0

    if foldlevel(c_l)
        let there_are_folds = 1
    endif

    if !there_are_folds
        normal! ggzj
        if line('.') isnot# 1
            let there_are_folds = 1
        endif
    endif

    if !there_are_folds
        normal! ]z
        if line('.') isnot# 1
            let there_are_folds = 1
        endif
    endif

    call setpos('.', pos)

    if there_are_folds
        setlocal foldcolumn=1
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
