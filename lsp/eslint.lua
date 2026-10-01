return {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'html',
        'htmlangular',
    },
    -- Both legacy (.eslintrc.json) and flat (eslint.config.*) configs; the
    -- server auto-detects which style the project uses.
    root_markers = {
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.json',
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'package.json',
        '.git',
    },
    -- Full settings set so no field is `undefined` on the server side. A
    -- missing `nodePath` in particular makes the pull-diagnostics handler
    -- throw `The "path" argument must be of type string. Received undefined`.
    settings = {
        validate = 'on',
        packageManager = nil,
        useESLintClass = false,
        experimental = { useFlatConfig = false },
        codeActionOnSave = { enable = false, mode = 'all' },
        -- Formatting is handled by prettier (conform), not eslint.
        format = false,
        quiet = false,
        onIgnoredFiles = 'off',
        rulesCustomizations = {},
        run = 'onType',
        problems = { shortenToSingleLine = false },
        nodePath = '',
        workingDirectory = { mode = 'location' },
        codeAction = {
            disableRuleComment = { enable = true, location = 'separateLine' },
            showDocumentation = { enable = true },
        },
    },
    -- vscode-eslint sends these custom requests; without handlers the server
    -- can silently fail to attach.
    handlers = {
        ['eslint/openDoc'] = function(_, result)
            if result and result.url then
                vim.ui.open(result.url)
            end
            return {}
        end,
        ['eslint/confirmESLintExecution'] = function(_, result)
            if not result then
                return
            end
            return 4 -- always approve
        end,
        ['eslint/probeFailed'] = function()
            vim.notify('ESLint probe failed.', vim.log.levels.WARN)
            return {}
        end,
        ['eslint/noLibrary'] = function()
            vim.notify('Unable to find ESLint library.', vim.log.levels.WARN)
            return {}
        end,
    },
    on_attach = function(_, bufnr)
        -- :EslintFixAll applies all auto-fixable eslint problems in the buffer.
        vim.api.nvim_buf_create_user_command(bufnr, 'EslintFixAll', function()
            vim.lsp.buf.code_action({
                context = { only = { 'source.fixAll.eslint' }, diagnostics = {} },
                apply = true,
            })
        end, { desc = 'Apply all ESLint fixes' })
    end,
}
