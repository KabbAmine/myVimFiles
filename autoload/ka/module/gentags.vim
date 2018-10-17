" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-10-17
" ==============================================================


let s:tags_dir = $HOME . '/.cache/gentags/'

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
    call s:generate_tags(tagfile)
    call s:set_tags_opt(tagfile)
    if !exists('#GenTagsEnabled')
        augroup GenTagsEnabled
            autocmd!
            execute printf('autocmd BufWritePost %s/* call ka#module#gentags#enable_for_wd()', getcwd())
        augroup END
    endif
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
    let in_project = isdirectory(cwd . '/.git')
                \ || filereadable(cwd . '/package.json')
                \ || filereadable(cwd . '/README.md')
                \ || filereadable(cwd . '/index.html')
    return in_project ? v:true : v:false
endfun
" 1}}}

fun! s:get_tagfile() abort " {{{1
   if !isdirectory(s:tags_dir)
       call mkdir(s:tags_dir, 'p')
   endif
   let tagfile_name = substitute(getcwd(), '/', '__', 'g')
   return s:tags_dir . tagfile_name . '--tags'
endfun
" 1}}}

fun! s:cmd_opts_for_files() abort " {{{1
    " Files can be:
    " - Listed in .tagfiles
    " - Everything (`-R .`)

    let cwd = getcwd() . '/'
    let cmd = filereadable(cwd . '.tagfiles')
                \ ? '-L "'. cwd . '.tagfiles' . '"'
                \ : '-R ' . cwd
    return cmd
endfun
" 1}}}

fun! s:set_tags_opt(tagfile) abort " {{{1
    if &tags !~# '\V' . a:tagfile
        let &tags .= ',' . a:tagfile
    endif
endfun
" 1}}}

fun! s:generate_tags(tagfile) abort " {{{1
    let ctags_cmd = printf('ctags --quiet=yes -f "%s" %s',
                \   fnamemodify(a:tagfile, ':p'),
                \   s:cmd_opts_for_files()
                \ )
    if exists('g:gentags_job_name')
        silent call ka#job#stop(g:gentags_job_name, '!')
        call s:clean_and_update_sl()
    endif
    let g:gentags_job_name = ka#job#start(ctags_cmd, {}, function('s:clean_and_update_sl'))
endfun
" 1}}}

fun! s:clean_and_update_sl() abort " {{{1
    unlet! g:gentags_job_name
    redrawstatus!
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
