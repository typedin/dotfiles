return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'f-person/git-blame.nvim',
    },
    config = function()
        local git_blame = require('gitblame')
        vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                globalstatus = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = {
                    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                },
                lualine_y = { 'filetype' },
                lualine_z = {
                    { 'diagnostics', sources = { 'nvim_diagnostic' } },
                },
            },
            extensions = { 'fugitive', 'quickfix' },
        })
    end,
}
