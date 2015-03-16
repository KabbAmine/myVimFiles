" For SCSS files.
" Last modification: 2015-03-16

" =========== VARIOUS =======================
" Set indentation to 2.
" {
	setlocal ts=2
	setlocal sw=2
	setlocal sts=2
	set expandtab
" }

" =========== MAPPINGS =======================
" Compile file(s) using compass *******
" {
	" *** <F9>
		nmap <silent> <buffer> <F9> :!compass compile "%:p"<CR>
" }
