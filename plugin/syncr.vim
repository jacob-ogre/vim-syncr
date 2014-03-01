" Title: syncr
" Description: Sync files local -> remote and vice-versa with rsync
" Usage: :Supload :Sdownload :Supdir
"                By default mapped to
"                <leader>hsd (hsftp download) and
"                <leader>hsu (hsftp upload)
"                See README for more
" Github: https://github.com/jacob-ogre/vim-syncr
" Author: Jacob Malcom
" License: GPL2
"
" Much credit to Viktor Hesselbom for vim-hsftp, which was a starting point
" for this plugin. Ideas further influenced by Will Bond, creator of the SFTP
" package for Sublime Text 2/3.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Read the configuration file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! h:GetConfig()
    let conf = {}

    let l:configpath = expand('%:p:h')
    let l:configfile = l:configpath . '/.syncrconf'
    let l:foundconfig = ''
    if filereadable(l:configfile)
        let l:foundconfig = l:configfile
    else
        while !filereadable(l:configfile)
            let slashindex = strridx(l:configpath, '/')
            if slashindex >= 0
                let l:configpath = l:configpath[0:slashindex]
                let l:configfile = l:configpath . '.syncrconf'
                let l:configpath = l:configpath[0:slashindex-1]
                if filereadable(l:configfile)
                    let l:foundconfig = l:configfile
                    break
                endif
                if slashindex == 0 && !filereadable(l:configfile)
                    break
                endif
            else
                break
            endif
        endwhile
    endif

    if strlen(l:foundconfig) > 0
        let options = readfile(l:foundconfig)
        for i in options
            let vname = substitute(i[0:stridx(i, ' ')], 
                        \'^\s*\(.\{-}\)\s*$', '\1', '')
            let vvalue = substitute(i[stridx(i, ' '):], 
                        \'^\s*\(.\{-}\)\s*$', '\1', '')
            let conf[vname] = vvalue
        endfor

        let conf['local'] = fnamemodify(l:foundconfig, ':h:p') . '/'
        let conf['localpath'] = expand('%:p')
        let conf['remotepath'] = conf['remote'] . 
                    \conf['localpath'][strlen(conf['local']):]
    endif
    return conf
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sync current file from local to remote.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! h:SyncUpFile()
    let conf = h:GetConfig()

    if has_key(conf, 'host')
        let cmd = printf('$HOME/.vim/bundle/vim-syncr/sync_loc_rem_file 
                    \%s %s %s %s', 
                    \conf['localpath'], 
                    \conf['remotepath'],
                    \conf['user'],
                    \conf['host'])

        execute '!' . cmd
    else
        echo "Could not find .syncrconf config file, which should be at the"
        echo "root of the current file's repository."
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sync current directory to remote.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! h:SyncUpDir()
    let conf = h:GetConfig()

    if has_key(conf, 'host')
        let loc_dir_brk = split(conf['localpath'], '/')
        let loc_dir = '/' . join(l:loc_dir_brk[0:len(l:loc_dir_brk)-2], '/') . '/'
        let rem_dir_brk = split(conf['remotepath'], '/')
        let rem_dir = '/' . join(l:rem_dir_brk[0:len(l:rem_dir_brk)-2], '/') . '/'
        let cmd = printf('$HOME/.vim/bundle/vim-syncr/sync_loc_rem_dir
                    \ %s %s %s %s', 
                    \l:loc_dir, 
                    \l:rem_dir,
                    \conf['user'],
                    \conf['host'])
        execute '!' . cmd
    else
        echo 'Could not find .syncrconf config file'
    endif

endfunction

command! Sdownlf call h:SyncDownFile()
command! Suplfil call h:SyncUpFile()
command! Supldir call h:SyncUpDir()

nmap <leader>sdf :Sdownlf<Esc>
nmap <leader>suf :Suplfil<Esc>
nmap <leader>sud :Supldir<Esc>
