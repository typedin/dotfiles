local packer = require('packer')
packer.init({
  display = {
    open_fn = function()
      return packer.util.float({ border = 'rounded' })
    end,
  },
})
