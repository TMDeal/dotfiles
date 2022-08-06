local pandoc_ok, pandoc = pcall(require, "pandoc")
if not pandoc_ok then
    return
end

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap({
    key = "p",
    name = "Pandoc"
})

keymap({
    key = "pb",
    label = "Default Build",
    cmd = function()
        pandoc.render.init()
    end
})

keymap({
    key = "p1",
    label = "Build with eisvogel Template",
    cmd = function()
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
    end
})
