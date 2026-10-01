vim.keymap.set("n", "<leader>e", function()
    Snacks.explorer()
end)

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader><leader>", fzf.files)
vim.keymap.set("n", "<leader>/", fzf.live_grep)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Format with prettier (conform); falls back to LSP formatting if no prettier.
vim.keymap.set("n", "<Leader>fo", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, opts)

-- Apply all ESLint auto-fixes in the current buffer.
vim.keymap.set("n", "<Leader>fx", "<cmd>EslintFixAll<CR>", opts)

-- flash.nvim: jump anywhere by typing labels.
vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash treesitter" })

-- trouble.nvim: diagnostics list.
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })

-- grug-far.nvim: project-wide search & replace.
vim.keymap.set("n", "<leader>sr", function()
    require("grug-far").open()
end, { desc = "Search & replace" })

-- inc-rename.nvim: LSP rename with live preview.
vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename symbol" })
