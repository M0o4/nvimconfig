vim.pack.add({
    { src = "https://github.com/zbirenbaum/copilot.lua" },
})

require("copilot").setup({
    -- Inline "ghost text" suggestions as you type (VS Code-like).
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = "<C-g>",  -- accept the whole suggestion
            next = "<M-]>",    -- cycle to next suggestion
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
    -- The split "panel" view is off; ghost text is enough.
    panel = { enabled = false },
    filetypes = {
        -- Enable everywhere, but keep it out of noisy/secret buffers.
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        ["."] = false,
        ["*"] = true,
    },
})
