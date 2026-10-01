vim.pack.add({
    { src = "https://github.com/petertriho/nvim-scrollbar" },
})

require("scrollbar").setup({
    excluded_filetypes = {
        "noice",
        "notify",
        "snacks_picker_list",
        "snacks_dashboard",
    },
})

-- Show git changes on the scrollbar (gitsigns loads before this file).
require("scrollbar.handlers.gitsigns").setup()
