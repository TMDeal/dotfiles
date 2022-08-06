local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("n", "NvimTree")
keymap("nt", ":NvimTreeToggle<CR>", "Toggle NvimTree")
keymap("nf", ":NvimTreeFocus<CR>", "Focus NvimTree")
keymap("nc", ":NvimTreeCollapse<CR>", "Collapse NvimTree")

