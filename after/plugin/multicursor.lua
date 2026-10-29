local mc = require("multicursor-nvim")
mc.setup()

-- sublime's ctrl+d: add a cursor at the next match of the word/selection
vim.keymap.set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
vim.keymap.set({ "n", "x" }, "<C-q>", function() mc.matchSkipCursor(1) end)
vim.keymap.set({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors)

-- only active while multiple cursors exist, so <Esc> behaves normally otherwise
mc.addKeymapLayer(function(layer_set)
    layer_set("n", "<Esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)

vim.api.nvim_set_hl(0, "MultiCursorCursor", { reverse = true })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
