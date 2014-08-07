" For Bash files.
" Last modification: 2014-08-06

" =========== MAPPINGS =======================
" Give the execution right to a Bash script and execute it (Unix).
" {
	" *** <F9>		=> Give right.
	" *** <C-F9>	=> Execute.
		nmap <silent> <buffer> <F9> :!chmod +x "%:p"<CR><CR>
		nmap <silent> <buffer> <C-F9> :!"%:p" &<CR><CR>
" }
