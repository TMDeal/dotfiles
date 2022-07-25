local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then
    return
end

local nvim_tree_config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not nvim_tree_config_ok then
    return
end

nvim_tree.setup {
    -- settings for Project.nvim
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    },

    disable_netrw = true,
    hijack_netrw = true,

    diagnostics = {
        enable = true,
        icons = {
            error = "X",
            warning = "!",
            hint = "*",
            info = "?"
        }
    },

    renderer = {
        group_empty = true
    },

    filters = {
        dotfiles = true
    }
}

-- Copied from https://github.com/kyazdani42/nvim-tree.lua/discussions/1115
-- Should close nvim-tree if it is the only buffer open
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("n", "[NvimTree]")
keymap("nt", ":NvimTreeToggle<CR>", "Toggle NvimTree")
keymap("nf", ":NvimTreeFocus<CR>", "Focus NvimTree")
keymap("nc", ":NvimTreeCollapse<CR>", "Collapse NvimTree")
