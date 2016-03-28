" For Java files.
" Last modification: 2016-03-28

" =========== MAPPINGS =======================
" Compile/execute a Java file/executable.
" *** <F9>		=> Compile.
" *** <C-F9>	=> Execute.
nnoremap <silent> <buffer> <F9> :!javac '%:p'<CR>
nnoremap <silent> <buffer> <c-F9> :!java -cp '%:p:h' '%:t:r'<CR>
