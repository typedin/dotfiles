return {
    -- WARNING
    -- don't lazy load this one or it will break the bindings
    -- WARNING
    {
        "mrjones2014/smart-splits.nvim",
        dependencies = "mrjones2014/legendary.nvim",
        opts = { ignored_buftypes = { "nofile" } },
        config = function()
            require("legendary").setup({
                extensions = {
                    -- default settings shown below:
                    smart_splits = {
                        directions = { "h", "j", "k", "l" },
                        mods = {
                            -- for moving cursor between windows
                            move = "<C>",
                            -- for resizing windows
                            resize = "<M>",
                            -- for swapping window buffers
                            swap = false, -- false disables creating a binding
                        },
                    },
                },
            })
        end,
    },
    -- {
    --     "letieu/wezterm-move.nvim",
    --     -- Lazy loading, don't need call setup() function
    --     keys = {
    --         {
    --             "<C-h>",
    --             function()
    --                 require("wezterm-move").move("h")
    --             end,
    --         },
    --         {
    --             "<C-j>",
    --             function()
    --                 require("wezterm-move").move("j")
    --             end,
    --         },
    --         {
    --             "<C-k>",
    --             function()
    --                 require("wezterm-move").move("k")
    --             end,
    --         },
    --         {
    --             "<C-l>",
    --             function()
    --                 require("wezterm-move").move("l")
    --             end,
    --         },
    --     },
    -- },
}
