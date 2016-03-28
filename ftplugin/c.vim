" For C files.
" Last modification: 2016-03-28

" =========== MAPPINGS =======================
" Compile/execute a C file/executable.
" *** <F9>		=> Compile.
" *** <C-F9>	=> Execute.
nnoremap <silent> <buffer> <F9> :!gcc -o '%:p:r' '%:p'<CR>
nnoremap <silent> <buffer> <c-F9> :!"%:p:r"<CR>
