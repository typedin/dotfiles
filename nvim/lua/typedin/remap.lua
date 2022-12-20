vim.g.mapleader = ' ' -- leader should act for anything that interacts with outside
vim.g.maplocalleader = ',' -- LocalLeader should act for anything buffer related

-- split
-- navigation
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

vim.keymap.set('n', '<LocalLeader><LocalLeader>', '<C-^>')

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- move lines up
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move lines down

-- When test is wrapped, moved by terminal rows, not lines, unless a count is provided
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'q:', ':q') -- disable command line when I make a typo
vim.keymap.set('i', ';;', '<Esc>A;') -- add a , (coma) at the end of the line
vim.keymap.set('i', ',,', '<Esc>A,') -- add a ; (semicolumn) at the end of the line

vim.keymap.set('n', '<localleader>k', ':nohlsearch<CR>') -- Quickly clear search highlighting

vim.keymap.set('n', 'J', 'mzJ`z') -- keep cursor in place
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- half page jumping down but keep cursor in place
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- half page jumping up but keep cursor in place
vim.keymap.set('n', 'n', 'nzzzv') -- keep cursor in the middle when cycling down search
vim.keymap.set('n', 'N', 'Nzzzv') -- keep cursor in the middle when cycling down search

-- greatest remap ever
vim.keymap.set('x', '<localleader>p', [["_dP]]) -- paste without yanking

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]]) -- copy into system clip board
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
vim.keymap.set('n', '<localleader>f', vim.lsp.buf.format)

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- replace the word I was on
