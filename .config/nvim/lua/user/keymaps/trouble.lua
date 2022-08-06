local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "t",
    name = "Trouble"
})

keymap({
    key = "tt",
    cmd = ":TroubleToggle<CR>",
    label = "Toggle"
})
keymap({
    key = "tw",
    cmd = ":TroubleToggle workspace_diagnostics<CR>",
    label = "Workspace Diagnostics"
})
keymap({
    key = "td",
    cmd = ":TroubleToggle document_diagnostics<CR>",
    label = "Document Diagnostics"
})
keymap({
    key = "tq",
    cmd = ":TroubleToggle quickfix<CR>",
    label = "quickfix"
})
keymap({
    key = "tl",
    cmd = ":TroubleToggle loclist<CR>",
    label = "loclist"
})
