vim.g.livedown_autorun = 0
local home = vim.env.HOME
local neovim_cache = home .. "/.cache/nvim"
local root = vim.env.USER == "root"

vim.o.termguicolors = true
vim.o.fileencoding = "utf-8" -- The encoding written to file

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.opt.shortmess = vim.opt.shortmess + "W" -- don't echo "[w]"/"[written]" when writing
vim.opt.shortmess = vim.opt.shortmess + "I" -- no splash screen
vim.opt.shortmess = vim.opt.shortmess + "A" -- ignore annoying swapfile messages
vim.opt.shortmess = vim.opt.shortmess + "O" -- file-read message overwrites previous
vim.opt.shortmess = vim.opt.shortmess + "T" -- truncate non-file messages in middle
vim.opt.shortmess = vim.opt.shortmess + "W" -- don't echo "[w]"/"[written]" when writing
vim.opt.shortmess = vim.opt.shortmess + "a" -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
vim.opt.shortmess = vim.opt.shortmess + "c" -- completion messages
vim.opt.shortmess = vim.opt.shortmess + "o" -- overwrite file-written messages
vim.opt.shortmess = vim.opt.shortmess + "t" -- truncate file messages at start
vim.opt.showbreak = "↳" -- DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)

vim.cmd [[
    syntax on
    set ma
    set autoread
    set nobackup
    set nowritebackup
    set noswapfile
    "use y and p with the system clipboard
    set clipboard=unnamedplus
]]

vim.g.highlightedyank_highlight_duration = 100
vim.g.gitblame_enabled = 0
vim.g.markdown_fenced_languages = { "html", "python", "ruby", "vim" }

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.hlsearch = true

vim.opt.mouse = "a" -- Enable your mouse
vim.opt.emoji = false -- don't assume all emoji are double width

vim.opt.scrolloff = 10 -- start scrolling 3 lines before edge of viewportvim.opt.modelines
vim.opt.pumblend = 10 -- pseudo-transparency for popup-menu

vim.opt.signcolumn = "yes:2" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.number = true
vim.opt.relativenumber = true -- show relative numbers in gutter

vim.opt.joinspaces = false -- don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.lazyredraw = true -- don't bother updating screen during macro playback
vim.opt.linebreak = false -- wrap long lines at characters in 'breakat'

-- tabs
vim.cmd "set ts=4" -- Insert 4 spaces for a tab
vim.cmd "set sw=4" -- Change the number of space characters inserted for indentation
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.smartindent = true -- Makes indenting smart

-- status line height
vim.opt.ls = 2
vim.g.ls = 2
-- hide command line
vim.opt.ch = 0
vim.g.ch = 0

vim.opt.backup = true
vim.opt.backupcopy = "yes"

-- whitespace
vim.g.indent_blankline_enabled = false
vim.opt.list = true -- show whitespace

vim.opt.listchars = {
    nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = "▷┅", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

vim.cmd "set tabline=0"
vim.cmd "set backspace=indent,start,eol"

vim.opt.shell = "sh" -- shell to use for `!`, `:!`, `system()` etc.
vim.opt.shiftround = false -- don't always indent by multiple of shiftwidth
vim.opt.shiftwidth = 4 -- spaces per tab (when shifting)
vim.opt.showcmd = false -- don't show extra info at end of command line
vim.opt.sidescroll = 3 -- sidescroll in jumps because terminals are slow
vim.opt.sidescrolloff = 1 -- same as scrolloff, but for columns
vim.opt.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.tabstop = 4 -- spaces per tab
vim.opt.softtabstop = 4 -- use 'shiftwidth' for tab/bs at end of line
vim.opt.spellcapcheck = "" -- don't check for capital letters at start of sentence
vim.opt.splitbelow = true -- open horizontal splits below current window
vim.opt.splitright = true -- open vertical splits to the right of the current window
vim.opt.suffixes = vim.opt.suffixes - ".h" -- don't sort header files at lower priority
vim.opt.switchbuf = "usetab" -- try to reuse windows/tabs when switching buffers
vim.opt.hidden = true

if root then
    vim.opt.shada = "" -- Don't create root-owned files.
    vim.opt.shadafile = "NONE" -- the actual parameter

    vim.opt.undofile = false -- don't create root-owned files
    vim.opt.undodir = false -- don't create undodir for root

    vim.opt.swapfile = false -- don't create swap files
else
    vim.opt.shada = "'0,<0,f0,n~/.cache/nvim/shada" -- there are no typos on this line

    vim.opt.undofile = true -- actually use undo files
    vim.opt.undodir = neovim_cache .. "/undofiles/" -- keep undo files out of the way

    vim.opt.swapfile = true -- create swap files

    vim.opt.directory = neovim_cache .. "/swapfiles/" -- keep undo files out of the way

    vim.opt.viewdir = neovim_cache .. "/view/" -- where to store files for :mkview

    vim.opt.backupdir = vim.fn.expand "~/.cache/nvim/backup//"
    vim.opt.backupdir = vim.opt.backupdir + "."

    vim.opt.updatecount = 80 -- update swapfiles every 80 typed chars
end

vim.opt.updatetime = 300 -- CursorHold interval / Reduce time for highlighting other references
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
vim.opt.viewoptions = "cursor,folds" -- save/restore just these (with `:{mk,load}view`)
vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
vim.opt.visualbell = true -- stop annoying beeping for non-error errors
vim.opt.whichwrap = "b,h,l,s,<,>,[,],~" -- allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
vim.opt.wildcharm = 26 -- ('<C-z>') substitute for 'wildchar' (<Tab>) in macros
vim.opt.wildignore = vim.opt.wildignore + "*.o,*.rej,*.so" -- patterns to ignore during file-navigation
vim.opt.wildmenu = true -- show options as list when switching buffers etc
vim.opt.wildmode = "longest:full,full" -- shell-like autocomplete to unambiguous portion
-- vim.opt.winblend = 10 -- psuedo-transparency for floating windows

if vim.fn.filereadable "/usr/bin/python" == 1 then
    -- Avoid search, speeding up start-up.
    vim.g.python3_host_prog = "/usr/bin/python"
end

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd [[
    " set signcolumn=yes
    " autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]]
