return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                build = "make install_jsregexp", -- install jsregexp (optional!).
            },
            "saadparwaiz1/cmp_luasnip",

            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
                dependencies = {
                    "zbirenbaum/copilot.lua",
                    cmd = "Copilot",
                    event = "InsertEnter",
                    config = function()
                        require("copilot").setup({})
                    end,
                },
            },
            -- DISABLED for testing purposes
            -- I'm testing the ones above
            {
                -- "github/copilot.vim",
                -- config = function()
                --     -- copilot seems to be is completing only if there are no other completions options
                --     -- so I'm using <C-N> and <C-P> to navigate the completions.
                --     -- If there are many completions provided by copilot, a n/o will appear next the completions
                --     -- they are not shown by default
                --      local set = vim.api.nvim_set_keymap
                --      set("i", "<C-n>", "copilot#Next()", { expr = true, silent = true, noremap = false })
                --      set("i", "<C-p>", "copilot#Previous()", { expr = true, silent = true, noremap = false })
                --      set("i", "<C-y>", "copilot#Accept()", { expr = true, silent = true, noremap = false })
                -- end,
            },
        },
        config = function()
            -- See `:help cmp`
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})
            cmp.setup({
                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                completion = { completeopt = "menu,menuone,noinsert" },
                formatting = {
                    -- See: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
                    format = function(entry, vim_item)
                        -- Set `kind` to "$icon $kind".
                        local lsp_kinds = require("custom.signs").lsp_kinds
                        vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- Select the [n]ext item
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    -- Accept ([y]es) the completion.
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                sources = {
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    -- { name = "calc" },
                    -- { name = "path" },
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        require("copilot_cmp.comparators").prioritize,

                        -- Below is the default comparitor list and order for nvim-cmp
                        cmp.config.compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.locality,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        col_offset = -1,
                        scrollbar = false,
                        scrolloff = 3,
                        -- Default for bordered() is 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'
                        -- Default for non-bordered, which we'll use here, is:
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        scrollbar = false,
                        -- Default for bordered() is 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'
                        -- Default for non-bordered is 'FloatBorder:NormalFloat'
                        -- Suggestion from: https://github.com/hrsh7th/nvim-cmp/issues/2042
                        -- is to use 'NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None'
                        -- but this also seems to suffice:
                        winhighlight = "CursorLine:Visual,Search:None",
                    }),
                },
            })
        end,
    },
}
