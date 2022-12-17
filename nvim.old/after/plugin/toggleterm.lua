vim.api.nvim_set_keymap("n", "<LocalLeader>tt", ":ToggleTerm size=40 dir=git_dir direction=vertical<cr>", {noremap = true, silent = true})


require("toggleterm").setup {
    shell = "bash",
    close_on_exit = true
}
