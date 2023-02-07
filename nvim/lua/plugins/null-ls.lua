return {
    'jose-elias-alvarez/null-ls.nvim',

    dependencies = {
        'jayp0521/mason-null-ls.nvim',
        'ThePrimeagen/refactoring.nvim',
    },
    config = function()
        require('null-ls').setup({
            sources = {
                require('null-ls').builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ '.eslintrc.js' })
                    end,
                }),
                require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
                require('null-ls').builtins.formatting.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ '.eslintrc.js' })
                    end,
                }),
                require('null-ls').builtins.diagnostics.luacheck,
                require('null-ls').builtins.formatting.prettierd,
                require('null-ls').builtins.code_actions.refactoring,
            },
        })

        require('mason-null-ls').setup({ automatic_installation = true })
    end,
}
