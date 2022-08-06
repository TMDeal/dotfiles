local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "n",
    name = "NvimTree"
})

keymap({
    key = "nt",
    cmd = ":NvimTreeToggle<CR>",
    label = "Toggle NvimTree"
})
keymap({
    key = "nf",
    cmd = ":NvimTreeFocus<CR>",
    label = "Focus NvimTree"
})
keymap({
    key = "nc",
    cmd = ":NvimTreeCollapse<CR>",
    label = "Collapse NvimTree"
})

