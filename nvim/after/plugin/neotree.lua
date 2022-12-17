-- neotree
vim.api.nvim_set_keymap("", "<Leader>e", ":Neotree toggle left<cr>", { noremap = true, silent = true })
require("neo-tree").setup {
    window = {
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
                    ".DS_Store",
                    "thumbs.db",
                },
            },
        },
    },
}
