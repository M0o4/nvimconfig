vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
    -- Inline blame (author · date · summary) at the end of the current line.
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
    },
})
