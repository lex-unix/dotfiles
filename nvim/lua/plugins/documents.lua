local function mason_bin(name) return vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'bin', name) end

return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function() vim.fn['mkdp#util#install']() end,
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        dependencies = { 'mason-org/mason.nvim' },
        opts = {
            dependencies_bin = {
                tinymist = mason_bin('tinymist'),
                websocat = nil,
            },
        },
    },
}
