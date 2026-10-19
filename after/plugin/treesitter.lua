require("nvim-treesitter").setup({})

-- Parsers that were installed under the old `master` branch, plus the two
-- markdown parsers that hover windows need.
local parsers = {
  "bash", "csv", "desktop", "diff", "dockerfile", "git_config", "git_rebase",
  "gitcommit", "gitignore", "glimmer", "html", "ini", "javascript", "json",
  "lua", "make", "markdown", "markdown_inline", "pem", "query", "rbs",
  "ruby", "rust", "sql", "ssh_config", "terraform", "toml", "tsx",
  "typescript", "vim", "vimdoc", "yaml",
}

-- Runs asynchronously and skips parsers that are already present.
require("nvim-treesitter").install(parsers)

-- The `main` branch no longer enables highlighting itself.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then
      return
    end
    -- Fails quietly for filetypes whose parser is not installed.
    pcall(vim.treesitter.start, args.buf, language)
  end,
})
