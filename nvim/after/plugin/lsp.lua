local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'bashls',
  'efm',
  'eslint',
  'html',
  'intelephense',
  'jsonls',
  'marksman',
  'phpactor',
  'prismals',
  'sumneko_lua',
  'tailwindcss',
  'tsserver',
  'vimls',
  'volar',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 3000, keyword_length = 2 },
    { name = 'luasnip', priority = 2000, keyword_length = 2 },
    { name = 'buffer', priority = 1000, keyword_length = 2 },
    { name = 'path', priority = 900, keyword_length = 2 },
    { name = 'calc', priority = 800 },
  }),
})
lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I',
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  if client.name == 'eslint' then
    vim.cmd.LspStop('eslint')
    return
  end

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<LocalLeader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<LocalLeader>dl', '<cmd>Telescope diagnostics<cr>', opts) -- diagnostic list

  vim.keymap.set('n', '<localleader>dn', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<localleader>dp', vim.diagnostic.goto_prev, opts)

  vim.keymap.set('i', '<localleader>h', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<localleader>gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
end)

-- leave this before diagnostic config
lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
