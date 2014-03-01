# vim-syncr

A small plugin to sync local and remote files and directories from Vim.

## What?
vim-syncr currently includes just three functions:
* sync current file remote -> local = `:Sdownlf` 
* sync current file local -> remote = `:Suplfil` 
* sync current dir local -> remote = `:Supldir` 

that are mapped by default to:
* (**s**ync **d**own **f**ile) -> `<leader>sdf` 
* (**s**ync **u**p **f**ile) -> `<leader>suf` 
* (**s**ync **u**p **d**irectory) -> `<leader>sud` 

## Why?
Because coding is often more efficient when working from a local repository,
but changes often need to be pushed regularly to remote machines. Git
push/pull/fetch/etc. is fine, but takes additional steps.

## How?
As one might guess, vim-syncr uses `rsync` to perform synchronization between a
local repository and a remote copy. The remote machine information is contained
in a configuration file saved at the root of the "project" directory; see
.syncrconf for illustration. The current bash functions that drive the sync
operations are hard-coded to exclude certain files (see TODO, below).

## Other options?
`sftp` can also do the job, particularly for single files, and you might check out
[vim-sftp] (https://github.com/hesselbom/vim-hsftp) - from which the config
parsing in vim-syncr was derived! - to see if it better fits your needs. However,
when working in a large repository where only a small number of files (and/or a
small portion of a few files) might change, syncing tends to be faster. There's
also a little more control (and highlighting!) using vim-syncr...but more could
be done to make it even more flexible.

One option to consider is making `:Suplfil` an autocmd so that for every :write
(BufWrite or similar event) the file is pushed to the remote machin

## TODO (in general order of importance)
* Make switching between remote targets feasible and smooth.
* Add rsync --exclude items to config file for more flexibility than the
  hard-coded excludes currently in-place.
* Other things, I'm sure...
