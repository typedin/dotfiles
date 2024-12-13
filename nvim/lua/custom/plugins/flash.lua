return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<LocalLeader>hw",
            mode = { "n", "x", "o" },
            function()
                require("flash").jump({
                    search = {
                        mode = function(str)
                            return "\\<" .. str
                        end,
                    },
                })
            end,
            desc = "Flash beginning of a word",
        },
        {
            "<LocalLeader>ht",
            mode = { "n", "o", "x" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash (perform motions in remote locations)",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
    },
}
