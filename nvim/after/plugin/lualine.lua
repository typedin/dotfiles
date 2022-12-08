local navic = require "nvim-navic"
navic.setup {
    icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
    },
}

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "auto",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
            {
                "filename",
                file_status = true,
                path = 1,
            },
        },
        lualine_x = { { navic.get_location, cond = navic.is_available } },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
    },
    extensions = { "fugitive", "quickfix" },
}
