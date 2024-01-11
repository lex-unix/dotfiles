vim.filetype.add({
    filename = {
        ['.prettierrc'] = 'yaml',
        ['.eslintrc'] = 'yaml',
        ['.env'] = 'sh',
        ['.envrc'] = 'sh',
        ['.env.production'] = 'sh',
    },
    extension = {
        mdx = 'markdown.mdx',
    },
})
