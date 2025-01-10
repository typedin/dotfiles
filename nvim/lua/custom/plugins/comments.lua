-- "gc" to comment visual regions/lines
-- it's built in to nvim since Neovim>=0.10
-- see :h comment
-- Highlight todo, notes, etc in comments
return {
    {
        "folke/todo-comments.nvim",
        lazy = true,
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                pattern = [[.*<(KEYWORDS)]], -- pattern or table of patterns, used for highlighting (vim regex)
            },
        },
    },
}
