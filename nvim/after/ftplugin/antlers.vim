autocmd BufNewFile,BufRead *.antlers.html set filetype=antlers

augroup MyBladeCommands
    " au! BufWritePre <buffer>
    " autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
    autocmd!
    autocmd BufWritePre *.antlers.html silent! Neoformat
augroup END
