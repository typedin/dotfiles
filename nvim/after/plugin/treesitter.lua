require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "help", "javascript", "typescript", "css", "php", "vue", "bash", "diff",
        "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "json", "markdown", "phpdoc", "tsx" },
    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}
