local util = require('formatter.util')
local formatting = vim.api.nvim_create_augroup('Formatting', { clear = true })

local function get_git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

local prettier_func = function()
    return {
        exe = 'prettier',
        args = {
            '--stdin-filepath',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--double-quote',
        },
        stdin = true,
    }
end
local eslint_func = function()
    return {
        exe = 'eslint_d',
        args = {
            '--config',
            util.escape_path(util.get_current_buffer_file_path()),
            '--stdin',
            '--stdin-filename',
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--fix-to-stdout',
        },
        stdin = true,
    }
end
require('formatter').setup({
    -- Enable or disable logging
    logging = false,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        rust = {
            function()
                return {
                    exe = 'rustfmt',
                    stdin = true,
                }
            end,
        },
        sh = {
            function()
                return {
                    exe = 'shellcheck',
                    args = {
                        '--severity',
                        'warning',
                    },
                }
            end,
        },
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
                    exe = 'pint',
                    args = {
                        '--config',
                        get_git_root() .. 'pint.json',
                    },
                }
            end,
        },
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == 'plugins.lua' then
                    -- formatting will break
                    return nil
                end
                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = 'stylua',
                    args = {
                        '--search-parent-directories',
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--',
                        '-',
                    },
                    stdin = true,
                }
            end,
        },
        vue = {
            eslint_func,
            prettier_func,
        },
        json = {
            prettier_func,
        },
        css = {
            prettier_func,
        },
        javascript = {
            eslint_func,
            prettier_func,
        },
        typescriptreact = {
            eslint_func,
            prettier_func,
        },
        typescript = {
            eslint_func,
            prettier_func,
        },
        -- php: use intelephense to perform formatting
        blade = {
            function()
                return {
                    exe = 'blade-formatter',
                    args = {
                        '--stdin',
                        '--write',
                        '--sort-attributes=vuejs',
                        vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    },
                    stdin = true,
                }
            end,
        },
    },
})

vim.api.nvim_create_autocmd('BufWritePost ', {
    command = 'FormatWrite',
    group = formatting,
})
