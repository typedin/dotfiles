-- lsp diagnostics icons
vim.g.signs = require('typedin.signs')
vim.g.highlightedyank_highlight_duration = 100

local shortmessage_options = {
    'W', -- don't echo "[w]"/"[written]" when writing
    'I', -- no splash screen
    'A', -- ignore annoying swapfile messages
    'O', -- file-read message overwrites previous
    'T', -- truncate non-file messages in middle
    'W', -- don't echo "[w]"/"[written]" when writing
    'a', -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
    'c', -- completion messages
    'o', -- overwrite file-written messages
    't', -- truncate file messages at start
}

for _, value in pairs(shortmessage_options) do
    vim.opt.shortmess:append(value)
end

local options = {
    guicursor = '',
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
    showbreak = '↳',
    swapfile = false,
    undodir = os.getenv('HOME') .. '/.vim/undodir',
    undofile = true, -- persistent mode
    backup = true, -- automatically save a backup file
    confirm = true, -- ask for confirmation instead of erroring
    hlsearch = false,
    incsearch = true,
    termguicolors = true,
    signcolumn = 'yes',
    updatetime = 50,
    splitbelow = false, -- open horizontal splits below current window,
    splitright = true, -- open vertical splits to the right of the current window
    spell = false,
    shortmess = vim.opt.shortmess + { c = true },
    title = true,
    wildmode = 'longest:full,full', -- complete the longest common mathc, and allow tabbing the results to fully complete them
    completeopt = 'menuone,longest,preview',
    cmdheight = 0,
    ignorecase = true, -- Search
    smartcase = true, -- if I type a search with capital letter the search becomes case sensitive
    list = true,
    listchars = {
        tab = '➣ ', -- U+27A3
        trail = '•',
        nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    },
}
for option, value in pairs(options) do
    vim.opt[option] = value
end
