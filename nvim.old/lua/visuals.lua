local my_colors = {
    bg = "#000000",
}

require("kanagawa").setup { colors = my_colors }
vim.cmd "colorscheme kanagawa"
vim.opt.background = "dark"
vim.o.termguicolors = true
