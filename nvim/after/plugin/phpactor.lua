-- vim.fn.stdpath('data') == ~/.local/share/nvim/site/
local install_path = vim.fn.stdpath('data') .. '/opt/phpactor/'

local function check_for_executable()
    --[[ local f = io.open(install_path, 'r') ]]
    --[[ if f == nil then ]]
    --[[     return false ]]
    --[[ end ]]
    --[[ -- check if the file is executable by checking x in its mods ]]
    --[[ -- ]]
    --[[ local attributes = require('lfs').attributes(install_path .. '/bin/phpactor') ]]
    --[[ return string.find(attributes['permissions'], 'x') ]]
    return true
end

if not check_for_executable() then
    print('phpactor is not executable')
    print('try running these commands:')
    print('git clone git@github.com:phpactor/phpactor ' .. install_path)
    print('(see: https://phpactor.readthedocs.io/en/master/usage/standalone.html)')
end

require('phpactor').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    install = {
        path = install_path,
        branch = 'master',
        -- this is : ~/.local/share/nvim/opt/phpactor
        bin = install_path .. '/bin/phpactor',
        php_bin = 'php',
        composer_bin = 'composer',
        git_bin = 'git',
        check_on_startup = 'none',
    },
    lspconfig = {
        enabled = true,
        options = {
            language_server_phpstan_enabled = true,
        },
    },
})
