augroup MyBladeCommands
    " au! BufWritePre <buffer>
    " autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
    autocmd!
    autocmd BufWritePre *.blade.php silent! Neoformat
augroup END

setlocal shiftwidth=4
