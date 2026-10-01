vim.pack.add({
    { src = "https://github.com/folke/ts-comments.nvim" },
})

-- Context-aware commentstring (e.g. correct comments for HTML inside .ts,
-- templates, embedded languages). Enhances built-in `gcc` / `gc`.
require("ts-comments").setup()
