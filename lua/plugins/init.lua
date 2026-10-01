-- Auto-loader: require every *.lua in this folder (except this file).
-- Add a new plugin by dropping a new file in lua/plugins/ — no edits here.
local dir = vim.fn.stdpath("config") .. "/lua/plugins"

local names = {}
for name, type in vim.fs.dir(dir) do
    if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
        names[#names + 1] = name:sub(1, -5) -- strip ".lua"
    end
end

-- Sort for deterministic load order (e.g. devicons before lualine).
table.sort(names)

for _, name in ipairs(names) do
    require("plugins." .. name)
end
