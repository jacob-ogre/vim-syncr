# vim-syncr

A small plugin to sync local and remote files and directories from Vim.

## What?
vim-syncr currently includes just three functions:
* sync current file remote -> local = `:Sdownlf` 
* sync current file local -> remote = `:Suplfil` 
* sync current dir local -> remote = `:Supldir` 

that are mapped by default to:
* sync current file remote -> local (**s**ync **d**own **f**ile) `<leader>sdf` 
* sync current file local -> remote (**s**ync **u**p **f**ile) `<leader>suf` 
* sync current dir local -> remote (**s**ync **u**p **d**irectory) `<leader>sud` 

## Why?
Because coding is often more efficient when working from a local repository,
but changes often need to be pushed regularly to remote machines. Git
push/pull/fetch/etc. is fine, but takes additional steps.

## How?

