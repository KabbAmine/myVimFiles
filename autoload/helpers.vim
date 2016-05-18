" ========== Helpers & useful functions ======
" Last modification: 2016-05-18
" ============================================

" Misc
function! helpers#AutoCmd(name, cmd, events) abort " {{{1
	" Execute a:cmd in a:name augroup when [a:event] is(are) executed.
	" Re-execute the function toggle the state.


	if !exists('#' . a:name)
		execute 'augroup ' . a:name
			autocmd!
			execute 'autocmd ' . join(a:events) . ' <buffer> :' . a:cmd
		augroup END
		echo 'Auto ' . a:name .' update enabled'
		silent execute a:cmd
	else
		execute 'augroup ' . a:name
			autocmd!
		augroup END
		execute 'augroup! ' . a:name
		echo 'Auto ' . a:name .' update disabled'
	endif
endfunction
function! helpers#Log(message, ...) abort " {{{1
	" Echo message with a:1 index hi group.

	let l:t = exists('a:1') ? a:1 : 0
	let l:hi = ['WarningMsg', 'ErrorMsg']
	execute 'echohl ' . l:hi[l:t]
	echo a:message
	echohl None
endfunction
function! helpers#OpenOrMove2Buffer(bufName, ft, ...) abort " {{{1
	" Open or move to a:bufname (non scratch buffer if a:1 exists)

	let l:scratch = !exists('a:1') ? 1 : 0

	if !bufexists(a:bufName)
		silent execute 'sp ' . a:bufName
	elseif !bufloaded(a:bufName)
		silent execute 'sp ' . a:bufName
	elseif winnr('$') ># 1
		for l:w in range(1, winnr('$'))
			if bufname(winbufnr(l:w)) ==# a:bufName
				execute l:w . 'wincmd w'
			endif
		endfor
	endif

	if !empty(a:ft)
		let &filetype = a:ft
	endif

	if l:scratch
		setlocal noswapfile
		setlocal buftype=nofile
	endif
endfunction
function! helpers#ExecuteInBuffer(bufName, start, end, ftDict) abort " {{{1
	" Execute [a:start, a:end] in a:bufName using values from a:ftDict
	" Exception for vim filetype wich use helpers#ExecuteViml()

	let l:sel = getline(a:start, a:end)
	let l:ft = &ft

	if l:sel !=# [''] && has_key(a:ftDict, l:ft)

		let l:cmd = get(a:ftDict, l:ft)[0]
		if executable(split(l:cmd)[0])
			let l:newFt = get(a:ftDict, l:ft)[1]
			call helpers#OpenOrMove2Buffer(a:bufName, l:newFt)
			wincmd L

			" Always delete buffer's content
			silent %delete_

			call setline(1, l:sel)
			silent execute '%!' . l:cmd

			wincmd p
		else
			call helpers#Log(split(l:cmd)[0] . ' was not found')
		endif
	else
		call helpers#Log('No content or provider found', 1)

	endif
endfunction
function! helpers#MakeTextObjects(to) abort " {{{1
	" a:to is a dictionnary
	" e.g.

	let l:to = a:to

	" For all ft
	for [l:k, l:m] in l:to._
		execute 'onoremap <silent> ' . l:k . ' :normal! ' . l:m . '<CR>'
		execute 'vnoremap <silent> ' . l:k . ' :<C-u>normal! ' . l:m . '<CR>'
	endfor
	call remove(l:to, '_')

	augroup MyTextObjects
		autocmd!
		for l:ft in keys(l:to)
			for [l:k, l:m] in l:to[l:ft]
				execute 'autocmd FileType ' . l:ft . ' onoremap <buffer> <silent> ' . l:k . ' :normal! ' . l:m . '<CR>'
				execute 'autocmd FileType ' . l:ft . ' vnoremap <buffer> <silent> ' . l:k . ' :<C-u>normal! ' . l:m . '<CR>'
			endfor
		endfor
	augroup END

endfunction
" 1}}}

" Using the shell or external programs
function! helpers#OpenHere(type, ...) abort " {{{1
	" type: (t)erminal, (f)ilemanager
	" a:1: Location (pwd by default)

	let l:cmd = {
				\ 't': (g:hasUnix ?
				\	'exo-open --launch TerminalEmulator --working-directory %s 2> /dev/null &' :
				\	'start cmd /k cd %s'),
				\ 'f': (g:hasUnix ?
				\	'xdg-open %s 2> /dev/null &' :
				\	'start explorer %s')
				\ }
	execute printf('silent !' . l:cmd[a:type], (exists('a:1') ? a:1 : getcwd()))

	if !g:hasGui | redraw! | endif

endfunction
function! helpers#OpenUrl() abort " {{{1
	" Open the current URL
	" - If line begins with "Plug" or "call s:PlugInOs", open the github page of the plugin

	let l:cl = getline('.')
	let l:url = escape(matchstr(l:cl, '[a-z]*:\/\/\/\?[^ >,;()]*'), '%')
	if l:cl =~# 'Plug' || l:cl =~# 'call s:PlugInOs'
		let l:pn = l:cl[match(l:cl, "'", 0, 1) + 1 : match(l:cl, "'", 0, 2) - 1]
		let l:url = printf('https://github.com/%s', l:pn)
	endif
	if !empty(l:url)
		let l:url = substitute(l:url, "'", '', 'g')
		let l:wmctrl = executable('wmctrl') && v:windowid !=# 0 ?
					\ ' && wmctrl -ia ' . v:windowid : ''
		exe 'silent :!' . (g:hasUnix ?
					\	'x-www-browser ' . shellescape(l:url) :
					\	' start "' . shellescape(l:url)) .
					\ l:wmctrl .
					\ (g:hasUnix ? ' 2> /dev/null &' : '')
		if !g:hasGui | redraw! | endif
	endif
	
endfunction
function! helpers#KillProcess(pattern) abort " {{{1
	" TODO: Handle windows

	if g:hasUnix
		let pid = split(system('ps -ef | grep "' . a:pattern . '" | tr -s " "'), "\n")[0]
		if !empty(pid) && pid =~# 'pts'
			let pid = matchstr(pid, '\v^' . $USER . ' \zs\d{1,}')
			silent execute '!kill ' . pid
		endif
	endif
endfunction
function! helpers#Delete(...) abort " {{{1
	let l:a = map(copy(a:000), 'fnamemodify(v:val, ":p")')
	for l:f in l:a
		if filereadable(l:f)
			if delete(l:f) ==# 0
				echohl Statement | echo l:f . ' was deleted' | echohl None
			endif
		elseif isdirectory(l:f)
			let l:cmd = g:hasUnix ?
						\ 'rm -vr %s' :
						\ 'RD /S %s'
			echo system(printf(l:cmd, escape(l:f, ' ')))
		endif
	endfor
endfunction
function! helpers#MakeDir(...) abort " {{{1
	for l:d in a:000
		if !isdirectory(l:d)
			call mkdir(l:d, 'p')
			echohl Statement | echo l:d . '/ was created' | echohl None
		else
			echohl Error | echo l:d . '/ exists already' | echohl None
		endif
	endfor
endfunction
function! helpers#Rename(to) abort " {{{1
	let l:file = expand('%:p')
	if !filereadable(l:file)
		echohl Error | echo 'Not a valid file' | echohl None
	else
		let l:buf = expand('%')
		silent execute 'saveas ' . a:to
		silent execute 'bdelete! ' . l:buf
		call delete(l:file)
		echohl Statement | echo 'Renamed to "' . a:to . '"' | echohl None
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
