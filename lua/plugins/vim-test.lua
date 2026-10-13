vim.pack.add({
    { src = "https://github.com/vim-test/vim-test" },
})

-- Run tests in a tmux pane via vimux. Keymaps are in keymap.lua.
vim.g["test#strategy"] = "vimux"

-- The monorepo mixes Playwright (e2e / *-isolations), vitest and jest — all on
-- the same .spec.ts extension. Disable the `angular` runner (it would run
-- `ng test` just because angular.json exists) and allow the ones we use.
vim.g["test#enabled_runners"] = {
    "javascript#playwright",
    "javascript#vitest",
    "javascript#jest",
    "rust#cargotest",
    "go#gotest",
}

-- Nothing is installed globally; use the project-local binaries via npx.
vim.g["test#javascript#vitest#executable"] = "npx vitest"
vim.g["test#javascript#jest#executable"] = "npx jest"
vim.g["test#javascript#playwright#executable"] = "npx playwright test"

-- Pick the right runner per file, since all three use .spec.ts and vim-test
-- cannot otherwise tell them apart in this repo.
local function pick_runner(buf)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
        return
    end
    local lines = vim.api.nvim_buf_get_lines(buf, 0, 80, false)
    local text = table.concat(lines, "\n")
    local dir = vim.fs.dirname(name)

    local vitest_cfg = vim.fs.find(
        { "vite.config.mts", "vite.config.ts", "vite.config.js", "vitest.config.mts", "vitest.config.ts", "vitest.config.js" },
        { path = dir, upward = true }
    )[1]
    local jest_cfg = vim.fs.find(
        { "jest.config.ts", "jest.config.js", "jest.config.mjs" },
        { path = dir, upward = true }
    )[1]

    if text:find("@playwright/test", 1, true) then
        vim.g["test#javascript#runner"] = "playwright"
        -- Playwright configs are per-app; point at the nearest one.
        local cfg = vim.fs.find(
            { "playwright.config.ts", "playwright.config.js" },
            { path = dir, upward = true }
        )[1]
        vim.g["test#javascript#playwright#options"] = cfg and ("--config " .. vim.fn.fnameescape(cfg)) or nil
    elseif vitest_cfg then
        vim.g["test#javascript#runner"] = "vitest"
        -- Use the project's own config so TS path aliases (@plataforma/*) resolve.
        vim.g["test#javascript#vitest#options"] = "--config " .. vim.fn.fnameescape(vitest_cfg)
    elseif jest_cfg then
        vim.g["test#javascript#runner"] = "jest"
        vim.g["test#javascript#jest#options"] = "--config " .. vim.fn.fnameescape(jest_cfg)
    else
        vim.g["test#javascript#runner"] = nil -- let vim-test auto-detect
    end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
    pattern = { "*.spec.ts", "*.test.ts", "*.spec.tsx", "*.test.tsx", "*.spec.js", "*.test.js" },
    callback = function(ev)
        pick_runner(ev.buf)
    end,
})
