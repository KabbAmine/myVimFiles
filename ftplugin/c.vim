" For C files.
" Last modification: 2014-05-10


" =========== MAPPINGS =======================
" Compile/execute a C file/executable.
" {
	" *** <F9>		=> Compile.
	" *** <C-F9>	=> Execute.
		nmap <silent> <buffer> <F9> :!gcc -o "%:p:r" "%:p"<CR>
		nmap <silent> <buffer> <c-F9> :!"%:p:r"<CR>
" }
