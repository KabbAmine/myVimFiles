" For Bash files.
" Last modification: 2014-05-10

" =========== MAPPINGS =======================
" Give the execution right to a Bash script and execute it (Unix).
" {
	" *** <F9>
		nmap <silent> <buffer> <F9> :!chmod +x "%:p" && "%:p"<CR>
" }
