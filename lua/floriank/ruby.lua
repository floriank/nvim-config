-- some ruby helper methods

-- simple function to search a ruby method via ripgrep
function search_ruby_method()
    local method_name = vim.fn.expand("<cword>") or vim.fn.input('Method Name: ')
    require('telescope.builtin').grep_string({ search = 'def ' .. method_name })
end

-- attaches the function to an autocmd
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>lua search_ruby_method()<CR>', { noremap = true, silent = true })
    end,
})

-- remove the binding on leaving the buffer
vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.rb",
    callback = function()
        vim.api.nvim_buf_del_keymap(0, 'n', '<leader>gr')
    end,
})
