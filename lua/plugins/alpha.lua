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
    dashboard.button("g", "  Find text", "<cmd>lua require('fzf-lua').live_grep()<cr>"),
    dashboard.button("e", "  Explorer", "<cmd>lua Snacks.explorer()<cr>"),
    dashboard.button("c", "  Config", "<cmd>lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })<cr>"),
    dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
}

-- Recent files scoped to the CURRENT project (cwd). Built as a function so it is
-- re-evaluated every time alpha is drawn, reflecting whatever project you are in.
local function recent_files()
    local cwd = vim.fn.getcwd()
    local items = {
        { type = "text", val = "Recent — " .. vim.fn.fnamemodify(cwd, ":t"), opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
    }

    local count = 0
    for _, file in ipairs(vim.v.oldfiles or {}) do
        if count >= 8 then
            break
        end
        if vim.startswith(file, cwd .. "/") and vim.fn.filereadable(file) == 1 then
            count = count + 1
            local short = vim.fn.fnamemodify(file, ":.")
            local btn = dashboard.button(
                tostring(count),
                "  " .. short,
                "<cmd>edit " .. vim.fn.fnameescape(file) .. "<cr>"
            )
            table.insert(items, btn)
        end
    end

    if count == 0 then
        table.insert(items, {
            type = "text",
            val = "no recent files in this project",
            opts = { hl = "Comment", position = "center" },
        })
    end

    return items
end

dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    { type = "group", val = recent_files },
    { type = "padding", val = 1 },
    dashboard.section.footer,
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
