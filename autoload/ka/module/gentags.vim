" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-03-29
" ==============================================================


function! ka#module#gentags#Auto() abort " {{{1
    let cwd = getcwd()
    if !filereadable('./.tags')
        echohl Question
        let res = input('Auto generate tags for "' . cwd . '"? [Y/n] ')
        echohl None
        if !empty(res) && res !~ '^y$'
            redraw!
            return ''
        endif
    endif
    if !exists('s:autogen_tags')
        let s:autogen_tags = 1
        call <SID>GenerateTags()
        augroup AutogenTags
            autocmd!
            execute 'autocmd BufWritePost ' . cwd . '/* :call <SID>GenerateTags()'
        augroup END
        call ka#ui#E('Log', ['GenTags enabled'])
    else
        augroup AutogenTags
            autocmd!
        augroup END
        augroup! AutogenTags
        unlet! s:autogen_tags
        call ka#ui#E('Log', ['GenTags disabled'])
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
    call ka#job#start(ctags_cmd, {})
endfunction
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
