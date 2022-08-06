local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "s",
    name = "Search"
})

-- Grep within current project
keymap({
    key = 'ss',
    cmd = [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    label = "Search"
})
keymap({
    key = 'sw',
    cmd = [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],
    label = "Search under cursor"
})
keymap({
    key = 'sb',
    cmd = [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],
    label = "Search in buffer"
})
