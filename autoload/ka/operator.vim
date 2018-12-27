" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-12-27
" ==============================================================


fun! ka#operator#sort(...) abort " {{{1
    execute printf('%d,%d:!sort', line("'["), line("']"))
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
