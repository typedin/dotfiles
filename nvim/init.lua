-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Quickly go to latest buffer
vim.keymap.set("n", "<LocalLeader><LocalLeader>", "<C-^>")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move lines up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move lines down

-- When test is wrapped, moved by terminal rows, not lines, unless a count is provided
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
--
vim.keymap.set("n", "J", "mzJ`z") -- keep cursor in place
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half page jumping down but keep cursor in place
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half page jumping up but keep cursor in place
vim.keymap.set("n", "n", "nzzzv") -- keep cursor in the middle when cycling down search
vim.keymap.set("n", "N", "Nzzzv") -- keep cursor in the middle when cycling down search

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

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

local options = {
    guicursor = "",
    emoji = false, -- don't assume all emoji are double width
    relativenumber = true,
    number = true,
    scrolloff = 8,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    smartindent = true,
    wrap = true,
    showbreak = "↳",
    swapfile = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true, -- persistent mode
    backup = false, -- automatically save a backup file
    dir = "/tmp/",
    confirm = true, -- ask for confirmation instead of erroring
    hlsearch = false,
    incsearch = true,
    termguicolors = true,
    signcolumn = "yes",
    updatetime = 50,
    splitbelow = false, -- open horizontal splits below current window,
    splitright = true, -- open vertical splits to the right of the current window
    spell = false,
    shortmess = vim.opt.shortmess + { c = true },
    title = true,
    wildmode = "longest:full,full", -- complete the longest common mathc, and allow tabbing the results to fully complete them
    completeopt = "menuone,longest,preview",
    cmdheight = 0,
    ignorecase = true, -- Search
    smartcase = true, -- if I type a search with capital letter the search becomes case sensitive
    list = true,
    listchars = {
        tab = "➣ ", -- U+27A3
        trail = "•",
        nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    },
}
for option, value in pairs(options) do
    vim.opt[option] = value
end
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

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
