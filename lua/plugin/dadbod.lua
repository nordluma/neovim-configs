return {
    {
        'tpope/vim-dadbod',
        event = 'VeryLazy',
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod' },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'plsql' } }
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConn',
            'DBUIFindBuffer'
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end
    },
}

