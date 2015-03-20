" Provides extra :Tabularize commands
" Last modification: 2015-03-20

if !exists(':Tabularize')
	finish
endif

let s:save_cpo = &cpo
set cpo&vim

" =========== Additional (( tabular )) pattern(s) =======================
AddTabularPattern! ftComma /^[^,]*\zs,/l1r1

let &cpo = s:save_cpo
unlet s:save_cpo
