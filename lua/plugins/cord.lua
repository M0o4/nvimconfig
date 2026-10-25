vim.pack.add({
    { src = "https://github.com/vyfor/cord.nvim" },
})

-- Discord Rich Presence. On first run cord fetches its prebuilt server binary
-- from GitHub via curl automatically (no Rust needed).
require("cord").setup({
    display = {
        theme = "atom",
        flavor = "dark",
    },
    text = {
        -- Show the activity but NOT the file name.
        editing = "Editing a file",
        viewing = "Viewing a file",
        -- Omit the project/workspace name line entirely.
        workspace = "",
    },
})
