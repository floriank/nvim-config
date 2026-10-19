require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  -- ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "ruby", "elixir", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
  },
}

-- nvim-treesitter's frozen `master` branch registers its query directives with
-- `all = false` and expects a single node per capture. Neovim 0.12 ignores that
-- flag and always passes a list of nodes, which crashes markdown injections
-- (e.g. hover via `K`). Re-register the affected directives list-aware.
-- Remove once nvim-treesitter is moved to its `main` branch.
local function single_node(capture)
  if type(capture) == "table" then
    return capture[#capture]
  end
  return capture
end

local html_script_type_languages = {
  ["importmap"] = "json",
  ["module"] = "javascript",
  ["application/ecmascript"] = "javascript",
  ["text/ecmascript"] = "javascript",
}

local info_string_language_aliases = {
  ex = "elixir",
  pl = "perl",
  sh = "bash",
  uxn = "uxntal",
  ts = "typescript",
}

local directive_opts = { force = true, all = false }

vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local node = single_node(match[pred[2]])
  if not node then
    return
  end
  local info_string = vim.treesitter.get_node_text(node, bufnr):lower()
  local filetype = vim.filetype.match({ filename = "a." .. info_string })
  metadata["injection.language"] = filetype or info_string_language_aliases[info_string] or info_string
end, directive_opts)

vim.treesitter.query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
  local node = single_node(match[pred[2]])
  if not node then
    return
  end
  local mimetype = vim.treesitter.get_node_text(node, bufnr)
  local configured = html_script_type_languages[mimetype]
  if configured then
    metadata["injection.language"] = configured
  else
    local parts = vim.split(mimetype, "/", {})
    metadata["injection.language"] = parts[#parts]
  end
end, directive_opts)

vim.treesitter.query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
  local id = pred[2]
  local node = single_node(match[id])
  if not node then
    return
  end
  local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
  metadata[id] = metadata[id] or {}
  metadata[id].text = string.lower(text)
end, directive_opts)
