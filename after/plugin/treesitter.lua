require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the five listed parsers should always
    -- be installed
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "markdown", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI
    -- installed locally
    auto_install = true,

    autotag = {
        enable = true
    },

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same
        -- time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for
        -- indentation).
        -- Usin this option may slow down your editor, and you may see some
        -- duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    -- Textobjetcs configs
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobject
            lookahead = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select around a function" },
                ["if"] = { query = "@function.inner", desc = "Select inside a function" },
                ["ac"] = { query = "@class.outer", desc = "Select around a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inside a class" },
            },
            selection_modes = {
                ["@parameter.outer"] = "v", -- charwise
                ["@function.outer"] = "V",  -- linewise
                ["@class.outer"] = "V",     -- linewise
                -- "<c-v>" blockwise
            },
            include_surrounding_whitespace = true,
        }
    }
})

local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
treesitter_parser_config.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
}

vim.treesitter.language.register("templ", "templ")
