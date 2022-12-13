local packer = require "packer"
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}
local packer_setup = {}

return packer_setup
