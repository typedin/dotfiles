local set = vim.api.nvim_set_keymap
return {
    {
        "github/copilot.vim",
        config = function()
            set("i", "<C-n>", "copilot#Next()", { expr = true, silent = true, noremap = false })
            set("i", "<C-p>", "copilot#Previous()", { expr = true, silent = true, noremap = false })
            set("i", "<C-y>", "copilot#Accept()", { expr = true, silent = true, noremap = false })
            set("i", "<C-e>", "copilot#Cancel()", { expr = true, silent = true, noremap = false })
        end,
    },
}
