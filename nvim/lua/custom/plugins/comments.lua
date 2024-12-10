-- Highlight todo, notes, etc in comments
return {
    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
    {
        "folke/todo-comments.nvim",
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
