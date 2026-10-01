vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
})

-- Jump anywhere on screen by typing labels. Keymaps (s / S) are in keymap.lua.
require("flash").setup({})
