" %HERE%

" CREATION     : %DATE%
" MODIFICATION : %DATE%
" MAINTAINER   : %USER% <%MAIL%>
" LICENSE      : %LICENSE%

" Vim options {{{1
if exists('g:%FILE%_loaded')
    finish
endif
let g:%FILE%_loaded = 1

" To avoid conflict problems.
let s:saveCpoptions = &cpoptions
set cpoptions&vim
" 1}}}



" Restore default vim options {{{1
let &cpoptions = s:saveCpoptions
unlet s:saveCpoptions
" 1}}}

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
