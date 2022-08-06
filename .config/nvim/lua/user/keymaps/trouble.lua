local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("t", "Trouble")
keymap("tt", ":TroubleToggle<CR>", "Toggle")
keymap("tw", ":TroubleToggle workspace_diagnostics<CR>", "Workspace Diagnostics")
keymap("td", ":TroubleToggle document_diagnostics<CR>", "Document Diagnostics")
keymap("tq", ":TroubleToggle quickfix<CR>", "quickfix")
keymap("tl", ":TroubleToggle loclist<CR>", "loclist")
