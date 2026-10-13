vim.opt.guicursor = "i:block-blinkon500-blinkoff500"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "80"
vim.opt.listchars = "tab: ,multispace:|   ,eol:󰌑"
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

-- Expose a server socket keyed by the tmux pane id, so tmux-neolazygit can open
-- files back into THIS nvim via `nvim --server <sock> --remote` (reliable on
-- macOS, where the plugin's pstree-based discovery does not work).
do
    local pane = vim.env.TMUX_PANE
    local xdg = vim.env.XDG_RUNTIME_DIR
    if pane and xdg and xdg ~= "" then
        pcall(vim.fn.serverstart, xdg .. "/nvim-" .. pane .. ".sock")
    end
end

