local set = vim.keymap.set

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

---@diagnostic disable-next-line: inject-field
vim.g.mapleader = " "
---@diagnostic disable-next-line: inject-field
vim.g.maplocalleader = ","

-- Set to true if you have a Nerd Font installed
---@diagnostic disable-next-line: inject-field
vim.g.have_nerd_font = true

local shortmessage_options = {
    "W", -- don't echo "[w]"/"[written]" when writing
    "I", -- no splash screen
    "A", -- ignore annoying swapfile messages
    "O", -- file-read message overwrites previous
    "T", -- truncate non-file messages in middle
    "W", -- don't echo "[w]"/"[written]" when writing
    "a", -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
    "c", -- completion messages
    "o", -- overwrite file-written messages
    "t", -- truncate file messages at start
}

for _, value in pairs(shortmessage_options) do
    vim.opt.shortmess:append(value)
end

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
local options = {
    backup = false, -- automatically save a backup file
    breakindent = true, -- Enable break indent
    clipboard = "unnamedplus",
    cursorline = true,
    cmdheight = 0,
    completeopt = "menuone,longest,preview",
    confirm = true, -- ask for confirmation instead of erroring
    dir = "/tmp/",
    emoji = false, -- don't assume all emoji are double width
    expandtab = true,
    guicursor = "",
    hlsearch = true, -- Set highlight on search, but clear on pressing <Esc> in normal mode
    inccommand = "split", -- Preview substitutions live, as you type!
    incsearch = true,
    list = true, -- Sets how neovim will display certain whitespace in the editor.
    listchars = {
        tab = "➣ ", -- U+27A3
        trail = "•",
        nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    },
    mouse = "a",
    number = true,
    relativenumber = true,
    scrolloff = 8, -- Minimal number of screen lines to keep above and below the cursor.
    shiftwidth = 4,
    shortmess = vim.opt.shortmess + { c = true },
    showmode = false, -- Don't show the mode, since it's already in status line
    showbreak = "↳",
    signcolumn = "yes",
    smartindent = true,
    softtabstop = 4,
    spell = false,
    splitbelow = false, -- open horizontal splits below current window,
    splitright = true, -- open vertical splits to the right of the current window
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 300,
    title = true,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true, -- persistent mode
    updatetime = 50,
    wildmode = "longest:full,full", -- complete the longest common mathc, and allow tabbing the results to fully complete them
    wrap = true,
}
for option, value in pairs(options) do
    vim.opt[option] = value
end

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
set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

require("typedin")
-- The line beneath this is called `modeline`. See `:help modeline`

-- vim: ts=2 sts=2 sw=2 et
