local set = vim.keymap.set
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- Quickly go to latest buffer
set("n", "<LocalLeader><LocalLeader>", "<C-^>")

set("v", "K", ":m '<-2<CR>gv=gv") -- move lines up
set("v", "J", ":m '>+1<CR>gv=gv") -- move lines down

-- When test is wrapped, moved by terminal rows, not lines, unless a count is provided
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

set("n", "J", "mzJ`z") -- keep cursor in place
set("n", "<C-d>", "<C-d>zz") -- half page jumping down but keep cursor in place
set("n", "<C-u>", "<C-u>zz") -- half page jumping up but keep cursor in place
set("n", "n", "nzzzv") -- keep cursor in the middle when cycling down search
set("n", "N", "Nzzzv") -- keep cursor in the middle when cycling down search

set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to [P]revious [D]iagnostic message" })

set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to [N]ext [D]iagnostic message" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
