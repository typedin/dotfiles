local signs = require("custom.signs")
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "f-person/git-blame.nvim",
        {
            "mvllow/modes.nvim",
            tag = "v0.2.1",
            config = function()
                require("modes").setup({
                    colors = {
                        copy = "#f5c359",
                        delete = "#c75c6a",
                        insert = "#78ccc5",
                        visual = "#9745be",
                    },
                    -- Set opacity for cursorline and number background
                    line_opacity = 0.15,
                    -- Enable cursor highlights
                    set_cursor = true,
                    -- Enable cursorline initially, and disable cursorline for inactive windows
                    -- or ignored filetypes
                    set_cursorline = true,
                    -- Enable line number highlights to match cursorline
                    set_number = true,

                    -- Disable modes highlights in specified filetypes
                    -- Please PR commonly ignored filetypes
                    ignore_filetypes = { "NvimTree", "TelescopePrompt" },
                })
            end,
        },
    },
    config = function()
        local git_blame = require("gitblame")
        ---@diagnostic disable: inject-field
        vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
        vim.g.gitblame_date_format = "%d-%m-%y (%H:%M)" -- Disable virtual text
        vim.g.gitblame_message_template = " <summary> • <date> • <author>" -- Disable virtual text

        require("lualine").setup({
            options = {
                icons_enabled = true,
                globalstatus = true,
                theme = "tokyonight",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = {
                    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                },
                lualine_y = { "filetype" },
                lualine_z = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        sections = { "error", "warn", "info", "hint" },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = "DiagnosticError", -- Changes diagnostics' error color.
                            warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
                            info = "DiagnosticInfo", -- Changes diagnostics' info color.
                            hint = "DiagnosticHint", -- Changes diagnostics' hint color.
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
            extensions = { "fugitive", "quickfix" },
        })
    end,
}
