vim.pack.add({
    { src = "https://github.com/folke/trouble.nvim" },
})

-- Pretty, navigable list of diagnostics / quickfix / references.
require("trouble").setup({})
