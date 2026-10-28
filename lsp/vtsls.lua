return {
    cmd = { 'vtsls', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
    },
    root_markers = {
        'tsconfig.json',
        'package.json',
        'jsconfig.json',
        '.git',
    },
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
                maxInlayHintLength = 30,
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
            -- Vue 3 hybrid mode: let vtsls handle TypeScript inside .vue files
            -- via the Vue TS plugin, while vue_ls handles the template/SFC.
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.stdpath('data')
                            .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
        typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
        },
    },
}
