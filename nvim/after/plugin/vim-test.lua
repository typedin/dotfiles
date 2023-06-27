vim.cmd([[
    let test#javascript#reactscripts#executable = "npm test"
    let test#typescript#runner = 'vitest'
]])

-- vim-ultest
vim.api.nvim_set_var('ultest_use_pty', 1)

local default_strategy = 'floaterm'
local tcr_strategy = 'neomake'
-- vim-test
vim.api.nvim_set_var('testing_status', '')
vim.api.nvim_set_var('test#strategy', default_strategy)

--[[ nnoremap <silent>tcr :call ToggleStrategy()<CR> ]]
vim.keymap.set('n', 'tcr', function()
    if vim.api.nvim_get_var('test#strategy') == default_strategy then
        vim.api.nvim_set_var('test#strategy', tcr_strategy)
        vim.api.nvim_set_var('neomake_open_list', 0)
    else
        vim.api.nvim_set_var('test#strategy', default_strategy)
        vim.api.nvim_set_var('neomake_open_list', 1)
    end
    print('changed testing strategy to ' .. vim.api.nvim_get_var('test#strategy'))
end, { silent = true })

vim.keymap.set('n', 'tn', ':TestNearest<CR>', { silent = true })
vim.keymap.set('n', 'tf', ':TestFile<CR>', { silent = true })
vim.keymap.set('n', 'ts', ':TestSuite<CR>', { silent = true })
vim.keymap.set('n', 'tl', ':TestLast<CR>', { silent = true })

--  nnoremap <silent> t_ ^/function <CR>ewvt(:s/\%V /_/g<CR>jji<TAB>
-- never used this

local neomake_test_group = vim.api.nvim_create_augroup('NeomakeTestHook', { clear = true })
local function print_status(status)
    print(status)
end
vim.api.nvim_create_autocmd('User', {
    callback = function()
        print_status('Test ⌛⌛⌛⌛⌛⌛')
    end,
    pattern = 'NeomakeJobStarted',
    group = neomake_test_group,
})
vim.api.nvim_create_autocmd('User', {
    callback = function()
        local context = vim.g.neomake_hook_context
        if context == nil then
            print_status('❌❌❌❌❌❌')
            print_status('no neomake_hook_context see logs')
            print_status('❌❌❌❌❌❌')
            return
        end
        if context.jobinfo.exit_code == 0 then
            print_status('Test ✅✅✅✅✅✅')
            vim.cmd([[ execute '!(cd ' . g:test#project_root .'; git add . ; git commit -n -m "wip (tcr) ")' ]])
        elseif context.jobinfo.exit_code ~= 0 then
            print_status('Test ❌❌❌❌❌❌')
            vim.cmd([[ :!git reset --hard ]])
        end
    end,
    pattern = 'NeomakeJobFinished',
    group = neomake_test_group,
})
vim.cmd([[
    " set current path when vim loads up
    let g:test#project_root = finddir('.git/..', expand('%:p:h').';')
    let test#lua#runner = 'busted'

    " initially empty status
    " let g:testing_status = ''

    " use neomake for async running of tests
    " do not open the test run results, can be changed to show them
    "let g:neomake_open_list = 1
]])
