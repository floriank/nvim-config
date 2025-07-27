require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "deps",
            "_build",
            -- phoenix gettext
            "priv/gettext",
            "vendor/"
        },
        initial_mode = "insert",
        selection_strategy = "reset",
        scroll_strategy = "cycle",
        sorting_strategy = "ascending",
        cache_picker = {
            num_pickers = -1,
        },
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
