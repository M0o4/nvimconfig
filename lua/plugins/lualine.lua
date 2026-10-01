vim.pack.add({
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
    sections = {
        lualine_c = {
            {
                "filename",
                file_status = true,     -- Displays file status (readonly status, modified status)
                newfile_status = true,  -- Display new file status (new file means no write after created)
                path = 1,               -- 0: Just the filename
                                        -- 1: Relative path
                                        -- 2: Absolute path
                                        -- 3: Absolute path, with tilde as the home directory
                                        -- 4: Filename and parent dir, with tilde as the home directory

                shorting_target = 40,   -- Shortens path to leave 40 spaces in the window
                                        -- for other components. (terrible name, any suggestions?)
                                        -- It can also be a function that returns
                                        -- the value of `shorting_target` dynamically.
                symbols = {
                    modified = "[+]",      -- Text to show when the file is modified.
                    readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    newfile = "[New]",     -- Text to show for newly created file before first write
                },
            },
        },
    },
})
