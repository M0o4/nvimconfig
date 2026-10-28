return {
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue' },
    root_markers = {
        'vite.config.ts',
        'vite.config.js',
        'nuxt.config.ts',
        'package.json',
        '.git',
    },
    init_options = {
        typescript = {
            -- tsdk for Volar's own features; the heavy TS work is delegated to
            -- vtsls via @vue/typescript-plugin (hybrid mode).
            tsdk = vim.fn.stdpath('data')
                .. '/mason/packages/vue-language-server/node_modules/typescript/lib',
        },
    },
}
