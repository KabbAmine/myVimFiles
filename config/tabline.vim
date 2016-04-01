" ========== Custom tabline =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-04-01
" =================================================

" Not mandatory, but the bufline uses the following plugins:
" * Devicons

" Lines
function! MyBufLine() abort " {{{1
	let l:bl = '%#TablineFill#'
	let l:bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
	let l:bufsL = []
	for l:b in l:bufs
		let l:mod = (getbufvar(l:b, '&modified') ==# 1 ? ' +' : '')
		let l:devicon = exists('*WebDevIconsGetFileTypeSymbol()') ?
					\ WebDevIconsGetFileTypeSymbol(bufname(l:b)) . ' ' : ''
		let l:name = empty(bufname(l:b)) ?
					\ l:devicon . '[No Name]' :
					\ (winwidth(0) <=# 85 ?
						\ l:devicon . fnamemodify(bufname(l:b), ':t') . l:mod :
						\ l:devicon . pathshorten(fnamemodify(bufname(l:b), ':.')) . l:mod
					\ )
		if l:b ==# bufnr('%')
			let l:bl .= '%#TabLineSel# ' . l:name . ' %#TabLineFill# '
		else
			let l:bl .= '%#TabLine# ' . l:name . ' %#TabLineFill# '
		endif
	endfor
	let l:ww = winwidth(0)
	let l:getCwd = fnamemodify(getcwd(), ':~')
	let l:cwd = l:ww <=# 85 ? 'B' :
				\ len(l:getCwd) >=# 15 ? pathshorten(l:getCwd) : l:getCwd
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
hi TabLineSel gui=none guifg=#222222 guibg=#ffbe3c term=none cterm=none ctermfg=235 ctermbg=215
augroup TabBufLine
	autocmd!
	autocmd BufAdd,BufDelete,TabEnter,TabLeave,VimEnter *
				\ call TLInit()
augroup END
call TLInit()
" 1}}}

" Replace the default <F5> mapping
nnoremap <F5> :tabonly\|call TLInit()<CR>

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
