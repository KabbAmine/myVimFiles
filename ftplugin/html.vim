" Last modification: 2017-09-11


" Open file in the browser {{{1
nnoremap <silent> <buffer> <expr> <C-F9> expand(g:has_win) ?
            \ ":!start cmd /c '%:p'" : ":!x-www-browser '%:p' &<CR><CR>"
" 1}}}

" Replace special characters with their HTML entities {{{1
command! -range=% SpecChar :call SpecChar(<line1>, <line2>)

function! SpecChar(start, end) abort " {{{2
    let l:pos = getpos('.')
    let l:pat = '^\s*<[a-zA-Z0-9-_"'' =]\+>\zs\(.*\)\ze</\w\+>$'

    " All special html characters except '&'
    let l:spec_chars = {
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
                \ a:start, a:end, l:pat)

    for l:i in items(l:spec_chars)
        let [l:char, l:escaped] = [l:i[0], escape(l:i[1], '&')]
        silent execute printf(
                    \ "%d,%ds@%s@\\=substitute(submatch(1),'\\C%s','%s','gcI')@ge",
                    \ a:start, a:end, l:pat, l:char, l:escaped)
    endfor

    call setpos('.', l:pos)
endfunction
" 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
