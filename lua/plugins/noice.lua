vim.pack.add({
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/rcarriga/nvim-notify" },
    { src = "https://github.com/folke/noice.nvim" },
})

-- nvim-notify warns when the colorscheme is transparent; give it a bg.
require("notify").setup({
    background_colour = "#000000",
})

require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
        -- Show LSP progress (e.g. "Angular: initializing…") so you know when
        -- the language server is ready to give completions.
        progress = { enabled = true },
    },
    presets = {
        -- Floating command line + completion as one centered popup, like the
        -- tutorial screenshot.
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
})
