local config = function()
    -- Can use P to toggle auto movement
    require("trouble").setup {
        auto_preview = false,
        auto_fold = true,
    }
end

return config
