# vim-syncr

A small plugin to sync local and remote files and directories from Vim.

## What?
vim-syncr currently includes just three functions:
* sync current file local -> remote = `:Suplfil` 
* sync current dir local -> remote = `:Supldir` 
* sync current file remote -> local = `:Sdownlf` 

that are mapped by default to:
* (**s**ync **u**p **f**ile) -> `<leader>sf` 
* (**s**ync **u**p **d**irectory) -> `<leader>sd` 
* (**s**ync **d**own **f**ile) -> `<leader>sdf` 

## Why?
Because coding is often more efficient when working from a local repository,
but changes often need to be pushed regularly to remote machines. Git
commit/push/pull/fetch/etc. is fine, but takes additional steps.

## How?
As one might guess, vim-syncr uses `rsync` to perform synchronization between a
local repository and a remote copy. The remote machine information is contained
in a configuration file saved at the root of the "project" directory; see
.syncrconf for illustration. The current bash functions that drive the sync
operations are hard-coded to exclude certain files (see TODO, below). Note that
this uses the -c flag of rsync to checksum the files rather than just comparing
time stamps.

## Setup
### Basic operation
1. Set up SSH login on the remote machine, if possible; otherwise, you will have
   to enter your password for each sync.
2. Use [Vundle] (https://github.com/gmarik/Vundle.vim) to clone vim-syncr into
   ~/.vim/bundle, or whereever you have your plugins set up.
3. Copy the .syncrconf from ~/.vim/bundle/vim-syncr/ to the root directory of 
   your active repository(ies).
4. Edit the .syncrconf as necessary to make the connections work.
5. If you work with the same repo on multiple remote machines, make additional
   copies of .syncrconf but named as, e.g., '_server2' and edit the settings
   as needed. The serv_switch script (see below) permits easy switching 
   between remote machines from within vim, and will rename the files given
   the "name" entry in .syncrconf.
6. (optional) Add `autocmd BufWritePost * :Suplfil` to your .vimrc to enable 
   automatic upload to the remote server on each :write. Also works with :Gw if
   using [Fugitive] (https://github.com/tpope/vim-fugitive).

### Remote switching
1. Copy `serv_switch` from ~/.vim/bundle/vim-syncr to the root of your working 
   repository, which will enable simple switching between remote machines.
2. (optional) add `map <Leader>sw :!/path/to/work/repo/serv_switch<cr>` to your 
   .vimrc to make remote server switching easy.

## Usage
### Basic operations
1. Open and edit a file in your working repository, then :w, and last `<leader>sf`.
2. Alternately, alter multiple files in a directory, :w, and `<leader>sd` to
   sync the entire directory (i.e., the parts that have changed).
3. An entire repository can be synced by opening a file at the working 
   repository root (e.g., .syncrconf), then using `<leader>sd` to perform a 
   recursive sync.

### Remote switching
1. If you added <Leader>sw to your .vimrc, then `,sw` will spawn a dialog 
   providing the "name" field of all .syncrconf* files in the repo root.
2. Choose the number of the remote machine you want to which you want to sync
   and the change will be made.

## Other options?
`sftp` can also do the job, particularly for single files, and you might check out
[vim-sftp] (https://github.com/hesselbom/vim-hsftp) - from which the config
parsing in vim-syncr was derived! - to see if it better fits your needs. However,
when working in a large repository where only a small number of files (and/or a
small portion of a few files) might change, syncing tends to be faster. There's
also a little more control (and highlighting!) using vim-syncr...but more could
be done to make it even more flexible.

One option to consider is making `:Suplfil` an autocmd so that for every :write
(BufWrite or similar event) the file is pushed to the remote machine.

## TODO (in general order of importance)
* Add rsync --exclude items to config file for more flexibility than the
  hard-coded excludes currently in-place.
* Other things, I'm sure...
