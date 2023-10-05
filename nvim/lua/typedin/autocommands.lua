local api = vim.api
-- Show command line when recording macro
local recordEnterGrp = api.nvim_create_augroup('RecordingEnter', { clear = true })

api.nvim_create_autocmd('RecordingEnter', {
    command = 'set cmdheight=1',
    group = recordEnterGrp,
})

-- hide command line when recording macro
local recordLeaveGrp = api.nvim_create_augroup('RecordingLeave', { clear = true })
api.nvim_create_autocmd('RecordingLeave', {
    command = 'set cmdheight=0',
    group = recordLeaveGrp,
})
