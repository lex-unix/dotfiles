return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
        vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set('n', "'1", function() harpoon:list():select(1) end, { nowait = true })
        vim.keymap.set('n', "'2", function() harpoon:list():select(2) end, { nowait = true })
        vim.keymap.set('n', "'3", function() harpoon:list():select(3) end, { nowait = true })
        vim.keymap.set('n', "'4", function() harpoon:list():select(4) end, { nowait = true })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
        vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)
    end,
}
