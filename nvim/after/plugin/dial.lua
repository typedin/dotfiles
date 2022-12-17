local map = require('dial.map')

vim.keymap.set('n', '<C-a>', map.inc_normal())
vim.keymap.set('n', '<C-x>', map.dec_normal())
vim.keymap.set('v', '<C-a>', map.inc_visual())
vim.keymap.set('v', '<C-x>', map.dec_visual())
vim.keymap.set('v', 'g<C-a>', map.inc_gvisual())
vim.keymap.set('v', 'g<C-x>', map.dec_gvisual())
