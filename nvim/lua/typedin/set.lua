vim.opt.guicursor = ''

vim.opt.emoji = false -- don't assume all emoji are double width
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.showbreak = '↳'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.g.highlightedyank_highlight_duration = 100

vim.opt.updatetime = 50

vim.opt.splitbelow = false -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window

vim.opt.shortmess = vim.opt.shortmess + { c = true }

vim.opt.cmdheight = 0

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

for key, value in pairs(shortmessage_options) do
    vim.opt.shortmess:append(value)
end
