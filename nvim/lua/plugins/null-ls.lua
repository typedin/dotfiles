--[[
    as per this https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1621
    null-ls is not maintained anymore
]]
local function has_eslint_config(utils)
    return utils.root_has_file({
        'eslint.config.js', -- from version 9 and up
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'package.json',
    })
end

return {}
--[[ return { ]]
--[[     'jose-elias-alvarez/null-ls.nvim', ]]
--[[     dependencies = { ]]
--[[         'jayp0521/mason-null-ls.nvim', ]]
--[[         'ThePrimeagen/refactoring.nvim', ]]
--[[     }, ]]
--[[     config = function() ]]
--[[         require('null-ls').setup({ ]]
--[[             sources = { ]]
--[[                 require('null-ls').builtins.diagnostics.eslint_d.with({ condition = has_eslint_config }), ]]
--[[                 require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }), ]]
--[[                 require('null-ls').builtins.formatting.eslint_d.with({ condition = has_eslint_config }), ]]
--[[                 require('null-ls').builtins.formatting.prettierd, ]]
--[[                 require('null-ls').builtins.formatting.phpcsfixer, ]]
--[[                 require('null-ls').builtins.diagnostics.luacheck, ]]
--[[                 require('null-ls').builtins.code_actions.refactoring, ]]
--[[             }, ]]
--[[         }) ]]
--[[         require('mason-null-ls').setup({ automatic_installation = true }) ]]
--[[     end, ]]
--[[ } ]]
