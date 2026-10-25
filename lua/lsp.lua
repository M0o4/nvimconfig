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
