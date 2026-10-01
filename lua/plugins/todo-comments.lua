vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
})

-- Highlight and search TODO / FIXME / HACK / NOTE comments.
require("todo-comments").setup()
