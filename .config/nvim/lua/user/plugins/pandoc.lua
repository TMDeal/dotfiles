local M = {}

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

-- Had to implement the stuff below myself from pandoc.nvim
-- May consider just forking it
local mappings = {
    n = {
        ["<leader>pb"] = function()
            pandoc.render.init()
        end,

        ["<leader>p1"] = function()
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
    }
}

local opts = { noremap = true, silent = true, nowait = true }
for mode, keymap in pairs(mappings) do
    for key, _ in pairs(keymap) do
        -- This is some fuckery, key gets mangled if this is not done
        local fmt_key = key:gsub("<", "["):gsub(">", "]")
        local callback = string.format("<cmd>lua require('user.plugins.markdown').exec_keymap('%s', '%s')<CR>", mode, fmt_key)
        vim.api.nvim_set_keymap(mode, key, callback, opts)
    end
end

M.exec_keymap = function(mode, key)
    -- Undo the previous fuckery
    local fmt_key = key:gsub("%[", "<"):gsub("%]", ">")
    local fn = mappings[mode][fmt_key]
    fn()
end

return M
