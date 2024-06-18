return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end,
        build = function()
            pcall(vim.cmd, 'MasonUpdate')
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim', -- Required
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    -- Replace these with whatever servers you want to install
                    'antlersls',
                    'intelephense',
                    'lua_ls',
                    'phpactor',
                    'rust_analyzer',
                    'tsserver',
                    'eslint_d'
                },
                automatic_installation = true,
            })
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        on_attach = require('lsp-format').on_attach,
                        capabilities = lsp_capabilities,
                    })
                end,
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
        end
    },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp', -- Required
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
            }
        },
    },
}
