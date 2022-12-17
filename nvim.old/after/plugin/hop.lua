require'hop'.setup{}
vim.api.nvim_set_keymap('', '<LocalLeader>hl', ":HopLineStart<cr>", {})
vim.api.nvim_set_keymap('', '<LocalLeader>hp', ":HopPattern<cr>", {})
vim.api.nvim_set_keymap('', '<LocalLeader>hv', ":HopVertical<cr>", {})
vim.api.nvim_set_keymap('', '<LocalLeader>hw', ":HopWord<cr>", {})
