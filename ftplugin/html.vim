" For HTML files.
" Last modification: 2014-06-08

" =========== VARIOUS =======================
" Set indentation to 2.
" {
	setlocal ts=2
	setlocal sts=2
	setlocal sw=2
" }

" =========== MAPPINGS =======================
" Open a html file into the browser *******
" {
	" *** <C-F9>
		if has ('win32') || has('win64')
			nmap <silent> <buffer> <c-F9> :!start cmd /c "%:p"<CR>
		else
			nmap <silent> <buffer> <c-F9> :!x-www-browser "%:p" &<CR><CR>
		endif
" }

" =========== FUNCTIONS =======================
" Replace special character with his HTML entity *******
" {
	" *** :SpecChar
		command! -range=% SpecChar :call SpecChar()
		function! SpecChar()
			silent s/À/\&Agrave;/eg
			silent s/Â/\&Acirc;/eg
			silent s/Æ/\&AElig;/eg
			silent s/Ç/\&Ccedil;/eg
			silent s/È/\&Egrave;/eg
			silent s/É/\&Eacute;/eg
			silent s/Ê/\&Ecirc;/eg
			silent s/Ë/\&Euml;/eg
			silent s/Î/\&Icirc;/eg
			silent s/Ô/\&Ocirc;/eg
			silent s/Ø/\&Oslash;/eg
			silent s/Ù/\&Ugrave;/eg
			silent s/Ú/\&Uacute;/eg
			silent s/Û/\&Ucirc;/eg
			silent s/à/\&agrave;/eg
			silent s/á/\&aacute;/eg
			silent s/â/\&acirc;/eg
			silent s/ä/\&auml;/eg
			silent s/æ/\&aelig;/eg
			silent s/ç/\&ccedil;/eg
			silent s/è/\&egrave;/eg
			silent s/é/\&eacute;/eg
			silent s/ê/\&ecirc;/eg
			silent s/ë/\&euml;/eg
			silent s/î/\&icirc;/eg
			silent s/ï/\&iuml;/eg
			silent s/ô/\&ocirc;/eg
			silent s/ö/\&ouml;/eg
			silent s/ø/\&oslash;/eg
			silent s/ù/\&ugrave;/eg
			silent s/û/\&ucirc;/eg
			silent s/ü/\&uuml;/eg
		endfunction
" }
