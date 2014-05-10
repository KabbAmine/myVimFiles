" For Java files.
" Last modification: 2014-05-10


" =========== MAPPINGS =======================
" Compile/execute a Java file/executable.
" {
	" *** <F9>		=> Compile.
	" *** <C-F9>	=> Execute.
		nmap <silent> <buffer> <F9> :!javac "%:p"<CR>
		nmap <silent> <buffer> <c-F9> :!java -cp "%:p:h" "%:t:r"<CR>
" }
