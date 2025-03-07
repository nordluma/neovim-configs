return {
    {
        'theprimeagen/harpoon',
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            local set_keymap = vim.keymap.set

            set_keymap("n", "<leader>a", mark.add_file)
            set_keymap("n", "<C-e>", ui.toggle_quick_menu)
            set_keymap("n", "<C-h>", function() ui.nav_file(1) end)
            set_keymap("n", "<C-t>", function() ui.nav_file(2) end)
            set_keymap("n", "<C-n>", function() ui.nav_file(3) end)
            set_keymap("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },
}
