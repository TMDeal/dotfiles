local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("f", "Files")

-- Search files
keymap("ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]], "Find Files")
-- Search recently used files
keymap("fr", [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], "Recently Used Files")

-- Open neovim init.lua
keymap("fc", "<cmd>e $MYVIMRC<cr>", "Edit vimrc")

-- Sudo read this file
keymap("fR", "<cmd>SudaRead<cr>", "Re-open with sudo")
-- Sudo write this file
keymap("fW", "<cmd>SudaWrite<cr>", "Write with sudo")

-- Save file
keymap("fw", "<cmd>w<cr>", "Save file")
