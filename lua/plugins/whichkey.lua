vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" },
})

-- Popup that shows available keybindings after you start a mapping (e.g. after
-- pressing <leader>). Uses nvim-web-devicons (already installed) for icons.
require("which-key").setup({})
