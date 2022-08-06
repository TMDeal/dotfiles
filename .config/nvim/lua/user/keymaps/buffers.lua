local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "b",
    name = "Buffers"
})

-- Search buffers
keymap({
    key = 'bl',
    cmd = [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
    label = "List Buffers"
})
-- Find in current buffer with fuzzy search
keymap({
    key = 'bs',
    cmd = [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]],
    label = "Find in Current Buffer"
})

local close_buffers_ok, _ = pcall(require, "close_buffers")
if close_buffers_ok then
    keymap({
        key = "bq",
        cmd = [[<cmd>lua require('close_buffers').delete({ type = 'this' })<cr>]],
        label = "Close Current Buffer"
    })
    keymap({
        key = "bh",
        cmd = [[<cmd>lua require('close_buffers').delete({ type = 'hidden', force = true })<cr.]],
        label = "Close Hidden Buffers"
    })
    keymap({
        key = "bo",
        cmd = [[<cmd>require('close_buffers').delete({ type = 'other', force = true })<cr>]],
        label = "Close All Other Buffers"
    })
end

local bufferline_ok, _ = pcall(require, "bufferline")
if bufferline_ok then
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", opts)
    vim.api.nvim_set_keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", opts)

    keymap({
        key = "b[",
        cmd = "<cmd>BufferLineCyclePrev<cr>",
        label = "Previous buffer"
    })
    keymap({
        key = "b]",
        cmd = "<cmd>BufferLineCycleNext<cr>",
        label = "Next buffer"
    })
end

