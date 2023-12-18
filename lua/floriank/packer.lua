-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine-moon')
	  end
  })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use {
      "romgrk/nvim-treesitter-context",
      after = "nvim-treesitter", -- Load after Tree-sitter
      config = function()
          require("treesitter-context").setup {
              enable = true, -- Enable Tree-sitter-context
          }
      end,
  }
  use('nvim-treesitter/playground')

  use('theprimeagen/harpoon')
  use('theprimeagen/vim-be-good')

  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use('knsh14/vim-github-link')
  use('tpope/vim-commentary')
  use('tpope/vim-unimpaired')
  use('tpope/vim-rails')
  use('tpope/vim-bundler')
  use('tpope/vim-dispatch')
  use('tpope/vim-abolish')
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},     -- Required
		  {'hrsh7th/cmp-nvim-lsp'}, -- Required
		  {'L3MON4D3/LuaSnip'},     -- Required
	  }
  }
end)

