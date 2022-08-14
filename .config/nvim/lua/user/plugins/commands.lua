local M = {}

local telescope = {}
local pandoc = {}

telescope.projects = function()
    require('telescope').extensions.projects.projects()
end

telescope.notifications = function()
    require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({})) 
end

telescope.neoclip = function()
    require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({}))
end

telescope.macroscope = function()
    require('telescope').extensions.macroscope.default(require('telescope.themes').get_dropdown({}))
end

telescope.aerial = function()
    require('telescope').extensions.aerial.aerial(require('telescope.themes').get_dropdown({}))
end

telescope.buffers = function()
    require("telescope.builtin").buffers()
end

telescope.buffer_find = function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end

telescope.files = function()
    require("telescope.builtin").find_files()
end

telescope.mru = function()
    require("telescope.builtin").oldfiles()
end

telescope.git_commits = function()
    require("telescope.builtin").git_commits()
end

telescope.git_branches = function()
    require("telescope.builtin").git_branches()
end

telescope.git_status = function()
    require("telescope.builtin").git_status()
end

telescope.grep = function()
    require("telescope.builtin").live_grep()
end

telescope.grep_string = function()
    require("telescope.builtin").grep_string()
end

pandoc.default_build = function()
    require("pandoc").render.init()
end

pandoc.build_one = function()
    local input = vim.api.nvim_buf_get_name(0)

    require("pandoc").render.build {
        input = input,
        args = {
            { "--standalone" },
            { "--template", "eisvogel" },
            { "--listings" }
        },
        output = "report.pdf"
    }
end

M.pandoc = pandoc
M.telescope = telescope

M.close_buffer = function()
    require('close_buffers').delete({ type = 'this' })
end

M.close_hidden_buffers = function()
    require('close_buffers').delete({ type = 'hidden', force = true })
end

M.close_other_buffers = function()
    require('close_buffers').delete({ type = 'other', force = true })
end

M.lazygit = function()
    local ok, _ = pcall(require, "toggleterm")
    if not ok then
        return
    end

    local term = require("toggleterm.terminal").Terminal

    local lazygit = term:new({
        cmd = "lazygit",
        hidden = true
    })

    lazygit:toggle()
end

return M
