local nmap = require("typedin.keymap").nmap
-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign { name = "DiagnosticSignError", text = "" }
sign { name = "DiagnosticSignWarn", text = "" }
sign { name = "DiagnosticSignHint", text = "" }
sign { name = "DiagnosticSignInfo", text = "" }

local goto_opts = {
    wrap = true,
    float = true,
}

nmap {
    "<LocalLeader>dn",
    function()
        vim.diagnostic.goto_next(goto_opts)
    end,
}

nmap {
    "<LocalLeader>dp",
    function()
        vim.diagnostic.goto_prev(goto_opts)
    end,
}

nmap {
    "<LocalLeader>sl",
    function()
        vim.diagnostic.open_float(0, {
            scope = "line",
        })
    end,
}

vim.diagnostic.config {
    virtual_text = false,
    severity_sort = true,
    float = {
        focus = false,
        source = "always",
        border = "rounded",
    },
}

vim.o.updatetime = 50
vim.cmd [[
    set signcolumn=yes
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]]
