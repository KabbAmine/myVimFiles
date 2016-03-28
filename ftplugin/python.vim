" For Python files.
" Last modification: 2016-03-28

" =========== MAPPINGS =======================
" Execute a python file *******
" *** <F9>		=> Python2
" *** <C-F9>	=> Python3
nnoremap <silent> <buffer> <F9> :!python "%:p"<CR>
nnoremap <silent> <buffer> <c-F9> :!python3 "%:p"<CR>
