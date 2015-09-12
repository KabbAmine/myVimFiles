" For Markdown files.
" Last modification: 2014-08-02

" =========== VARIOUS =======================
setlocal nonumber

" =========== MAPPINGS =======================
" Convert a Markdown syntax to HTML (Unix).
" {
	" *** <F9>
		nmap <silent> <buffer> <F9> :%!markdown<CR>
" }

" =========== PLUGINS =======================
" (( mdHelper ))
" Headers
nnoremap <silent> <buffer> gh1 :Header 1<CR>
nnoremap <silent> <buffer> gh2 :Header 2<CR>
nnoremap <silent> <buffer> gh3 :Header 3<CR>
nnoremap <silent> <buffer> gh4 :Header 4<CR>
nnoremap <silent> <buffer> gh5 :Header 5<CR>
nnoremap <silent> <buffer> gh6 :Header 6<CR>
" Span & inline elements
nnoremap <silent> <buffer> gbb :Bold<CR>
vnoremap <silent> <buffer> gbb :Bold 1<CR>
nnoremap <silent> <buffer> gii :Italic<CR>
vnoremap <silent> <buffer> gii :Italic 1<CR>
" --> Overwrite TComment map in markdown fies
nnoremap <silent> <buffer> gcc :Code<CR>
vnoremap <silent> <buffer> gcc :Code 1<CR>
" Links & img
nnoremap <silent> <buffer> gim :Image<CR>
vnoremap <silent> <buffer> gim :Image 1<CR>
nnoremap <silent> <buffer> gli :Link<CR>
vnoremap <silent> <buffer> gli :Link 1<CR>
" Lists & Blocks
nnoremap <silent> <buffer> gbq :BlockQuote<CR>
vnoremap <silent> <buffer> gbq :BlockQuote 1<CR>
nnoremap <silent> <buffer> gbc :BlockCode<CR>
vnoremap <silent> <buffer> gbc :BlockCode 1<CR>
