" ========== Custom tabline =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-09-11
" =================================================

" Not mandatory, but the bufline uses the following plugins:
" * Devicons
" * tabpagecd

" Lines
function! MyBufLine() abort " {{{1
	let l:bl = '%#TablineFill#'
	let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	let l:bufsL = []
	for l:b in l:bufs
		" Show buffers only when we have more than one
		if len(l:bufs) ==# 1
			break
		endif
		let l:mod = (getbufvar(l:b, '&modified') ==# 1 ? ' +' : '')
		let l:devicon = exists('*WebDevIconsGetFileTypeSymbol()') ?
					\ WebDevIconsGetFileTypeSymbol(bufname(l:b)) . ' ' : ''
		let l:name = l:devicon . (!empty(bufname(l:b)) ?
					\	pathshorten(fnamemodify(bufname(l:b), ':.')) . l:mod :
					\	'[No Name]'
					\ )
		if l:b ==# bufnr('%')
			let l:bl .= '%#TabLineSel# ' . l:name . ' %#TabLineFill# '
		else
			let l:bl .= '%#TabLine# ' . l:name . ' %#TabLineFill# '
		endif
	endfor
	let l:getCwd = fnamemodify(getcwd(), ':~')
	let l:cwd = len(l:getCwd) >=# 15 ? pathshorten(l:getCwd) : l:getCwd
	let l:bl .= '%=%#IncSearch# ' . l:cwd . ' '

	return l:bl
endfunction
function! MyTabLine() abort " {{{1
	" :h setting-tabline
	let l:tl = ''
	for i in range(tabpagenr('$'))
		let l:i = i + 1
		let l:tl .= (l:i ==# tabpagenr()) ?
					\ ' %#TabLineSel#' : ' %#TabLine#'
		" Set the tab page number (for mouse clicks)
		let l:tl .= '%' . l:i . 'T '
		" Get working directory (Use tabpagecd if present, otherwise use
		" getcwd()).
		if !empty(gettabvar(l:i, 'cwd'))
			let l:tl .= tabpagenr('$') >=# 5 ?
						\ fnamemodify(gettabvar(l:i, 'cwd'), ':t') :
						\ pathshorten(fnamemodify(gettabvar(l:i, 'cwd'), ':~'))
		else
			let l:tl .= tabpagenr('$') >=# 5 ?
						\ fnamemodify(getcwd(), ':t') :
						\ pathshorten(fnamemodify(getcwd(), ':~'))
		endif
		let l:tl .= '%' . l:i . 'X ⨉'
		" Fill with TabLineFill and reset tab page nr
		let l:tl .= ' %#TabLineFill#%T'
	endfor
	let l:tl .= '%=%#TabLineSel# T '
	return l:tl
endfunction
" 1}}}

" Helpers
function! TLInit() abort " {{{1
	set tabline=
	set showtabline=2
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
hi! link TablineSel StatusLine
augroup TabBufLine
	autocmd!
	autocmd BufAdd,BufDelete,TabEnter,TabLeave,VimEnter *
				\ call TLInit()
augroup END
call TLInit()
" 1}}}

" Replace the default <F5> mapping
nnoremap <silent> <F5> :tabonly\|call TLInit()<CR>

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
