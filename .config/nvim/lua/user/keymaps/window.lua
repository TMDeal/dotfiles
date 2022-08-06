local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("w", "Windows")

keymap("ws", "<cmd>split<cr>", "Split Window Horizontally")
keymap("wv", "<cmd>vsplit<cr>", "Split Window Vertically")

keymap("wh", [[<cmd>lua require("tmux").move_left()<cr>]], "Move Left")
keymap("wj", [[<cmd>lua require("tmux").move_bottom()<cr>]], "Move Down")
keymap("wk", [[<cmd>lua require("tmux").move_top()<cr>]], "Move Up")
keymap("wl", [[<cmd>lua require("tmux").move_right()<cr>]], "Move Right")

keymap("wH", "<C-w>H", "Move Window Far Left")
keymap("wJ", "<C-w>J", "Move Window Far Down")
keymap("wK", "<C-w>K", "Move Window Far Up")
keymap("wL", "<C-w>L", "Move Window Far Right")

keymap("wf", "<C-w>o", "Focus Active Window")

keymap("w_", "<C-w>+", "Set Height")
keymap("w|", "<C-w>+", "Set Width")
keymap("w+", "<C-w>+", "Increase Height")
keymap("w-", "<C-w>-", "Decrease Height")
keymap([[w>]], [[<C-w>>]], "Increase Width")
keymap([[w<lt>]], [[<C-w><]], "Decrease Width")

keymap("w=", "<C-w>=", "Balance Windows")
