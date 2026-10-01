vim.pack.add({
    { src = "https://github.com/echasnovski/mini.pairs" },
    { src = "https://github.com/echasnovski/mini.surround" },
})

-- Auto-close brackets/quotes.
require("mini.pairs").setup()

-- Surround: add/delete/replace quotes, brackets, tags.
-- Uses a `gs` prefix so it does not clash with flash.nvim's `s`.
require("mini.surround").setup({
    mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
    },
})
