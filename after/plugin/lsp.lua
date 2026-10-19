-- plugins you already require
local cmp = require('cmp')
local luasnip = require('luasnip')

-- nvim-cmp
cmp.setup({
  performance = {
    debounce = 60,
    throttle = 30,
    fetching_timeout = 500,
    confirm_resolve_timeout = 80,
    async_budget = 1,
    max_view_entries = 200,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>']   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-n>']   = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<CR>']    = cmp.mapping.confirm({ select = true }),     -- was '<Enter>'
    ['<C-Space>'] = cmp.mapping.complete(),                   -- was select_next_item()
  }),
  -- ✅ You were missing sources; without these, no LSP items appear
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- LspAttach fires after every server attaches, regardless of per-server on_attach overrides
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Mason: install only; do NOT auto-configure servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'ts_ls',
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.HINT] = 'H',
      [vim.diagnostic.severity.INFO] = 'I',
    },
  },
})

-- Ruby diag shim: you can keep it if you still need it, but many setups no longer do on 0.11+.
-- (left as-is)

-- knowledge-lsp: custom knowledge server (not in Mason/lspconfig)
vim.lsp.config('knowledge_lsp', {
  cmd = { 'knowledge-lsp' },
  filetypes = { '*' },
})

-- ✅ Start servers with the new 0.11 API (single source of truth)
vim.lsp.enable('ts_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('wasm_language_tools')
vim.lsp.enable('knowledge_lsp')

