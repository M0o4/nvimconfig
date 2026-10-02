vim.pack.add({
    { src = "https://github.com/j-hui/fidget.nvim" },
})

-- Visible LSP progress spinner (bottom-right), e.g. while the Angular language
-- server initializes. Also renders vim.notify messages.
require("fidget").setup({
    notification = {
        window = {
            winblend = 0, -- works with the transparent colorscheme
        },
    },
})
