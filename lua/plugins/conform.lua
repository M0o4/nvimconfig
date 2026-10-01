vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
    -- conform resolves `prettier` from the project's node_modules/.bin first,
    -- so each project's own .prettierrc / version is respected.
    formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        htmlangular = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
    },
    -- Format automatically on save. For filetypes without a formatter above
    -- (e.g. rust), it falls back to the LSP formatter if the server has one.
    format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
})
