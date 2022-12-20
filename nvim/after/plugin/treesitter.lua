require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'c',
        'lua',
        'rust',
        'help',
        'javascript',
        'typescript',
        'css',
        'php',
        'vue',
        'bash',
        'diff',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'html',
        'json',
        'markdown',
        'phpdoc',
        'tsx',
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = true,
    --@see https://www.youtube.com/watch?v=stqUbv-5u2s @12:53
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
        },
    },
})
