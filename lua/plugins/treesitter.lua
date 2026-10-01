vim.pack.add({
    -- `main` branch = the new API, required for Neovim 0.11+ / 0.12.
    -- (The old `master` branch breaks on 0.12 with "attempt to call method
    -- 'range' (a nil value)".)
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

local langs = {
    "typescript",
    "tsx",
    "javascript",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "angular",
    "markdown",
    "markdown_inline",
    "lua",
    "luadoc",
    "vim",
    "vimdoc",
    "bash",
    "rust",
    "regex",
    "query",
}

-- Install/compile parsers (async; no-op for ones already present).
pcall(function()
    require("nvim-treesitter").install(langs)
end)

-- Enable treesitter highlighting whenever a buffer has a parser available.
vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})
