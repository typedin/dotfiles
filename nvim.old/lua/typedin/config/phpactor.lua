local config = function()
    require("phpactor").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        install = {
            path = vim.fn.stdpath "data" .. "/opt/",
            branch = "master",
            -- this is : ~/.local/share/nvim/opt/phpactor
            bin = vim.fn.stdpath "data" .. "/opt/phpactor/bin/phpactor",
            php_bin = "php",
            composer_bin = "composer",
            git_bin = "git",
            check_on_startup = "none",
        },
        lspconfig = {
            enabled = true,
            options = {
                language_server_phpstan_enabled = true,
            },
        },
    }
end

return config
