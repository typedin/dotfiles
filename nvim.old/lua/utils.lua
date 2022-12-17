local lv_utils = {}

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function lv_utils.check_lsp_client_active(name)
    local clients = vim.lsp.get_active_clients()
    for _, client in pairs(clients) do
        if client.name == name then return true end
    end
    return false
end

lv_utils.dump = dump
return lv_utils
