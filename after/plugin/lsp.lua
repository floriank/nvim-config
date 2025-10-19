-- plugins you already require
local cmp = require('cmp')
local luasnip = require('luasnip')

-- OPTIONAL: if you still want lsp-zero for icons/prefs, that's fine,
-- but don't let it configure servers. We'll remove its handlers below.
local lsp = require('lsp-zero')

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

-- Your on_attach (unchanged)
local function my_on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

-- Tell *all* servers about cmp's capabilities + your on_attach
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
  on_attach = my_on_attach,
})

-- Mason: install only; do NOT auto-configure servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'ts_ls',
  },
  handlers = {},  -- ⛔️ remove lsp-zero's default_setup handler to avoid double setup
})

-- (Optional) keep lsp-zero for prefs/icons only; it's fine without server handlers
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = { error='E', warn='W', hint='H', info='I' },
})

vim.diagnostic.config({ virtual_text = true })

-- Ruby diag shim: you can keep it if you still need it, but many setups no longer do on 0.11+.
-- (left as-is)

-- ✅ Start servers with the new 0.11 API (single source of truth)
vim.lsp.enable('ts_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('wasm_language_tools')

