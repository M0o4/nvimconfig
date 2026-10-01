vim.pack.add({
    { src = "https://github.com/goolord/alpha-nvim" },
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝██║  ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
    "                                                     ",
}

dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", "<cmd>lua require('fzf-lua').files()<cr>"),
    dashboard.button("n", "  New file", "<cmd>ene <BAR> startinsert<cr>"),
    dashboard.button("r", "  Recent files", "<cmd>lua require('fzf-lua').oldfiles()<cr>"),
    dashboard.button("g", "  Find text", "<cmd>lua require('fzf-lua').live_grep()<cr>"),
    dashboard.button("e", "  Explorer", "<cmd>lua Snacks.explorer()<cr>"),
    dashboard.button("c", "  Config", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<cr>"),
    dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
}

alpha.setup(dashboard.config)

-- alpha shows automatically when nvim starts with no arguments. Also show it
-- when nvim is launched on a directory (e.g. `nvim .`) instead of opening a
-- file/explorer there.
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 1 then
            local arg = vim.fn.argv(0)
            if type(arg) == "string" and vim.fn.isdirectory(arg) == 1 then
                vim.schedule(function()
                    pcall(vim.cmd.cd, arg)
                    pcall(vim.cmd, "silent! bwipeout")
                    require("alpha").start(false)
                end)
            end
        end
    end,
})
