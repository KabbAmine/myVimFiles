" For Markdown files.
" Last modification: 2016-04-05

" =========== VARIOUS =======================
setlocal nonumber

" =========== MAPPINGS =======================
" Convert a Markdown syntax to HTML (Unix) " {{{1
nnoremap <silent> <buffer> <F9> :%!markdown<CR>
" Toggle current task list state " {{{1
nnoremap <silent> <buffer> <space> :call <SID>ToggleTaskList()<CR>
function! <SID>ToggleTaskList() abort " {{{2
	let l:line = line('.')
	let l:cl = getline('.')
	let l:regStart = '\v^\s*\S \['
	if l:cl =~# l:regStart
		if l:cl =~# l:regStart . ' \]'
			call setline(l:line, substitute(l:cl, '\v\[ \]', '[x]', 'g'))
		else
			call setline(l:line, substitute(l:cl, '\v\[x\]', '[ ]', 'g'))
		endif
	endif
endfunction " 2}}}
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
