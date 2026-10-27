vim.lsp.enable({
  -- rust-analyzer is managed by rustaceanvim (lua/plugins/rustaceanvim.lua).
  "lua_ls",
  "angular-language-server",
  "vtsls",
  "eslint",
  "jsonls",
  "tailwindcss",
  "gopls",
})

vim.diagnostic.config({ virtual_text = true })

-- Native :LspRestart (no lspconfig here): stop clients for the current buffer
-- and reload so they re-attach. Handy when gopls/vtsls miss a newly created
-- file (go run sees it, but the server still caches the old package).
vim.api.nvim_create_user_command("LspRestart", function()
    local bufnr = vim.api.nvim_get_current_buf()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        client:stop(true)
    end
    vim.defer_fn(function()
        vim.cmd("edit")
    end, 300)
end, { desc = "Restart LSP clients for the current buffer" })

-- Enable inlay hints (type/parameter hints) for servers that provide them
-- (rust-analyzer, gopls, vtsls). Toggle with <leader>ih (see keymap.lua).
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})
