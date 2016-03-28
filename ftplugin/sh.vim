" For Bash files.
" Last modification: 2016-03-28

" =========== MAPPINGS =======================
" Give the execution right to a Bash script and execute it (Unix).
" *** <F9>		=> Give right.
" *** <C-F9>	=> Execute.
nnoremap <silent> <buffer> <F9> :!chmod +x "%:p"<CR><CR>
nnoremap <silent> <buffer> <C-F9> :!"%:p" &<CR><CR>
