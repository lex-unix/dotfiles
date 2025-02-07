return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    lazy = true,
    event = 'InsertEnter',
    opts = {
        keymap = {
            preset = 'default',
            ['<C-c>'] = { 'show', 'show_documentation', 'hide', 'fallback' },
            ['<C-k>'] = { 'snippet_forward', 'fallback' },
            ['<C-j>'] = { 'snippet_backward', 'fallback' },
            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        signature = { enabled = true },
        sources = {
            cmdline = {},
            default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod' },
            providers = {
                dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
            },
        },
    },
    opts_extend = { 'sources.default' },
}
