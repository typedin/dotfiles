vim.opt.guicursor = ''

vim.opt.emoji = false -- don't assume all emoji are double width
vim.opt.nu = true -- WTF ????
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.showbreak = '↳'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true -- persistent mode
vim.opt.backup = true -- automatically save a backup file
vim.opt.backupdir:remove('.') -- keep backups out of the current directory
vim.opt.confirm = true -- ask for confirmation instead of erroring

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.g.highlightedyank_highlight_duration = 100

vim.opt.updatetime = 50

vim.opt.splitbelow = false -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window

vim.opt.spell = true
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.title = true
vim.opt.wildmode = 'longest:full,full' -- complete the longest common mathc, and allow tabbing the results to fully complete them
vim.opt.cmdheight = 0

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true -- if I type a search with capital letter the search becomes case sensitive

vim.opt.list = true
vim.opt.listchars = {
    tab = '➣ ', -- U+27A3
    trail = '•',
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
}

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
