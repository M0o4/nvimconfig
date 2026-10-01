vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

local actions = require('fzf-lua.actions')

-- Stuff we never want to see in pickers.
local exclude = {
    ".git",
    "node_modules",
    "dist",
    ".dist",
    "build",
    "out",
    ".next",
    ".nuxt",
    ".angular",     -- Angular build cache
    ".cache",
    "coverage",
    "target",
}

-- Build backend-specific ignore flags from the list above.
local fd_ignore, rg_ignore, find_ignore = "", "", ""
for _, p in ipairs(exclude) do
    fd_ignore = fd_ignore .. " --exclude " .. p
    rg_ignore = rg_ignore .. " -g '!" .. p .. "'"
    find_ignore = find_ignore .. " \\! -path '*/" .. p .. "/*'"
end

require('fzf-lua').setup({
    winopts = { backdrop = 85 },
    files = {
        fd_opts   = "--color=never --type f --hidden --follow" .. fd_ignore,
        rg_opts   = "--color=never --files --hidden --follow" .. rg_ignore,
        find_opts = "-type f" .. find_ignore,
    },
    grep = {
        rg_opts = "--column --line-number --no-heading --color=always"
            .. " --smart-case --max-columns=4096" .. rg_ignore .. " -e",
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        }
    },
    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"]  = actions.file_edit_or_qf,
        }
    }
})
