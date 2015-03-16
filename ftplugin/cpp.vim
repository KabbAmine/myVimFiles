" For C files.
" Last modification: 2015-03-16


" =========== MAPPINGS =======================
" Compile/execute a C++ file/executable.
" {
	" *** <F9>		=> Compile.
	" *** <C-F9>	=> Execute.
		nmap <silent> <buffer> <F9> :!g++ -o "%:p:r" "%:p"<CR>
		nmap <silent> <buffer> <c-F9> :!"%:p:r"<CR>
" }
