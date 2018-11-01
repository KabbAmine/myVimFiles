" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-27
" ==============================================================


let s:tags_dir = $HOME . '/.cache/gentags/'
let s:job_name = ''
let s:autocmds = []

fun! ka#module#gentags#auto_enable() abort " {{{1
    augroup GenTagsAuto
        autocmd!
        autocmd VimEnter * call ka#module#gentags#enable_for_project()
        autocmd DirChanged global call ka#module#gentags#enable_for_project()
        autocmd VimLeave * call ka#module#gentags#delete_old_tagfiles()
    augroup END
endfun
" 1}}}

fun! ka#module#gentags#enable_for_project() abort " {{{1
    if s:in_project()
        call ka#module#gentags#enable_for_wd()
    endif
endfun
" 1}}}

fun! ka#module#gentags#enable_for_wd() abort " {{{1
    let tagfile = s:get_tagfile()
    " Generate tags a 1st time only if the tagfile does not exist
    if !filereadable(tagfile)
        call s:generate_tags_in(tagfile)
    endif
    call s:set_tags_opt(tagfile)
    let a_cmd = printf('autocmd BufWritePost %s/* call <SID>generate_tags_in("%s")',
                \   getcwd(),
                \   tagfile
                \ )
    if index(s:autocmds, a_cmd) is# -1
        call add(s:autocmds, a_cmd)
    endif
    augroup GenTagsEnabled
        autocmd!
        for ac in s:autocmds
            execute ac
        endfor
    augroup END
endfun
" 1}}}

fun! ka#module#gentags#delete_old_tagfiles() abort " {{{1
    for tf in glob(s:tags_dir . '*--tags', '', 1)
        let dir = substitute(matchstr(fnamemodify(tf, ':t'), '.*\ze--tags$'), '__', '/', 'g')
        if !isdirectory(dir)
            call delete(tf)
        endif
    endfor
endfun
" 1}}}


fun! s:in_project() abort " {{{1
    let cwd = getcwd()
    return isdirectory(cwd . '/.git')
                \ || filereadable(cwd . '/package.json')
                \ || filereadable(cwd . '/README.md')
                \ || filereadable(cwd . '/index.html')
endfun
" 1}}}

fun! s:get_tagfile() abort " {{{1
    if !isdirectory(s:tags_dir)
        call mkdir(s:tags_dir, 'p')
    endif
    let tagfile_name = s:tagfile_name_from_path(getcwd())
    return s:tags_dir . tagfile_name
endfun
" 1}}}

fun! s:set_tags_opt(tagfile) abort " {{{1
    " Remove *--tags files occurrences before adding the current one
    let def_tags = filter(copy(split(&tags, ',')), {i, v -> v !~ '--tags$'})
    let &tags = join(def_tags, ',') . ',' . a:tagfile
endfun
" 1}}}

fun! s:cmd_opts_for_files(path) abort " {{{1
    " Files can be:
    " - Result of `git ls-files` if we are in a git project
    " - Everything (`-R .`)

    if isdirectory(a:path . '/.git')
        let tmp_file = tempname()
        let files = split(system(printf('cd "%s" && git ls-files .', a:path)), "\n")
        call map(files, {i, v -> a:path . '/' . v})
        call writefile(files, tmp_file)
        let cmd = '-L "'. tmp_file . '"'
    else
        let cmd = '-R "' . a:path . '"'
    endif

    return cmd
endfun
" 1}}}

fun! s:generate_tags_in(tagfile) abort " {{{1
    let path = s:path_from_tagfile_path(a:tagfile)
    " In case we've changed our wd, but still editing a buffer within from
    " project
    if getcwd() isnot# path
        return v:null
    endif
    let ctags_cmd = printf('ctags --quiet=yes -f "%s" %s',
                \   fnamemodify(a:tagfile, ':p'),
                \   s:cmd_opts_for_files(path)
                \ )
    if !empty(s:job_name)
        silent call ka#job#stop(s:job_name, '!')
        call s:clean_and_update_sl()
    endif
    let s:job_name = ka#job#start(ctags_cmd, {
                \   'listwin': '',
                \ }, function('s:clean_and_update_sl')
                \ )
endfun
" 1}}}

fun! s:clean_and_update_sl() abort " {{{1
    let s:job_name = ''
    redrawstatus!
endfun
" 1}}}

fun! s:tagfile_name_from_path(path) abort " {{{1
    " /foo/bar -> __foo__bar--tags
    return substitute(a:path, '/', '__', 'g') . '--tags'
endfun
" 1}}}

fun! s:path_from_tagfile_path(tagfile) abort " {{{1
    " /foo/bar/__zee__dol--tags -> /zee/dol/
    let tagfile_name = fnamemodify(a:tagfile, ':t')
    return matchstr(substitute(tagfile_name, '__', '/', 'g'), '^.*\ze--tags')
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
