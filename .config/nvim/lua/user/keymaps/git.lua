local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("g", "Git")

-- Check git commits
keymap('gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], "Git Commits")
-- Check git branches
keymap('gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], "Git Branches")
-- Check git status
keymap('gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], "Git Status")

local toggleterm_ok, _ = pcall(require, "toggleterm")
if toggleterm_ok then
    keymap("gl", require("user.plugins.toggleterm").lazygit, "Lazygit")
end
