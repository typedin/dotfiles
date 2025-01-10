return {
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        lazy = true,
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })
        end,
        keys = {
            { "<localleader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "[G]it [P]review hunk" },
            { "<localleader>gt", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "[G]it [T]oggle current line blame" },
        },
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "akinsho/git-conflict.nvim",
        opts = {},
    },
}
