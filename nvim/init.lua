--
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--
---@diagnostic disable-next-line: inject-field
vim.g.mapleader = " "
---@diagnostic disable-next-line: inject-field
vim.g.maplocalleader = ","
-- Set to true if you have a Nerd Font installed
---@diagnostic disable-next-line: inject-field
vim.g.have_nerd_font = true

-- Setup initial configuration,
-- Primarily just download and execute lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

-- Add lazy to the `runtimepath`, this allows us to `require` it.
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/custom/plugins/` folder
require("lazy").setup({ import = "custom/plugins" }, {
    change_detection = {
        notify = false,
    },
    ui = {
        icons = vim.g.have_nerd_font and {} or require("custom.signs"),
    },
})

require("custom")
