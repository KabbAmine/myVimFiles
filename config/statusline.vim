" ========== Custom statusline + mappings =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-08-19
" ===============================================================


" The used plugins are (They are not mandatory):
" * Fugitive
" * GitGutter
" * Rvm
" * ALE
" * Unite (+unite-cmus)
" * zoomwintab
" * gutentags

" Configuration " {{{1
let s:SL  = {
			\ 'separator': '',
			\ 'ignore': ['qf', 'nerdtree', 'undotree', 'diff'],
			\ 'apply': {
				\ 'unite': 'unite#get_status_string()',
			\ },
			\ 'checker': g:checker,
			\ 'colors': {
				\ 'background'      : ['#2f343f', 'none'],
				\ 'backgroundDark'  : ['#191d27', '16'],
				\ 'backgroundLight' : ['#464b5b', '59'],
				\ 'green'           : ['#2acf2a', '40'],
				\ 'main'            : ['#5295e2', '68'],
				\ 'red'             : ['#f01d22', '160'],
				\ 'text'            : ['#cbcbcb', '251'],
				\ 'textDark'        : ['#8c8c8c', '244'],
			\ },
			\ 'modes': {
				\ 'n': 'N',
				\ 'i': 'I',
				\ 'R': 'R',
				\ 'v': 'V',
				\ 'V': 'V-L',
				\ 'c': 'C',
				\ "\<C-v>": 'V-B',
				\ 's': 'S',
				\ 'S': 'S-L',
				\ "\<C-s>": 'S-B',
				\ '?': '',
			\ }
		\ }
" 1}}}

" General items
function! SLFilename() abort " {{{1
	if !empty(expand('%:t'))
		let l:fn = winwidth(0) <# 55 ?
					\ expand('%:t') :
					\ (winwidth(0) ># 85 ? expand('%:.') : pathshorten(expand('%:.')))
	else
		let l:fn = '[No Name]'
	endif
	return
				\ l:fn .
				\ (&readonly ? ' ' : '')
endfunction
function! SLModified() abort " {{{1
	return (&modified ? '+' : '')
endfunction
function! SLFileformat() abort " {{{1
	return winwidth(0) ># 85 ? &fileformat :
				\ (winwidth(0) <# 55 ? '' : &fileformat[0])
endfunction
function! SLFiletype() abort " {{{1
	return strlen(&filetype) ? &filetype : ''
endfunction
function! SLFileencoding() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ (strlen(&fenc) ? &fenc : &enc)
endfunction
function! SLHiGroup() abort " {{{1
	return '➔ ' . synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction
function! SLMode() abort " {{{1
	return winwidth(0) <# 75 ? get(s:SL.modes, mode()) : get(s:SL.modes, mode())
endfunction
function! SLPaste() abort " {{{1
	return &paste ? (winwidth(0) <# 55 ? '[P]' : '[PASTE]') : ''
endfunction
function! SLPython() abort " {{{1
	let l:p = executable('python') ?
				\ system('python --version')[7:-2] : ''
	let l:p3 = executable('python3') ?
				\ system('python3 --version')[7:-2] : ''
	return printf('[py %s - %s]', l:p, l:p3)
endfunction
function! SLSpell() abort " {{{1
	return &spell ?
				\ toupper(&spelllang[0]) . &spelllang[1:] : ''
endfunction
function! SLIndentation() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ &expandtab ?
				\	's:' . &shiftwidth : 't:' . &shiftwidth
endfunction
function! SLColumnAndPercent() abort " {{{1
	let l:col = col('.')
	let l:perc = (line('.') * 100) / line('$')
	return winwidth(0) <# 55 ?
				\ '' : l:col . ' ' . l:perc . '%'
endfunction
function! SLJobs() abort " {{{1
	let l:nJobs = exists('g:jobs') ? len(g:jobs) : 0
	return winwidth(0) <# 55 ? '' :
				\ (l:nJobs !=# 0) ? ' ' . l:nJobs : ''
endfunction
function! SLToggled() abort " {{{1
	if !exists('g:SL_toggle')
		return ''
	endif
	let l:sl = ''
	for [l:k, l:v] in items(g:SL_toggle)
		let l:str = call(l:v, [])
		let l:sl .= empty(l:sl) ?
					\	l:str . ' ' :
					\	s:SL.separator . ' ' . l:str . ' '
	endfor
	return l:sl[:-2]
endfunction
" 1}}}

" From Plugins
function! SLGitGutter() abort " {{{1
	if exists('g:gitgutter_enabled') && g:gitgutter_enabled
		let l:h = GitGutterGetHunkSummary()
		return !empty(SLFugitive()) && !empty(l:h) && l:h !=# [0,0,0] && (winwidth(0) ># 55) ?
					\ printf('+%d ~%d -%d', l:h[0], l:h[1], l:h[2]) :
					\ ''
	else
		return ''
	endif
endfunction
function! SLFugitive() abort " {{{1
	let l:i = ' '
	return exists('*fugitive#head') && !empty(fugitive#head()) && (winwidth(0) ># 55) ?
				\ (fugitive#head() ==# 'master' ? l:i . 'm' : l:i . fugitive#head()) : ''
endfunction
function! SLGutentags() abort " {{{1
	return exists('*gutentags#statusline') ? gutentags#statusline(' ') : ''
endfunction
function! SLRuby() abort " {{{1
	if g:hasGui && exists('*rvm#statusline()') && !empty(rvm#statusline())
		let l:r = matchstr(rvm#statusline(), '\d.*[^\]]')
	elseif executable('ruby')
		let l:r = matchstr(system('ruby -v')[5:], '[a-z0-9.]*\s')[:-2]
	else
		let l:r = ''
	endif
	return printf('[ruby %s]', l:r)
endfunction
function! SLAle(mode) abort " {{{1
	" a:mode: 1/0 = errors/ok

	if !g:loaded_ale
		return ''
	endif

	if empty(ale#linter#Get(&ft))
		return ''
	endif

	let l:counts = ale#statusline#Count(bufnr('%'))

	let l:total = l:counts.total
	let l:errors = l:counts.error + l:counts.style_error
	let l:warnings = l:counts.warning + l:counts.style_warning

	let l:errors_str = l:errors !=# 0 ?
				\	printf('%s %s', s:SL.checker.error_sign, l:errors) : ''
	let l:warnings_str = l:warnings !=# 0 ?
				\	printf('%s %s', s:SL.checker.warning_sign, l:warnings) : ''

	let l:default_str = printf('%s %s', l:errors_str, l:warnings_str)
	" Trim spaces
	let l:default_str = substitute(l:default_str, '^\s*\(.\{-}\)\s*$', '\1', '')
	let l:success_str = s:SL.checker.success_sign

	if a:mode
		return l:total ==# 0 ? '' : l:default_str
	else
		return l:total ==# 0 ? l:success_str : ''
	endif
endfunction
function! SLCmus() abort " {{{1
	return !empty(cmus#get().statusline_str()) ?
				\ cmus#get().statusline_str() : ''
endfunction
function! SLZoomWinTab() abort " {{{1
	return exists('t:zoomwintab') ? ' ' : ''
endfunction
" 1}}}

" Helpers
function! s:Hi(group, bg, fg, opt) abort " {{{1
	let l:bg = type(a:bg) ==# type('') ? ['none', 'none' ] : a:bg
	let l:fg = type(a:fg) ==# type('') ? ['none', 'none'] : a:fg
	let l:opt = empty(a:opt) ? ['none', 'none'] : [a:opt, a:opt]
	let l:mode = ['gui', 'cterm']
	let l:cmd = 'hi ' . a:group . ' term=' . l:opt[1]
	for l:i in (range(0, len(l:mode)-1))
		let l:cmd .= printf(' %sbg=%s %sfg=%s %s=%s',
					\ l:mode[l:i], l:bg[l:i],
					\ l:mode[l:i], l:fg[l:i],
					\ l:mode[l:i], l:opt[l:i]
					\ )
	endfor
	execute l:cmd
endfunction
function! s:SetColors() abort " {{{1
	call s:Hi('User1', s:SL.colors['main']           , s:SL.colors['background']     , 'bold')
	call s:Hi('User2', s:SL.colors['backgroundLight'], s:SL.colors['text']           , 'none')
	call s:Hi('User3', s:SL.colors['backgroundLight'], s:SL.colors['textDark']       , 'none')
	call s:Hi('User4', s:SL.colors['main']           , s:SL.colors['background']     , 'none')
	" Modified state
	call s:Hi('User5', s:SL.colors['backgroundLight'], s:SL.colors['main']           , 'bold')
	" Error & success states
	call s:Hi('User6', s:SL.colors['green']          , s:SL.colors['backgroundLight'], 'bold')
	call s:Hi('User7', s:SL.colors['red']            , s:SL.colors['text']           , 'bold')
	" Inactive SL
	call s:Hi('User8', s:SL.colors['backgroundDark'] , s:SL.colors['backgroundLight'], 'none')
	hi! link StatuslineNC User8
endfunction
function! GetSL(...) abort " {{{1
	let l:sl = ''

	" CUSTOM FUNCTIONS
	if has_key(s:SL.apply, &ft)
		let l:f = get(s:SL.apply, &ft)
		if exists('*' . l:f)
			let l:sl = '%{' . l:f . '}'
		endif
		return l:sl
	endif

	" INACTIVE STATUSLINE
	if exists('a:1')
		let l:sl .= ' %{SLFilename()}'
		let l:sl .= '%( %{SLModified()}%)'
		return l:sl
	endif

	" ACTIVE STATUSLINE
	let l:sl .= '%1* %-{SLMode()} %(%{SLPaste()} %)'
	let l:sl .= '%(%3* %{SLZoomWinTab()}%)'
	let l:sl .= '%2* %{SLFilename()}'
	let l:sl .= '%(%5* %{SLModified()}%)'

	let l:sl .= '%3*'
	let l:sl .= '%='

	" Git stuffs
	let l:sl .= '%( %{SLGitGutter()} %)'
	let l:sl .= '%(%{SLFugitive()} ' . s:SL.separator . '%)'

	let l:sl .= '%( %{SLFiletype()} ' . s:SL.separator . '%)'
	let l:sl .= '%( %{SLIndentation()} ' . s:SL.separator . '%)'
	let l:sl .= '%( %{SLSpell()} ' . s:SL.separator . '%)'
	let l:sl .= '%( %{SLColumnAndPercent()} ' . s:SL.separator . '%)'
	let l:sl .= '%('
	let l:sl .= ' %{SLFileencoding()}'
	let l:sl .= '[%{SLFileformat()}] '
	let l:sl .= '%)'

	" ALE (1st group for no errors)
	let l:sl .= '%6*%( %{SLAle(0)} %)'
	let l:sl .= '%7*%( %{SLAle(1)} %)'

	let l:sl .= '%4*'

	" Gutentags
	let l:sl .= '%( %{SLGutentags()} %)'

	" Jobs
	let l:sl .= '%( %{SLJobs()} %)'

	" Toggled elements
	let l:sl .= '%( %{SLToggled()} %)'

	return l:sl
endfunction
function! <SID>ToggleSLItem(var, funcref) abort " {{{1
	if !exists('g:SL_toggle')
		let g:SL_toggle = {}
	endif
	if has_key(g:SL_toggle, a:var)
		call remove(g:SL_toggle, a:var)
	else
		let g:SL_toggle[a:var] = a:funcref
	endif
endfunction
function! <SID>SLInit() abort " {{{1
	set noshowmode
	set laststatus=2
	call s:SetColors()
	call <SID>ApplySL()
	augroup SL
		autocmd!
		autocmd TabEnter,BufEnter,BufNew,WinEnter * call <SID>ApplySL()
		autocmd WinLeave * call <SID>ApplySL(1)
	augroup END
endfunction
function! <SID>ApplySL(...) abort " {{{1
	if index(s:SL.ignore, &ft) ==# -1
		execute !exists('a:1') ?
					\ 'setl statusline=%!GetSL()' :
					\ 'setl statusline=%!GetSL(0)'
	endif
endfunction
" 1}}}

" Mappings {{{1
nnoremap <silent> gsH  :call <SID>ToggleSLItem('hi', 'SLHiGroup')<CR>
nnoremap <silent> gsS  :let &laststatus = (&laststatus !=# 0 ? 0 : 2)<CR>
if g:hasUnix
	" Use it once, they are slow
	nnoremap <silent> gsR  :call <SID>ToggleSLItem('ruby', 'SLRuby')<CR>
	nnoremap <silent> gsP  :call <SID>ToggleSLItem('python', 'SLPython')<CR>
	nnoremap <silent> gsC  :call <SID>ToggleSLItem('cmus', 'SLCmus')<CR>
endif
" 1}}}

call <SID>SLInit()


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
