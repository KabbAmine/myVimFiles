" ========== Helpers & useful functions ======
" Last modification: 2016-07-24
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
	let l:hi = ['WarningMsg', 'ErrorMsg', 'SuccessState']
	execute 'echohl ' . l:hi[l:t]
	echomsg a:message
	echohl None
endfunction
function! helpers#OpenOrMove2Buffer(bufName, ft, split,...) abort " {{{1
	" Open or move to a:bufname (non scratch buffer if a:1 exists)

	let l:scratch = !exists('a:1') ? 1 : 0

	if !bufexists(a:bufName)
		silent execute a:split . ' ' . a:bufName
	elseif !bufloaded(a:bufName)
		silent execute a:split . ' ' . a:bufName
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
	" Execute lines[a:start, a:end] in a:bufName using values from a:ftDict

	" Get content and current filetype
	let l:sel = getline(a:start, a:end)
	let l:ft = &ft

	if l:sel ==# [''] || !has_key(a:ftDict, l:ft)
		call helpers#Log('No content or provider found', 1)
		return 0
	endif

	let l:_ = get(a:ftDict, l:ft)

	let l:cmd = get(l:_, 'cmd')
	let l:newFt = get(l:_, 'ft')
	let l:exec = get(l:_, 'exec')
	let l:tmp = get(l:_, 'tmp')

	" Check if the 1st word in cmd is an executable
	if !executable(split(l:cmd)[0])
		call helpers#Log(split(l:cmd)[0] . ' was not found')
		return 0
	endif

	if l:tmp
		" Use a temporary file
		call helpers#OpenOrMove2Buffer(a:bufName, l:newFt, 'vs', 1)
		silent %delete_
		call setline(1, l:sel)

		let l:tmpFile = tempname()

		let l:extIn = matchstr(l:cmd, '%i\zs.\S*')
		let l:extIn = !empty(l:extIn) ? l:extIn : ''
		let l:inFile = l:tmpFile . l:extIn

		let l:extOut = matchstr(l:cmd, '%o\zs.\S*')
		let l:extOut = !empty(l:extOut) ? l:extOut : ''
		let l:outFile = l:tmpFile . l:extOut

		silent execute 'saveas ' . l:inFile

		let l:cmd = substitute(l:cmd, '%i', l:tmpFile, '')
		let l:cmd = substitute(l:cmd, '%o', l:tmpFile, '')

		call system(l:cmd)

		let l:res = l:exec ?
					\ systemlist(fnamemodify(l:tmpFile, ':p:h') .
					\		'/./' . fnamemodify(l:tmpFile, ':t:r') . l:extOut) :
					\ readfile(l:outFile)

		silent %delete_
		call setline(1, l:res)

		call delete(l:inFile)
		call delete(l:outFile)

		silent execute 'file ' . a:bufName
	else
		" Filter buffer using :!
		call helpers#OpenOrMove2Buffer(a:bufName, l:newFt, 'vs')
		silent %delete_
		call setline(1, l:sel)

		silent execute '%!' . l:cmd
	endif

	" Go back to initial window
	wincmd p

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
function! helpers#ExecFor(cmd, prefix, dir, files) abort " {{{1
	" Execute a:cmd for all a:files
	" ex1. If a:prefix is not empty
	"	('e!', 'E', '~/.vim/', ['foo', 'bar']
	"	=> command! Ef :e! ~/.vim/foo
	"	=> command! Eb :e! ~/.vim/bar
	" ex2.
	"	('source', '', '~/.vim/', ['foo', 'bar']
	"	=> source ~/.vim/foo
	"	=> source ~/.vim/bar

	for l:f in a:files
		if !empty(a:prefix)
			let l:c = a:prefix . fnamemodify(l:f, ':t:h')[0]
			silent execute printf('command! %s :%s %s%s', l:c, a:cmd, a:dir, l:f)
		else
			silent execute printf('%s %s%s', a:cmd, a:dir, l:f)
		endif
	endfor
endfunction
" 1}}}

" Jobs
function! s:HasJob() abort " {{{1
	if !has('job')
		call helpers#Log('Your vim vesion does not support "jobs"', 1)
		return 0
	else
		return 1
	endif
endfunction
function! helpers#KillAllJobs() abort " {{{1
	if exists('g:jobs') && !empty(g:jobs)
		let l:nJobs = len(g:jobs)
		let l:i = 0
		for l:j in keys(g:jobs)
			call job_stop(g:jobs[l:j])
			let l:i += 1
			unlet! g:jobs[l:j]
		endfor
		call helpers#Log(l:i . '/' . l:nJobs . ' job(s) was(were) terminated', 2)
	endif
endfunction
function! helpers#Job(name, cmd, ...) abort " {{{1
	" $1 is job options: {}

	" if !has('job')
	" 	call helpers#Log('Your vim vesion does not support "jobs"', 1)
	" 	return 0
	" endif

	let l:hasJob = s:HasJob()
	if !l:hasJob
		return 0
	endif

	if !exists('g:jobs')
		let g:jobs = {}
	endif

	if !has_key(g:jobs, a:name)
		let l:job = exists('a:1') ?
					\	job_start(a:cmd, a:1) :
					\	job_start(a:cmd, {
					\		'err_cb' : 'helpers#ErrorHandler'
					\	})
		if job_status(l:job) ==# 'run'
			call helpers#Log('Job: ' . a:name . ' is running', 2)
			let g:jobs[a:name] = l:job
		else
			call helpers#Log('Job: ' . a:name . ' is not running')
		endif
	else
		call job_stop(g:jobs[a:name], 'kill')
		unlet! g:jobs[a:name]
		call helpers#Log('Job: ' . a:name . ' stopped', 2)
	endif
endfunction
function! helpers#ErrorHandler(channel, msg) abort " {{{1
	if !empty(a:msg)
		let l:msg = printf('Job: %s: %s', a:channel, a:msg)
		call helpers#Log(l:msg, 1)
	endif
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
