local M = {}

function M.local_buffer_mapper(mappings)
    local nnoremap = function(lhs, rhs)
        local options = {noremap = true, silent = true}
        vim.api.nvim_buf_set_keymap(0, 'n', lhs, rhs, options)
    end

    for lhs, rhs in pairs(mappings) do nnoremap(lhs, rhs) end
end

function M.mode_mapper(mode, mappings)
    local map_function = function(lhs, rhs)
        local options = {noremap = true, silent = true}
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    for lhs, rhs in pairs(mappings) do map_function(lhs, rhs) end
end

return M
