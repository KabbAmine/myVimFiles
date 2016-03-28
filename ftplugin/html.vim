" For HTML files.
" Last modification: 2016-03-28

" =========== MAPPINGS =======================
" Open a html file into the browser
if has ('win32') || has('win64')
	nnoremap <silent> <buffer> <c-F9> :!start cmd /c '%:p'<CR>
else
	nnoremap <silent> <buffer> <c-F9> :!x-www-browser '%:p' &<CR><CR>
endif

" =========== FUNCTIONS =======================
" Replace special character with his HTML entity *******
command! -range=% SpecChar :call SpecChar()
function! SpecChar() abort
	silent s/&/\&amp;/e
	silent s/</\&lt;/e
	silent s/>/\&gt;/e
	silent s/À/\&Agrave;/e
	silent s/Â/\&Acirc;/e
	silent s/Æ/\&AElig;/e
	silent s/Ç/\&Ccedil;/e
	silent s/È/\&Egrave;/e
	silent s/É/\&Eacute;/e
	silent s/Ê/\&Ecirc;/e
	silent s/Ë/\&Euml;/e
	silent s/Î/\&Icirc;/e
	silent s/Ô/\&Ocirc;/e
	silent s/Ø/\&Oslash;/e
	silent s/Ù/\&Ugrave;/e
	silent s/Ú/\&Uacute;/e
	silent s/Û/\&Ucirc;/e
	silent s/à/\&agrave;/e
	silent s/á/\&aacute;/e
	silent s/â/\&acirc;/e
	silent s/ä/\&auml;/e
	silent s/æ/\&aelig;/e
	silent s/ç/\&ccedil;/e
	silent s/è/\&egrave;/e
	silent s/é/\&eacute;/e
	silent s/ê/\&ecirc;/e
	silent s/ë/\&euml;/e
	silent s/î/\&icirc;/e
	silent s/ï/\&iuml;/e
	silent s/ô/\&ocirc;/e
	silent s/ö/\&ouml;/e
	silent s/ø/\&oslash;/e
	silent s/ù/\&ugrave;/e
	silent s/û/\&ucirc;/e
	silent s/ü/\&uuml;/e
endfunction
