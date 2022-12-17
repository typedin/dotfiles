local configs = pcall(require, "nvim-treesitter.configs")

local config = function()
    configs.setup {
        -- ensure_installed = "maintained",
        ensure_installed = { "lua", "rust", "toml", "php", "phpdoc", "typescript", "vue", "bash", "css" },
        auto_install = true,
        sync_install = true,
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
            disable = { "yaml" },
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
        matchup = {
            enable = true,
            disable = { "c", "ruby" },
        },
    }
end

return config
