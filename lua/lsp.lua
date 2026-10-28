vim.lsp.enable({
  -- rust-analyzer is managed by rustaceanvim (lua/plugins/rustaceanvim.lua).
  "lua_ls",
  "angular-language-server",
  "vtsls",
  "eslint",
  "jsonls",
  "tailwindcss",
  "gopls",
  "vue_ls",
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

-- Workaround for a Neovim 0.12 bug: inlay hints render as extmarks, but when
-- several LSP clients attach to one buffer (e.g. vtsls + angular-language-server
-- on a .ts file) one client's hints can be left over from an older buffer
-- version while another client bumps the shared version. The stale hint's
-- column then points past the end of a now-shorter line, and the decoration
-- provider throws "Invalid 'col': out of range" on every redraw (spam).
-- We wrap nvim_buf_set_extmark and clamp the column to the line length, but
-- ONLY for the inlay-hint namespace, so other plugins' extmarks are untouched.
-- Remove once upstream clamps this. (inlay_hint.lua does `local api = vim.api`,
-- indexing the table at call time, so replacing the table entry takes effect.)
do
    local ns_inlay = vim.api.nvim_create_namespace("nvim.lsp.inlayhint")
    local set_extmark = vim.api.nvim_buf_set_extmark
    vim.api.nvim_buf_set_extmark = function(buffer, ns, line, col, opts)
        if ns == ns_inlay and type(line) == "number" and type(col) == "number" then
            local n = vim.api.nvim_buf_line_count(buffer)
            if line >= 0 and line < n then
                local text = vim.api.nvim_buf_get_lines(buffer, line, line + 1, false)[1] or ""
                if col > #text then
                    col = #text
                end
            end
        end
        return set_extmark(buffer, ns, line, col, opts)
    end
end

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
