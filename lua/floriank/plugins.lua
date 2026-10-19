return {
    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    "benfowler/telescope-luasnip.nvim",

    -- colorscheme, loaded first so other plugins pick up its highlights
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- faster switching and vim training
    "theprimeagen/harpoon",
    "theprimeagen/vim-be-good",

    -- better undo history
    "mbbill/undotree",

    -- the tpope section
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-commentary",
    "tpope/vim-unimpaired",
    "tpope/vim-bundler",
    "tpope/vim-dispatch",
    "tpope/vim-abolish",

    -- github linking
    "knsh14/vim-github-link",

    -- LSP integration
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",

    -- snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },

    -- emmet
    "mattn/emmet-vim",

    -- markdown
    "gabrielelana/vim-markdown",

    -- whitespace
    "thirtythreeforty/lessspace.vim",

    -- hardtime
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
    },
}
