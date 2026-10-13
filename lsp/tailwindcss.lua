return {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = {
        'html',
        'htmlangular',
        'css',
        'scss',
        'less',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_markers = {
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.cjs',
        'postcss.config.mjs',
        'postcss.config.ts',
        'package.json',
        '.git',
    },
    settings = {
        tailwindCSS = {
            validate = true,
            -- Treat Angular templates as HTML and .ts as JS so class strings
            -- get completions.
            includeLanguages = {
                htmlangular = 'html',
                typescript = 'javascript',
                typescriptreact = 'javascript',
            },
            classAttributes = {
                'class',
                'className',
                'ngClass',
                'class.',
            },
            experimental = {
                -- Pick up class strings in .ts (host: { class: '...' }, cva, etc).
                classRegex = {
                    "class(?:List)?\\s*[:=]\\s*['\"`]([^'\"`]*)['\"`]",
                },
            },
        },
    },
    -- Tailwind v4 projects here import tailwindcss indirectly (via a workspace
    -- package), so the server can't auto-detect the config. Point it at the CSS
    -- entry per project. v3 projects (direct tailwind.config.js) auto-detect.
    before_init = function(_, config)
        local root = config.root_dir
        if not root then
            return
        end
        local v4_entry = {
            ["it%-dashboard"] = "libs/shared/styles/src/tailwind.css",
            ["plataforma"] = "tailwind-theme.preset.css",
        }
        for name, entry in pairs(v4_entry) do
            if root:find("/" .. name .. "/") or root:find("/" .. name .. "$") then
                config.settings.tailwindCSS.experimental.configFile = { [entry] = "**" }
                break
            end
        end
    end,
}
