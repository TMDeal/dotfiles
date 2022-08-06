local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("b", "Buffers")

-- Search buffers
keymap('bl', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], "List Buffers")
-- Find in current buffer with fuzzy search
keymap('bs', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], "Find in Current Buffer")

local close_buffers_ok, _ = pcall(require, "close_buffers")
if close_buffers_ok then
    keymap("bq", [[<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>]], "Close Current Buffer")
    keymap("bh", [[<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr.]], "Close Hidden Buffers")
    keymap("bo", [[<cmd>require('close_buffers').delete({ type = 'other', force = true })<cr>]], "Close All Other Buffers")
end

local bufferline_ok, _ = pcall(require, "bufferline")
if bufferline_ok then
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
    vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", opts)

    keymap("b[", "<cmd>BufferLineCyclePrev<cr>", "Previous buffer")
    keymap("b]", "<cmd>BufferLineCycleNext<cr>", "Next buffer")
end

