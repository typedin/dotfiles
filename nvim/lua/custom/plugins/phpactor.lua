-- PHP Refactoring Tools
return {
    "phpactor/phpactor",
    build = "composer install --no-dev --optimize-autoloader",
    ft = "php",
    keys = {
        { "<LocalLeader>pm", ":PhpactorContextMenu<CR>" },
        { "<LocalLeader>pn", ":PhpactorClassNew<CR>" },
    },
    --[[
      to disable formatting warning and/or missing documentation
      issue those commands at the root of the php project
      phpactor config:set language_server_php_cs_fixer.enabled true
      phpactor config:set php_code_sniffer.enabled false
     ----------------------OR-------------------------- 
     edit this file in ~/.config/phpactor/phpactor.yml
     this will create automatically a .phpactor.json file at the root 
     of a project
  --]]
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        require("lspconfig").intelephense.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = true
                client.server_capabilities.documentRangeFormattingProvider = true
                client.server_capabilities.hoverProvider = true
                client.server_capabilities.codeActionProvider = true
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.buf.inlay_hint(bufnr, true)
                end
            end,
            commands = {
                IntelephenseIndex = {
                    function()
                        vim.lsp.buf.execute_command({ command = "intelephense.index.workspace" })
                    end,
                },
            },
            handlers = {
                ["textDocument/publishDiagnostics"] = function()
                    return true
                end,
                ["textDocument/documentHighlight"] = function()
                    return true
                end,
            },
        })
    end,
}
