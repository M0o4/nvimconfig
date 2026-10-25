vim.pack.add({
    { src = "https://github.com/mrcjkb/rustaceanvim" },
})

-- codelldb (installed via Mason) for debugging.
local codelldb_ext = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = codelldb_ext .. "adapter/codelldb"
local liblldb_path = codelldb_ext .. "lldb/lib/liblldb.dylib"

vim.g.rustaceanvim = {
    -- rustaceanvim manages rust-analyzer itself (do NOT also enable it via
    -- vim.lsp.enable). These are the rust-analyzer settings.
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    buildScripts = { enable = true },
                },
                checkOnSave = true,
                check = {
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
                procMacro = { enable = true },
                inlayHints = {
                    chainingHints = { enable = true },
                    closingBraceHints = { enable = true, minLines = 25 },
                    parameterHints = { enable = true },
                    typeHints = { enable = true },
                },
            },
        },
    },
    dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
}

-- Rust-specific keymaps (rustaceanvim exposes the :RustLsp command).
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function(ev)
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end
        map("<leader>rr", "<cmd>RustLsp runnables<cr>", "Rust runnables")
        map("<leader>rd", "<cmd>RustLsp debuggables<cr>", "Rust debuggables")
        map("<leader>rm", "<cmd>RustLsp expandMacro<cr>", "Expand macro")
        map("<leader>rc", "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml")
        map("<leader>ca", "<cmd>RustLsp codeAction<cr>", "Rust code action")
    end,
})
