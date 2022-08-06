local M = {}

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

M.on_attach = function(bufnr)
    local opts = {}

    opts = { buffer = bufnr }
    groupmap("a", "Aerial")
    keymap('aa', "<cmd>AerialToggle<cr>", "Sidebar")
    -- Interact with aerial using telescope
    keymap('at', [[<cmd>:lua require('telescope').extensions.aerial.aerial(require('telescope.themes').get_dropdown({}))<cr>]], "Telescope")

    opts = { prefix = "]", buffer = bufnr }
    keymap("a", "<cmd>AerialNext<cr>", "Aerial Next Symbol", opts)
    keymap("A", "<cmd>AerialNextUp<cr>", "Aerial Next Tree", opts)

    opts = { prefix = "[", buffer = bufnr }
    keymap("a", "<cmd>AerialPrev<cr>", "Aerial Previous Symbol", opts)
    keymap("A", "<cmd>AerialPrevUp<cr>", "Aerial Previous Tree", opts)
end

return M
