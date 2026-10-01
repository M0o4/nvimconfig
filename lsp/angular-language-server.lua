local function probe_dir(root_dir)
    local project_root = vim.fs.dirname(
        vim.fs.find('node_modules', { path = root_dir, upward = true })[1]
    )
    return project_root and (project_root .. '/node_modules') or ''
end

return {
    cmd = function(dispatchers, config)
        local probe = probe_dir(config.root_dir)
        local cmd = {
            'ngserver',
            '--stdio',
            '--tsProbeLocations', probe,
            '--ngProbeLocations', probe,
        }
        return vim.lsp.rpc.start(cmd, dispatchers)
    end,
    filetypes = {
        'typescript',
        'html',
        'htmlangular',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = {
        'angular.json',
        'nx.json',
        'project.json',
        '.git',
    },
}
