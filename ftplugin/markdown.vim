" For Markdown files.
" Last modification: 2014-08-02

" =========== VARIOUS =======================
setlocal nonumber

" =========== MAPPINGS =======================
" Convert a Markdown syntax to HTML (Unix).
" {
	" *** <F9>
		nmap <silent> <buffer> <F9> :%!markdown<CR>
" }
