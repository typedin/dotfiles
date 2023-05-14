return {
    'nvim-telescope/telescope.nvim',
    --[[ branch = '0.1.x', ]]
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-fzf-writer.nvim',
        'nvim-telescope/telescope-hop.nvim',
        'nvim-telescope/telescope-packer.nvim',
        'nvim-telescope/telescope-rs.nvim',
        'nvim-telescope/telescope-smart-history.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
}
