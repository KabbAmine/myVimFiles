" Last modification: 2017-09-10


setlocal nonumber

" Toggle current task list state " {{{1
nnoremap <silent> <buffer> <space> :call <SID>ToggleTaskList()<CR>

function! <SID>ToggleTaskList() abort " {{{2
	let l:line = line('.')
	let l:cl = getline('.')
	let l:reg_start = '\v^\s*\S \['
	if l:cl =~# l:reg_start
		if l:cl =~# l:reg_start . ' \]'
			call setline(l:line, substitute(l:cl, '\v\[ \]', '[x]', ''))
		else
			call setline(l:line, substitute(l:cl, '\v\[x\]', '[ ]', ''))
		endif
	endif
endfunction " 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
