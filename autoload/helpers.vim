" ========== Helpers & useful functions ======
" Last modification: 2016-04-15
" ============================================

" Misc
function! helpers#Buffers() abort " {{{1
	" Buffer lister where you can:
	" * Open (e/sp/vs/t)
	" * Delete

	redir => l:bufs
	silent buffers
	redir END
	let l:bufsL = []
	for l:b in split(l:bufs[1:], "\n")
		let l:bn = matchstr(l:b, '\d\+')
		let l:bs = matchstr(l:b, '+')
		let l:bf = pathshorten(substitute(matchstr(l:b, '".*"'), '"', '', 'g'))
		call add(l:bufsL, printf("  %2d %2s  %s", l:bn, l:bs, l:bf))
	endfor
	echohl Function | echo 'Buffers:' | echohl None
	echo join(l:bufsL, "\n")
	echohl Statement
	let l:buf = input('> ', '', 'buffer')
	if empty(l:buf)
		return 0
	endif
	redraw
	echo '(t)ab, (s)plit, (v)split, (d)elete > '
	echohl None
	let l:action = nr2char(getchar())
	if l:action ==# 'v'
		let l:c = 'botright vsplit'
	elseif l:action ==# 's'
		let l:c = 'split'
	elseif l:action ==# 't'
		let l:c = 'tabedit!'
	elseif l:action ==# 'd'
		let l:c = 'bd!'
	else
		let l:c = 'buffer!'
	endif
	execute printf('silent %s %s', l:c, l:buf)
endfunction
" 1}}}

" Using the shell
function! helpers#KillProcess(pattern) abort " {{{1
	" TODO: Handle windows

	let pid = split(system('ps -ef | grep "' . a:pattern . '" | tr -s " "'), "\n")[0]
	if !empty(pid) && pid =~# 'pts'
		let pid = matchstr(pid, '\v^' . $USER . ' \zs\d{1,}')
		silent execute '!kill ' . pid
	endif
endfunction
" 1}}}

" For plugins
function! helpers#CmdForDispatcher(cmd) abort " {{{1
	" A wrapper to use with dispatcher plugins (Vimux, dispatch...)
	" e.g of a:cmd: "VimuxRunCommand '%s'"

	let g:last_dispatcher_cmd = exists('g:last_dispatcher_cmd') ? g:last_dispatcher_cmd : ''
	echohl Statement
	let l:uc = input('Command> ', g:last_dispatcher_cmd)
	echohl None
	if !empty(l:uc)
		let g:last_dispatcher_cmd = l:uc
		let l:c = printf('cd %s && clear; %s', getcwd(), l:uc)
		silent execute printf(a:cmd, l:c)
		redraw!
	endif
endfunction
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
