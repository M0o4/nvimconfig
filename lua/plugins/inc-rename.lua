vim.pack.add({
    { src = "https://github.com/smjonas/inc-rename.nvim" },
})

-- LSP rename with a live preview of every occurrence. Keymap in keymap.lua.
require("inc_rename").setup()
