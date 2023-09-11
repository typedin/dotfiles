return {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
        require('chatgpt').setup({
            async_api_key_cmd = 'pass show chatgpt',
        })
    end,
    dependencies = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
}
