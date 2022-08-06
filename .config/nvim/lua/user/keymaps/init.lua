local keymap = require("user.plugins.which-key").register_keymap
local opts = { noremap = true, silent = true }

-- Map leader key to SPC
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Unmap these for my sanity
vim.api.nvim_set_keymap("i", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("v", "<F1>", "<nop>", opts)
vim.api.nvim_set_keymap("n", "Q", "<nop>", opts)
vim.api.nvim_set_keymap("n", "q:", "<nop>", opts)

-- Indent in visual mode and maintain cursor position
vim.api.nvim_set_keymap("v", ">", "md>`d:delm d<cr>gv", opts)
vim.api.nvim_set_keymap("v", "<", "md<`d:delm d<cr>gv", opts)

-- Keep search matches in the middle of the window
vim.api.nvim_set_keymap("n", "n", "nzzzv", opts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", opts)

-- Remove highlighting
vim.api.nvim_set_keymap("n", "\\", ":nohl<cr>", opts)

--Remap for dealing with word wrap
local expr_opts = { noremap = true, expr = true, silent = true }
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Y yank until the end of line
vim.api.nvim_set_keymap("n", "Y", "y$", opts)

keymap("q", ":wqa!<CR>", "Save and Quit (no prompt)")

-- Loclist/QuickFix mappings
keymap("q", ":cnext<CR>", "Next Quickfix Item", { prefix = "]" })
keymap("q", ":cprev<CR>", "Previous Quickfix Item", { prefix = "[" })
keymap("l", ":lnext<CR>", "Next LocList Item", { prefix = "]" })
keymap("l", ":lprev<CR>", "Previous LocList Item", { prefix = "[" })

local project_ok, _ = pcall(require, "project_nvim")
if project_ok then
    keymap('p', [[<cmd>lua require('telescope').extensions.projects.projects()<cr>]], "Projects")
end

-- Load nvim-notify extension
local notify_ok, _ = pcall(require, "notify")
if notify_ok then
    keymap('N', [[<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({}))<cr>]], "Notifications")
end

-- load nvim-neoclip extension
local neoclip_ok, _ = pcall(require, "neoclip")
if neoclip_ok then
    keymap('y', [[<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({}))<cr>]], "Neoclip")
    keymap('m', [[<cmd>:lua require('telescope').extensions.macroscope.default(require('telescope.themes').get_dropdown({}))<cr>]], "Macros - (q)")
end

require("user.keymaps.files")
require("user.keymaps.buffers")
require("user.keymaps.search")
require("user.keymaps.window")
require("user.keymaps.git")
require("user.keymaps.nvim-tree")
require("user.keymaps.trouble")
require("user.keymaps.pandoc")
