local toggler = require "nvim-toggler"

toggler.setup {
    remove_default_keybinds = true,
}

-- it's where the ~ is but with a different trigger key
vim.keymap.set({ "n", "v" }, "<LocalLeader>é", toggler.toggle)
