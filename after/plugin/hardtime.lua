-- vim training & hints
require("hardtime").setup({
    cmdheight = 2,
    restricted_keys = {
        -- <C-n> is used by multicursor.nvim, hardtime would shadow that mapping
        ["<C-N>"] = false,
    },
})
