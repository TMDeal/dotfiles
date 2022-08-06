local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("s", "Search")

-- Grep within current project
keymap('ss', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], "Search")
keymap('sw', [[<cmd>lua require('telescope.builtin').grep_string()<cr>]], "Search under cursor")
keymap('sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], "Search in buffer")
