return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    enabled = false,
    keys = {
        { '<leader>a', function() require('harpoon'):list():add() end },
        {
            '<C-e>',
            function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
        },
        { '<leader>h', function() require('harpoon'):list():select(1) end },
        { '<leader>j', function() require('harpoon'):list():select(2) end },
        { '<leader>k', function() require('harpoon'):list():select(3) end },
        { '<leader>l', function() require('harpoon'):list():select(4) end },

        { '<C-S-N>', function() require('harpoon'):list():next() end },
        { '<C-S-P>', function() require('harpoon'):list():prev() end },
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()
    end,
}
