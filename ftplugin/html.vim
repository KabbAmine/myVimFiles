" For HTML files.
" Last modification: 2014-06-09

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
			silent s/á/\&aacute;/e
			silent s/â/\&acirc;/e
			silent s/Â/\&Acirc;/e
			silent s/à/\&agrave;/e
			silent s/À/\&Agrave;/e
			silent s/ä/\&auml;/e
			silent s/æ/\&aelig;/e
			silent s/Æ/\&AElig;/e
			silent s/ç/\&ccedil;/e
			silent s/Ç/\&Ccedil;/e
			silent s/é/\&eacute;/e
			silent s/É/\&Eacute;/e
			silent s/ê/\&ecirc;/e
			silent s/Ê/\&Ecirc;/e
			silent s/è/\&egrave;/e
			silent s/È/\&Egrave;/e
			silent s/ë/\&euml;/e
			silent s/Ë/\&Euml;/e
			silent s/>/\&gt;/
			silent s/î/\&icirc;/e
			silent s/Î/\&Icirc;/e
			silent s/ï/\&iuml;/e
			silent s/</\&lt;/
			silent s/ô/\&ocirc;/e
			silent s/Ô/\&Ocirc;/e
			silent s/ø/\&oslash;/e
			silent s/Ø/\&Oslash;/e
			silent s/ö/\&ouml;/e
			silent s/Ú/\&Uacute;/e
			silent s/û/\&ucirc;/e
			silent s/Û/\&Ucirc;/e
			silent s/ù/\&ugrave;/e
			silent s/Ù/\&Ugrave;/e
			silent s/ü/\&uuml;/e
		endfunction
" }
