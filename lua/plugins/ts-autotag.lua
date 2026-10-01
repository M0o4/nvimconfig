vim.pack.add({
    { src = "https://github.com/windwp/nvim-ts-autotag" },
})

-- Auto close and auto rename HTML / Angular / JSX tags.
require("nvim-ts-autotag").setup()
