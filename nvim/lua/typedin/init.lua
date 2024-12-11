require("typedin.config")
require("typedin.keymaps")

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

-- The line beneath this is called `modeline`. See `:help modeline`

-- vim: ts=2 sts=2 sw=2 et
