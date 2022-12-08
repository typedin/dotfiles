local actions = require "telescope.actions"

require("telescope").setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = {"smart"},
        -- the default mappings so I can know what they are
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["<Tab>"] = actions.toggle_selection +
                    actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection +
                    actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist +
                    actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key -- keys from pressing <C-/>
            },
            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                ["<Tab>"] = actions.toggle_selection +
                    actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection +
                    actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist +
                    actions.open_qflist,
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                ["?"] = actions.which_key
            }
        }
    }
}
-- when I press esc I'm in normal mode
-- which means that I can select a file with <j> and <k>
--
local mappings = {
    ["n"] = {
        ["<leader>p"] = "<cmd>lua require('telescope.builtin').find_files()<cr>",
        ["<leader>g"] = "<cmd>lua require('telescope.builtin').live_grep()<cr>",
        ["<leader>b"] = "<cmd>lua require('telescope.builtin').buffers()<cr>",
        ["<leader>t"] = "<cmd>lua require('telescope.builtin').help_tags()<cr>",
        ["<C-p>"] = "<cmd>lua require('helpers.messages').nope()<cr>",
    }
}

for mode, value in pairs(mappings) do
    require("helpers.mappers").mode_mapper(mode, value)
end
