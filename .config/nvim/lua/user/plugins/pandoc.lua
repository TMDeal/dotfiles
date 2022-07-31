vim.g.table_mode_map_prefix = "<leader>T"
vim.g.table_mode_tableize_d_map = "<leader>TT"

vim.g["g:pandoc#syntax#conceal#urls"] = 1

local pandoc_ok, pandoc = pcall(require, "pandoc")
if not pandoc_ok then
    return
end

pandoc.setup {
    commands = {
        enable = true,
        extended = false
    },

    default = {
        output = "%s.pdf",
        args = {
            { "--standalone" }
        }
    },

    equation = {
        border = "rounded"
    },
}

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

local which_key_ok, wk = pcall(require, "which-key")
if not which_key_ok then
    return
end

wk.register({
    T = {
        name = "Markdown Table Mode",

        m = "Toggle",
        t = "Tableize Selection",
        T = "Tableize Selection with Delimeter",
        r = "Realign Columns",
        ["?"] = "Echo Cell Representation",
        d = {
            name = "Delete",
            d = "Delete Row",
            c = "Delete Column"
        },
        i = {
            name = "Insert",
            C = "Insert Column Before",
            c = "Insert Column After"
        },
        f = {
            name = "Formulas",
            a = "Add Formula",
            e = "Evaluate Formula"
        },
        s = "Sort Column"
    },
}, { prefix = "<leader>" })
