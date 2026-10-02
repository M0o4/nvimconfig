vim.pack.add({
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

-- The plugin auto-creates <C-h/j/k/l> and <C-\> mappings that move between
-- Neovim splits AND tmux panes seamlessly. No extra setup needed on the Neovim
-- side; the tmux side is handled by the matching plugin in ~/.tmux.conf (TPM).
