" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-01-20
" ==============================================================


function! ka#module#gentags#Auto() abort " {{{1
    if getcwd() is# expand($HOME)
        call ka#ui#E('Log', ['Hell no, I will not generate tags for ~!', 1])
        return ''
    endif
    if !exists('s:autogen_tags')
        let s:autogen_tags = 1
        call <SID>GenerateTags()
        augroup AutogenTags
            autocmd!
            execute 'autocmd BufWritePost ' . getcwd() . '/* :call <SID>GenerateTags()'
        augroup END
        call ka#ui#E('Log', ['Autogen tags enabled'])
    else
        augroup AutogenTags
            autocmd!
        augroup END
        augroup! AutogenTags
        unlet! s:autogen_tags
        call ka#ui#E('Log', ['Autogen tags disabled'])
    endif
endfunction
" 1}}}

function! s:CmdOptionsForFiles(path) abort " {{{1
    " Files can be:
    " - Listed in .tagfiles
    " - Result of `git ls-files` if we are in a git project
    " - Everything (`-R .`)

    if filereadable(a:path . '.tagfiles')
        let cmd = '-L "'. a:path . '.tagfiles' . '"'
    elseif isdirectory('./.git')
        let tmp_file = tempname()
        let files = split(system('git ls-files .'), "\n")
        call writefile(files, tmp_file)
        let cmd = '-L "'. tmp_file . '"'
    else
        let cmd = '-R ' . a:path
    endif
    return cmd
endfunction
" 1}}}

function! s:GenerateTags() abort " {{{1
    let cwd = getcwd() . '/'
    let ctags_cmd = 'ctags -f ./.tags ' . s:CmdOptionsForFiles(cwd)
    call ka#job#E('Create', [ctags_cmd])
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
