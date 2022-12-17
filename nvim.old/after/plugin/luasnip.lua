local status_ok, npairs = pcall(require, "luasnip")
if not status_ok then
    return
end

require("luasnip").setup {
    after = "nvim-cmp",
    config = function()
        require "snippets"
    end,
}
