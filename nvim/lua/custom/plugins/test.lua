return {
    {
        -- "typedin/altestnate.nvim",
        dir = "/home/antoine/code/altestnate.nvim",
    },
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- Installation
            "V13Axel/neotest-pest",
            "fredrikaverpil/neotest-golang",
            "marilari88/neotest-vitest",
            "olimorris/neotest-phpunit",
        },
        config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)

            require("neotest").setup({
                quickfix = { open = false },
                output = { open_on_run = true },
                status = {
                    signs = true,
                    virtual_text = true,
                },
                -- output = { open_on_run = true },
                adapters = {
                    require("neotest-phpunit")({
                        filter_dirs = { "vendor" },
                        root_ignore_files = { "tests/Pest.php" },
                    }),
                    require("neotest-pest")({
                        parallel = function()
                            return (#vim.loop.cpu_info()) / 2
                        end,
                        -- results_path = function()
                        --   return '/tmp/'
                        -- end,
                    }),
                    require("neotest-golang"),
                    require("neotest-vitest")({
                        filter_dir = function(name, _rel_path, _root)
                            return name ~= "node_modules"
                        end,
                        ---Custom criteria for a file path to determine if it is a vitest test file.
                        ---@async
                        ---@param file_path string Path of the potential vitest test file
                        ---@return boolean
                        is_test_file = function(file_path)
                            print(file_path)
                            if string.match(file_path, "test.ts") then
                                return true
                            end
                            return false
                        end,
                    }),
                },
            })
        end,
        keys = {
            {
                "<localleader>tn",
                function()
                    require("neotest").run.run()
                end,
                desc = "Run nearest",
            },
            {
                "<localleader>tl",
                function()
                    require("neotest").run.run_last()
                end,
                desc = "Run last",
            },
            {
                "<localleader>tL",
                function()
                    require("neotest").run.run_last({ strategy = "dap" })
                end,
                desc = "Run last with dap",
            },
            {
                "<localleader>td",
                function()
                    require("neotest").run.run({ strategy = "dap" })
                end,
                desc = "Debug nearest",
            },
            {
                "<localleader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "Run file",
            },
            {
                "<localleader>ta",
                function()
                    require("neotest").run.run(#vim.loop.cwd())
                end,
                desc = "Run all",
            },
            {
                "<localleader>ta",
                function()
                    require("neotest").run.attach()
                end,
                desc = "Attach to the nearest test",
            },
            {
                "<localleader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "Toggle summary",
            },
            {
                "<localleader>to",
                function()
                    require("neotest").output.open({ enter = true, auto_close = true })
                end,
                desc = "Show output window",
            },
            {
                "<localleader>tO",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "Toggle output panel",
            },
            {
                "<localleader>tS",
                function()
                    require("neotest").run.stop()
                end,
                desc = "Stop",
            },
        },
    },
}
