" Last modification: 2018-10-09


" Open file in the browser {{{1
nnoremap <silent> <buffer> <F9> :call <SID>open_in_browser()<CR>

fun! s:open_in_browser() abort " {{{2
    silent execute g:is_win
                \ ? ":!start cmd /c '%:p'"
                \ : ":!x-www-browser '%:p' &"
    if !g:is_gui
        redraw!
    endif
endfun " 2}}}
" 1}}}

" Replace special characters with their HTML entities {{{1
command! -range=% SpecChar :call SpecChar(<line1>, <line2>)

function! SpecChar(start, end) abort " {{{2
    let pos = getpos('.')
    let pat = '^\s*<[a-zA-Z0-9-_"'' =]\+>\zs\(.*\)\ze</\w\+>$'

    " All special html characters except '&'
    let spec_chars = {
                \	'á': '&aacute;', 'â': '&acirc;'  ,
                \	'Â': '&Acirc;' , 'à': '&agrave;' ,
                \	'À': '&Agrave;', 'ä': '&auml;'   ,
                \	'æ': '&aelig;' , 'Æ': '&AElig;'  ,
                \	'ç': '&ccedil;', 'Ç': '&Ccedil;' ,
                \	'é': '&eacute;', 'É': '&Eacute;' ,
                \	'ê': '&ecirc;' , 'Ê': '&Ecirc;'  ,
                \	'è': '&egrave;', 'È': '&Egrave;' ,
                \	'ë': '&euml;'  , 'Ë': '&Euml;'   ,
                \	'>': '&gt;'    , '<': '&lt;'     ,
                \	'î': '&icirc;' , 'Î': '&Icirc;'  , 'ï': '&iuml;'  ,
                \	'ô': '&ocirc;' , 'Ô': '&Ocirc;'  ,
                \	'ø': '&oslash;', 'Ø': '&Oslash;' , 'ö': '&ouml;'  ,
                \	'Ú': '&Uacute;', 'Ù': '&Ugrave;' , 'ù': '&ugrave;',
                \	'û': '&ucirc;' , 'Û': '&Ucirc;'  , 'ü': '&uuml;'  ,
                \ }

    " Replace all '&' occurences first
    silent execute printf(
                \ "%d,%ds@%s@\\=substitute(submatch(1),'&','\&amp;','gc')@ge",
                \ a:start, a:end, pat)

    for i in items(spec_chars)
        let [char, escaped] = [i[0], escape(i[1], '&')]
        silent execute printf(
                    \ "%d,%ds@%s@\\=substitute(submatch(1),'\\C%s','%s','gcI')@ge",
                    \ a:start, a:end, pat, char, escaped)
    endfor

    call setpos('.', pos)
endfunction
" 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
