local M = {}

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

M.on_attach = function(bufnr)
    local opts = {}

    opts = { buffer = bufnr }
    groupmap({
        key = "a",
        name = "Aerial"
    })

    keymap({
        key = "aa",
        cmd = "<cmd>AerialToggle<cr>",
        label = "Sidebar"
    })

    -- Interact with aerial using telescope
    keymap({
        key = 'at',
        cmd = [[<cmd>:lua require('telescope').extensions.aerial.aerial(require('telescope.themes').get_dropdown({}))<cr>]],
        label = "Telescope"
    })

    opts = { prefix = "]", buffer = bufnr }
    keymap({
        key = "a",
        cmd = "<cmd>AerialNext<cr>",
        label = "Aerial Next Symbol",
        opts = opts
    })

    keymap({
        key = "A",
        cmd = "<cmd>AerialNextUp<cr>",
        label = "Aerial Next Tree",
        opts = opts
    })

    opts = { prefix = "[", buffer = bufnr }
    keymap({
        key = "a",
        cmd = "<cmd>AerialPrev<cr>",
        label = "Aerial Previous Symbol",
        opts = opts
    })

    keymap({
        key = "A",
        cmd = "<cmd>AerialPrevUp<cr>",
        label = "Aerial Previous Tree",
        opts = opts
    })
end

return M
