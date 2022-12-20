require('hop').setup()

vim.keymap.set('n', '<LocalLeader>hl', ':HopLineStart<cr>', {})
vim.keymap.set('n', '<LocalLeader>hp', ':HopPattern<cr>', {})
vim.keymap.set('n', '<LocalLeader>hv', ':HopVertical<cr>', {})
vim.keymap.set('n', '<LocalLeader>hw', ':HopWord<cr>', {})
