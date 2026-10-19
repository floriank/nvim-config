local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local output = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Failed to clone lazy.nvim:\n" .. output)
    end
end
vim.opt.rtp:prepend(lazypath)

-- The leader has to be set before lazy.nvim loads any plugin spec.
vim.g.mapleader = " "

require("lazy").setup({
    spec = {
        { import = "floriank.plugins" },
    },
    -- Every plugin is loaded eagerly, because the files in after/plugin/ call
    -- require() on them directly at startup.
    defaults = { lazy = false },
    install = { colorscheme = { "rose-pine-moon" } },
    checker = { enabled = false },
    change_detection = { notify = false },
})
