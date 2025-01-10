local signs = require("custom.signs")
return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = true,
        cmd = "Neotree",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.HINT] = signs.hint,
                        [vim.diagnostic.severity.ERROR] = signs.error,
                        [vim.diagnostic.severity.WARN] = signs.warn,
                        [vim.diagnostic.severity.INFO] = signs.info,
                    },
                },
            })
        end,
        keys = {
            {
                "<leader>e",
                "<cmd>Neotree toggle left<cr>",
                desc = "Neotree",
            },
            {
                "<leader>b",
                ":Neotree source=buffers toggle position=float<cr>",
                desc = "Neotree opened buffers in a floating window",
            },
        },
        opts = {
            window = {
                mappings = {
                    ["<cr>"] = "open",
                },
                position = "left",
                filesystem = {
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_hidden = true, -- only works on Windows for hidden files/directories
                        hide_by_name = {
                            "node_modules",
                            "vendor",
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            "*.meta",
                            "*.cache",
                        },
                        never_show = { -- remains hidden even if visible is toggled to true
                            "*.un~",
                            "*.*.un~",
                        },
                    },
                    ".DS_Store",
                    "thumbs.db",
                },
            },
        },
    },
}
