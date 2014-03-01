# vim-syncr

A small plugin to sync local and remote files and directories from Vim.

## What?
vim-syncr currently includes just three functions:
    `:Sdownlf` = sync current file remote -> local
    `:Suplfil` = sync current file local -> remote
    `:Supldir` = sync current dir local -> remote
that are mapped by default to:
    `<leader>sdf` = sync current file remote -> local (*s*ync *d*own *f*ile)
    `<leader>suf` = sync current file local -> remote (*s*ync *u*p *f*ile)
    `<leader>sud` = sync current dir local -> remote (*s*ync *u*p *d*irectory)

## Why?
Because coding is often more efficient when working from a local repository,
but changes often need to be pushed regularly to remote machines. Git
push/pull/fetch/etc. is fine, but takes additional steps.

## How?

