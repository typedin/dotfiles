vim.cmd([[
    let test#javascript#reactscripts#executable = "npm test"
    let test#typescript#runner = 'vitest'
]])

-- set is for option
-- let is for variables
-- g is for global
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

vim.cmd([[
    " set current path when vim loads up
    let g:test#project_root = finddir('.git/..', expand('%:p:h').';')
    let test#lua#runner = 'busted'

    " initially empty status
    " let g:testing_status = ''

    nnoremap <silent> t_ ^/function <CR>ewvt(:s/\%V /_/g<CR>jji<TAB>

    " use neomake for async running of tests
    " do not open the test run results, can be changed to show them
    "let g:neomake_open_list = 1

    augroup neomake_hook
        au!
        autocmd User NeomakeJobFinished call TestFinished()
        autocmd User NeomakeJobStarted call TestStarted()
    augroup END

    " Start test
    function! TestStarted() abort
        let g:testing_status = 'Test ⌛'
        :call PrintStatus()
    endfunction

    " Show message when all tests are passing
    function! TestFinished() abort
        let context = g:neomake_hook_context
        if context.jobinfo.exit_code == 0
            let g:testing_status = 'Test ✅'
            " test commit
            execute '!(cd ' . g:test#project_root .'; git add . ; git commit -n -m "wip (tcr) ")'
        endif
        if context.jobinfo.exit_code == 1
            let g:testing_status = 'Test ❌'
            " test revert
            :!git reset --hard
        endif
        :call PrintStatus()
    endfunction

    function! TestStatus() abort
        :call PrintStatus()
    endfunction

    function! PrintStatus()
        :echo g:testing_status
    endfunction
]])
