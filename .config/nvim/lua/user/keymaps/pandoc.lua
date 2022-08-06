local pandoc_ok, pandoc = pcall(require, "pandoc")
if not pandoc_ok then
    return
end

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("p", "Pandoc")

keymap("pb", function()
    pandoc.render.init()
end, "Default Build")

keymap("p1", function()
    local input = vim.api.nvim_buf_get_name(0)

    pandoc.render.build {
        input = input,
        args = {
            { "--standalone" },
            { "--template", "eisvogel" },
            { "--listings" }
        },
        output = "report.pdf"
    }
end, "Build with eisvogel Template")
