local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "f",
    name = "Files"
})

-- Search files
keymap({
    key = "ff",
    cmd = [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    label = "Find Files"
})
-- Search recently used files
keymap({
    key = "fr",
    cmd = [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],
    label = "Recently Used Files"
})

-- Open neovim init.lua
keymap({
    key = "fc",
    cmd = "<cmd>e $MYVIMRC<cr>",
    label = "Edit vimrc"
})

-- Sudo read this file
keymap({
    key = "fR",
    cmd = "<cmd>SudaRead<cr>",
    label = "Re-open with sudo"
})
-- Sudo write this file
keymap({
    key = "fW",
    cmd = "<cmd>SudaWrite<cr>",
    label = "Write with sudo"
})

-- Save file
keymap({
    key = "fw",
    cmd = "<cmd>w<cr>",
    label = "Save file"
})
