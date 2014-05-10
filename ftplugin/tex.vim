" For Tex files.
" Last modification: 2014-05-10


" =========== MAPPINGS =======================
" Compile a Tex file and generate a pdf file (Unix).
" Also open the generated pdf from Tex file compilation with Evince in Linux and default-pdf reader in Windows.
" {
	" *** <F9>		=> Compile.
	" *** <C-F9>	=> Open the pdf.
		nmap <silent> <buffer> <F9> :!pdflatex "%:p"<CR>
		if has ('win32') || has('win64')
			nmap <silent> <buffer> <c-F9> :!start cmd /c ""%:p:r.pdf"<CR>
		else
			nmap <silent> <buffer> <c-F9> :!evince "%:p:r.pdf" &<CR><CR>
		endif
" }
