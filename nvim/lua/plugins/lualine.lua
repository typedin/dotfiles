local signs = require('typedin.signs')
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'f-person/git-blame.nvim',
    },
    config = function()
        local git_blame = require('gitblame')
        vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
        require('lualine').setup({
            options = {
                icons_enabled = true,
                globalstatus = true,
                theme = 'tokyonight',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = {
                    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                },
                lualine_y = { 'filetype' },
                lualine_z = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = 'DiagnosticError', -- Changes diagnostics' error color.
                            warn = 'DiagnosticWarn', -- Changes diagnostics' warn color.
                            info = 'DiagnosticInfo', -- Changes diagnostics' info color.
                            hint = 'DiagnosticHint', -- Changes diagnostics' hint color.
                        },
                        symbols = {
                            error = signs.error,
                            hint = signs.hint,
                            info = signs.info,
                            warn = signs.warn,
                        },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                    },
                },
            },
            extensions = { 'fugitive', 'quickfix' },
        })
    end,
}
