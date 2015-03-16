" For Python files.
" Last modification: 2015-03-16

" =========== VARIOUS =======================
" Set indentation to 2.
" {
	set expandtab
	set shiftwidth=2
	set softtabstop=2
	set expandtab
" }

" =========== MAPPINGS =======================
" Execute a python file *******
" {
	" *** <F9>		=> Python2
	" *** <C-F9>	=> Python3
		nmap <silent> <buffer> <F9> :!python "%:p"<CR>
		nmap <silent> <buffer> <c-F9> :!python3 "%:p"<CR>
" }

" =========== COMMANDS =======================
" Set Python2 or Python3 syntax ***
" {
	" *** :Py2		=> For py2
	" *** :Py3		=> For py3
		command! Py2 :Python2Syntax
		command! Py3 :Python3Syntax
" }
