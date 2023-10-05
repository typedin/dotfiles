return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        debounce = 100,
        whitespace = {
            highlight = { 'Function', 'Label', 'Whitespace', 'NonText' },
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            show_start = true,
            show_end = false,
            injected_languages = false,
            highlight = { 'Function', 'Label' },
            priority = 500,
        },
    },
}
