local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "w",
    name = "Windows"
})

-- Split windows
keymap({
    key = "ws",
    cmd = "<cmd>split<cr>",
    label = "Split Window Horizontally"
})
keymap({
    key = "wv",
    cmd = "<cmd>vsplit<cr>",
    label = "Split Window Vertically"
})

-- Move around windows
keymap({
    key = "wh",
    cmd = [[<cmd>lua require("tmux").move_left()<cr>]],
    label = "Move Left"
})
keymap({
    key = "wj",
    cmd = [[<cmd>lua require("tmux").move_bottom()<cr>]],
    label = "Move Down"
})
keymap({
    key = "wk",
    cmd = [[<cmd>lua require("tmux").move_top()<cr>]],
    label = "Move Up"
})
keymap({
    key = "wl",
    cmd = [[<cmd>lua require("tmux").move_right()<cr>]],
    label = "Move Right"
})

-- Move windows
keymap({
    key = "wH",
    cmd = "<C-w>H",
    label = "Move Window Far Left"
})
keymap({
    key = "wJ",
    cmd = "<C-w>J",
    label = "Move Window Far Down"
})
keymap({
    key = "wK",
    cmd = "<C-w>K",
    label = "Move Window Far Up"
})
keymap({
    key = "wL",
    cmd = "<C-w>L",
    label = "Move Window Far Right"
})

-- Make active window the only visible window
keymap({
    key = "wf",
    cmd = "<C-w>o",
    label = "Focus Active Window"
})

-- Manipulate window size
keymap({
    key = "w_",
    cmd = "<C-w>+",
    label = "Set Height"
})
keymap({
    key = "w|",
    cmd = "<C-w>+",
    label = "Set Width"
})
keymap({
    key = "w+",
    cmd = "<C-w>+",
    label = "Increase Height"
})
keymap({
    key = "w-",
    cmd = "<C-w>-",
    label = "Decrease Height"
})
keymap({
    key = [[w>]],
    cmd = [[<C-w>>]],
    label = "Increase Width"
})
keymap({
    key = [[w<lt>]],
    cmd = [[<C-w><]],
    label = "Decrease Width"
})
keymap({
    key = "w=",
    cmd = "<C-w>=",
    label = "Balance Windows"
})
