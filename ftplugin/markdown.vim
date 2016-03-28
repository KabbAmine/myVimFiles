" For Markdown files.
" Last modification: 2016-03-28

" =========== VARIOUS =======================
setlocal nonumber

" =========== MAPPINGS =======================
" Convert a Markdown syntax to HTML (Unix).
nnoremap <silent> <buffer> <F9> :%!markdown<CR>
