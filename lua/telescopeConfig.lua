local telescopeActions = require("telescope.actions")
local telescope = require('telescope')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = telescopeActions.close,
            },
        },
    },
})

