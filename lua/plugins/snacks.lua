vim.pack.add({
    { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
    -- File explorer (a picker under the hood). replace_netrw = false so it does
    -- NOT auto-open on startup / when opening a directory — use <leader>e.
    explorer = { replace_netrw = false },
    picker = {},
})
