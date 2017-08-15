" ========== Helpers & useful functions ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-08-17
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
	let l:hi = ['WarningMsg', 'ErrorMsg', 'DiffAdd']
	execute 'echohl ' . l:hi[l:t]
	echomsg a:message
	echohl None
endfunction
function! helpers#GetVisualSelection() abort " {{{1
	let l:pos = getpos("'<")
	call setpos('.', l:pos)
	return getline('.')[col("'<") - 1 : col("'>") - 1]
endfunction
function! helpers#GetMotionResult() abort " {{{1
	return getline('.')[col("'[") - 1 : col("']") - 1]
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

" 1}}}

" Jobs
function! s:HasJob() abort " {{{1
	if !has('job')
		call helpers#Log('Your vim version does not support "jobs"', 1)
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
function! helpers#Delete(...) abort " {{{1
	let l:a = map(copy(a:000), 'fnamemodify(v:val, ":p")')
	for l:f in l:a
		if filereadable(l:f)
			if delete(l:f) ==# 0
				call helpers#Log('"' . l:f . '" was deleted', 2)
			else
				call helpers#Log('"' . l:f . '" was not deleted', 1)
			endif
		elseif isdirectory(l:f)
			let l:cmd = g:hasUnix ?
						\ 'rm -vr %s' :
						\ 'RD /S %s'
			echo split(system(printf(l:cmd, escape(l:f, ' '))), "\n")[0]
		endif
	endfor
endfunction
function! helpers#MakeDir(...) abort " {{{1
	for l:d in a:000
		if !isdirectory(l:d)
			call mkdir(l:d, 'p')
			call helpers#Log('"' . l:d . '" was created', 2)
		else
			call helpers#Log('"' . l:d . '" exists already')
		endif
	endfor
endfunction
function! helpers#Rename(to) abort " {{{1
	let l:file = expand('%:p')
	if !filereadable(l:file)
		call helpers#Log('Not a valid file', 1)
	else
		let l:buf = expand('%')
		silent execute 'saveas ' . a:to
		silent execute 'bdelete! ' . l:buf
		if delete(l:file) ==# 0
			call helpers#Log('Renamed to "' . a:to . '"', 2)
		else
			call helpers#Log('"' . l:file . '" was not renamed', 1)
		endif
	endif
endfunction
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
