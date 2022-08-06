local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "g",
    name = "Git"
})

-- Check git commits
keymap({
    key = 'gc',
    cmd = [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],
    label = "Git Commits"
})
-- Check git branches
keymap({
    key = 'gb',
    cmd = [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],
    label = "Git Branches"
})
-- Check git status
keymap({
    key = 'gs',
    cmd = [[<cmd>lua require('telescope.builtin').git_status()<cr>]],
    label = "Git Status"
})

local toggleterm_ok, _ = pcall(require, "toggleterm")
if toggleterm_ok then
    keymap({
        key = "gl",
        cmd = require("user.plugins.toggleterm").lazygit,
        label = "Lazygit"
    })
end
