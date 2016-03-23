" ========== Custom statusline + mappings =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-03-23
" ===============================================================

" The used plugins are:
" * Unite
" * GitGutter
" * Fugitive
" * Rvm
" * Syntastic

set noshowmode

" Get default CursorLineNR Highlighting {{{1
redir => s:defaultCursorLineNr
	silent hi CursorLineNR
redir END
let s:defaultCursorLineNr = matchstr(s:defaultCursorLineNr, 't.*')
" 1}}}

" Configuration " {{{1
let s:SL  = {
			\ 'colorscheme': 'yowish',
			\ 'colors': {
				\ 'background'       : ['#222222','235'],
				\ 'backgroundLight'  : ['#393939','236'],
				\ 'blue'             : ['#6699cc','67'],
				\ 'green'            : ['#2acf2a','40'],
				\ 'red'              : ['#f01d22','160'],
				\ 'text'             : ['#cbcbcb','251'],
				\ 'textDark'         : ['#8c8c8c','244'],
				\ 'violet'           : ['#d09cea','171'],
				\ 'yellow'           : ['#ffbe3c','215'],
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

function! s:Hi(group, bg, fg, opt) abort " {{{1
	let l:bg = empty(a:bg) ? ['NONE', 'NONE' ] : a:bg
	let l:fg = empty(a:fg) ? ['NONE', 'NONE'] : a:fg
	let l:opt = empty(a:opt) ? ['NONE', 'NONE'] : [a:opt, a:opt]
	let l:mode = ['gui', 'cterm']
	let l:cmd = 'hi ' . a:group
	for l:i in (range(0, len(l:mode)-1))
		let l:cmd .= printf(' %sbg=%s %sfg=%s %s=%s',
					\ l:mode[l:i], l:bg[l:i],
					\ l:mode[l:i], l:fg[l:i],
					\ l:mode[l:i], l:opt[l:i]
					\ )
	endfor
	execute l:cmd
endfunction
" Highlighting {{{1
hi! link StatusLineNC Conceal
call s:Hi('SL1'  , s:SL.colors['yellow']          , s:SL.colors['background']      , 'bold')
call s:Hi('SL1I' , s:SL.colors['green']           , s:SL.colors['background']      , 'bold')
call s:Hi('SL1R' , s:SL.colors['red']             , s:SL.colors['text']            , 'bold')
call s:Hi('SL1V' , s:SL.colors['blue']            , s:SL.colors['background']      , 'bold')
call s:Hi('SL2'  , s:SL.colors['backgroundLight'] , s:SL.colors['textDark']        , 'none')
call s:Hi('SL3'  , s:SL.colors['backgroundLight'] , s:SL.colors['text']            , 'none')
call s:Hi('SL4'  , s:SL.colors['yellow']          , s:SL.colors['background'] , 'none')
" 1}}}

" General items
function! SLFileformat() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ (winwidth(0) ># 85 ? &fileformat : &fileformat[0])
endfunction
function! SLFiletype() abort " {{{1
	return strlen(&filetype) ? &filetype : ''
endfunction
function! SLFileencoding() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ (strlen(&fenc) ? &fenc : &enc)
endfunction
function! SLBuffersNr() abort " {{{1
	redir => l:bs
		silent ls
	redir END
	let l:bNr = len(split(l:bs, "\n"))
	return l:bNr ># 1 ? l:bNr : ''
endfunction
function! SLHiGroup() abort " {{{1
	return ' ➔ ' . synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction
function! SLMode() abort " {{{1
	if &ft =~# '\v^(nerdtree|undotree)'
		return toupper(&ft[0]) . &ft[1:]
	endif
	return '▸ ' . get(s:SL.modes, mode())
endfunction
function! SLPaste() abort " {{{1
	return &paste ? '[PASTE]' : ''
endfunction
function! SLPython() abort " {{{1
	let l:p = executable('python') ?
				\ system('python --version')[7:-2] : ''
	let l:p3 = executable('python3') ?
				\ system('python3 --version')[7:-2] : ''
	return printf(' [py %s  %s]', l:p, l:p3)
endfunction
" 1}}}

" From Plugins
function! SLFilename() abort " {{{1
	if &ft ==# 'unite'
		return unite#get_status_string()
	endif
	if !empty(expand('%:t'))
		let l:fn = winwidth(0) <# 55 ?
					\ expand('%:t') :
					\ (winwidth(0) ># 85 ? expand('%:.') : pathshorten(expand('%:.')))
	else
		let l:fn = '[No Name]'
	endif
	return
				\ l:fn .
				\ (&readonly ? ' ' : '') .
				\ (&modified ? ' +' : '')
endfunction
function! SLGitGutter() abort " {{{1
	if exists('g:gitgutter_enabled') && !empty(SLFugitive())
		let l:h = GitGutterGetHunkSummary()
		return printf("+%d ~%d -%d", l:h[0], l:h[1], l:h[2])
	else
		return ''
	endif
endfunction
function! SLFugitive() abort " {{{1
	return exists('*fugitive#head') && !empty(fugitive#head()) ?
				\ '  ' . fugitive#head() : ''
endfunction
function! SLRuby() abort " {{{1
	if has('gui_running')
		let l:r = exists('*rvm#statusline()') && !empty(rvm#statusline()) ?
					\ matchstr(rvm#statusline(), '\d.*[^\]]') : ''
	elseif executable('ruby')
		let l:r = matchstr(system('ruby -v')[5:], '[a-z0-9.]*\s')[:-2]
	else
		let l:r = ''
	endif
	return printf(' [ruby %s]', l:r)
endfunction
function! SLSyntastic() abort " {{{1
	return exists('*SyntasticStatuslineFlag()') && !empty(SyntasticStatuslineFlag()) ?
				\ SyntasticStatuslineFlag() : ''
endfunction
" 1}}}

" Helpers
function! s:ResetColors() abort " {{{1
	setl updatetime=4000
	call s:Hi('SL1', s:SL.colors['yellow'], s:SL.colors['background'], 'bold')
	execute 'hi CursorLineNR ' . s:defaultCursorLineNr
endfunction
function! <SID>VisualModesColors() abort " {{{1
	setl updatetime=1
	hi! link SL1 SL1V
	hi! link CursorLineNR SL1
endfunction
function! <SID>InsertReplaceModesColors(mode) abort " {{{1
	if a:mode ==# 'i'
		hi! link SL1 SL1I
	elseif a:mode ==# 'r'
		hi! link SL1 SL1R
	else
		hi! link SL1 SL1V
	endif
	hi! link CursorLineNR SL1
endfunction
function! <SID>SLToggleItem(func, var) abort " {{{1
	let l:item = printf("%%(%%{%s}\\ ⎟%%)", a:func)
	if exists('g:{a:var}')
		execute 'unlet! g:{a:var}'
		execute "set statusline-=" . l:item
	else
		execute 'let g:{a:var} = 1'
		execute "set statusline+=" . l:item
	endif
endfunction
function! <SID>SLInit() abort " {{{1
	let &statusline = ''
	set statusline+=%#SL1#\ %-{SLMode()}\ %(%{SLPaste()}\ %)			" Mode & paste
	set statusline+=%#SL2#%(\ %{SLGitGutter()}\ %{SLFugitive()}\ %)		" GitGutter & git branch
	set statusline+=%#SL3#\ %{SLFilename()}%(\ ⎢%{SLBuffersNr()}⎟%)		" Filename & number of buffers

	let &statusline .= '%='
	set statusline+=%#SL2#%(%{SLFiletype()}\ ⎟%)						" Filetype
	set statusline+=\ %p%%\ %l:%c\ ⎟									" Percentage & line:column
	set statusline+=%(\ %{SLFileencoding()}[%{SLFileformat()}]\ %)		" Encoding & format
	set statusline+=%(\ %#ErrorMsg#\ %{SLSyntastic()}\ %)	" Syntastic

	set statusline+=%(%#SL4#%)

	augroup SLColor
		autocmd!
		autocmd InsertEnter *  :call <SID>InsertReplaceModesColors(v:insertmode)
		autocmd InsertLeave *  :call s:ResetColors()
		autocmd CursorHold *   :call s:ResetColors()
	augroup END

	nnoremap <silent> v :call <SID>VisualModesColors()<CR>v
	nnoremap <silent> V :call <SID>VisualModesColors()<CR>V
	nnoremap <silent> <C-v> :call <SID>VisualModesColors()<CR><C-v>
endfunction
" 1}}}

" Mappings {{{1
nnoremap <silent> gsH  :call <SID>SLToggleItem("SLHiGroup()", "sl_hi")<CR>
nnoremap <silent> gsR  :call <SID>SLToggleItem("SLRuby()", "sl_ruby")<CR>
nnoremap <silent> gsP  :call <SID>SLToggleItem("SLPython()", "sl_python")<CR>

" 1}}}

call <SID>SLInit()

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
