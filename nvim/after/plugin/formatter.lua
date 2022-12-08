local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
end

local util = require "formatter.util"

require("formatter").setup {
    -- Enable or disable logging

    logging = false,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        --[[ antlers = { ]]
        --[[     function() ]]
        --[[         return { ]]
        --[[             exe = "antlersformat", ]]
        --[[             args = { ]]
        --[[                 "format", ]]
        --[[                 "--f=" .. util.escape_path(util.get_current_buffer_file_path()), ]]
        --[[                 "--o=" .. vim.env.HOME .. "/.config/nvim/formatters/antlers.json", ]]
        --[[             }, ]]
        --[[             stdin = false, ]]
        --[[         } ]]
        --[[     end, ]]
        --[[ }, ]]
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        php = {
            function()
                return {
                    exe = "php-cs-fixer",
                    args = {
                        "--config=" .. get_git_root() .. "/.php-cs-fixer.dist.php",
                        "--using-cache=no",
                        "--no-interaction",
                        "fix",
                    },
                    stdin = false,
                }
            end,
        },
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == "plugins.lua" then
                    -- formatting will break
                    return nil
                end
                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        vue = {
            function()
                return {
                    exe = "eslint_d",
                    args = {
                        "--stdin",
                        "--stdin-filename",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                        "--fix-to-stdout",
                    },
                    stdin = true,
                }
            end,
        },
        json = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote" },
                    stdin = true,
                }
            end,
        },
        javascript = {
            function()
                return {
                    exe = "eslint_d",
                    args = {
                        "--stdin",
                        "--stdin-filename",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                        "--fix-to-stdout",
                    },
                    stdin = true,
                }
            end,
        },
        typescript = {
            function()
                return {
                    exe = "eslint_d",
                    args = {
                        "--stdin",
                        "--stdin-filename",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                        "--fix-to-stdout",
                    },
                    stdin = true,
                }
            end,
        },
        -- php: use intelephense to perform formatting
        blade = {
            function()
                return {
                    exe = "blade-formatter",
                    args = {
                        "--stdin",
                        "--write",
                        "--sort-attributes=vuejs",
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    },
                    stdin = true,
                }
            end,
        },
        css = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote" },
                    stdin = true,
                }
            end,
        },
    },
}

local api = vim.api

local formatting = api.nvim_create_augroup("Formatting", { clear = true })

api.nvim_create_autocmd("BufWritePost ", {
    command = "FormatWrite",
    group = formatting,
})
