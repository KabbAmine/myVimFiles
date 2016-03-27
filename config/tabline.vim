" ========== Custom tabline =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-03-27
" =================================================

" Lines
function! MyBufLine() abort " {{{1
	let l:bl = '%#TablineFill#'
	let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	let l:bufsL = []
	for l:b in l:bufs
		let l:mod = (getbufvar(l:b, '&modified') ==# 1 ? ' +' : '')
		let l:name = empty(bufname(l:b)) ?
					\ '[No Name]' :
					\ (winwidth(0) <=# 85 ?
						\ fnamemodify(bufname(l:b), ':t') . l:mod :
						\ pathshorten(fnamemodify(bufname(l:b), ':.')) . l:mod
					\ )
		if l:b ==# bufnr('%')
			let l:bl .= '%#TabLineSel# ' . l:name . ' %#TabLineFill# '
		else
			let l:bl .= '%#TabLine# ' . l:name . ' %#TabLineFill# '
		endif
	endfor
	let l:cwd = winwidth(0) <=# 85 ? 'B' : fnamemodify(getcwd(), ':~')
	let l:bl .= '%=%#IncSearch# ' . l:cwd . ' '

	return l:bl
endfunction
function! MyTabLine() abort " {{{1
	" :h setting-tabline
	let l:tl = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr()
			let l:tl .= '%#TabLineSel#'
		else
			let l:tl .= '%#TabLine#'
		endif
		" Set the tab page number (for mouse clicks)
		let l:tl .= '%' . (i + 1) . 'T'
		let l:tl .= ' ' . (i + 1) . ' '
		" Fill with TabLineFill and reset tab page nr
		let l:tl .= '%#TabLineFill#%T'
	endfor
	if tabpagenr('$') > 1
		let l:tl .= '%=%#TabLineSel#%999X x '
	endif
	return l:tl
endfunction
" 1}}}

" Helpers
function! TLInit() abort " {{{1
	set tabline=
	set showtabline=0
	if tabpagenr('$') ==# 1
		let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
		let &showtabline = len(l:bufs) ># 1 ? 2 : &showtabline
		set tabline=%!MyBufLine()
	else
		set showtabline=2
		set tabline=%!MyTabLine()
	endif
endfunction
" 1}}}

" Initialization {{{1
augroup TabBufLine
	autocmd!
	autocmd BufAdd,BufDelete,TabEnter,TabLeave,VimEnter *
				\ call TLInit()
augroup END
" 1}}}

call TLInit()

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
