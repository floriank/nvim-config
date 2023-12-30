require("telescope").load_extension("cmdline")
vim.api.nvim_set_keymap('n', '<leader><leader>', ':silent Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
