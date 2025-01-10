return {
    {
        "catgoose/nvim-colorizer.lua",
        lazy = true,
        event = "BufReadPre",
        opts = {
            -- don't colorize color names
            user_default_options = {
                names = false,
            },
        },
    },
}
