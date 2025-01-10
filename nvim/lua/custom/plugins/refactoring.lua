return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    config = function()
        require("refactoring").setup()
        -- load refactoring Telescope extension
        require("telescope").load_extension("refactoring")
    end,
    keys = {
        {
            "<leader>rr",
            function()
                require("telescope").extensions.refactoring.refactors()
            end,
            desc = "[R]efacto[R]",
        },
    },
}
