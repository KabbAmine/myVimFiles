" Last modification: 2018-10-09


" Toggle current task list state " {{{1
nnoremap <silent> <buffer> <space> :call <SID>toggle_task_list()<CR>

fun! <SID>toggle_task_list() abort " {{{2
	let line = line('.')
	let cl = getline('.')
	let reg_start = '\v^\s*\S \['
	if cl =~# reg_start
		if cl =~# reg_start . ' \]'
			call setline(line, substitute(cl, '\v\[ \]', '[x]', ''))
		else
			call setline(line, substitute(cl, '\v\[x\]', '[ ]', ''))
		endif
	endif
endfun " 2}}}
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
