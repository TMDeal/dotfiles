local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
    return
end

local left_separator = ''
local right_separator = ''
local sub_left_separator = ''
local sub_right_separator = ''

function env_cleanup(venv)
    if string.find(venv, "/") then
        local final_venv = venv
        local dirs = {}
        for w in venv:gmatch "([^/]+)" do
            dirs[#dirs+1] = w
        end
        venv = dirs[#dirs+1-2]
    end
    return venv
end

local python_env = {
    function()
        if vim.bo.filetype == "python" then
            local venv = os.getenv "VIRTUAL_ENV"
            if venv then
                local icons = require "nvim-web-devicons"
                local py_icon, _ = icons.get_icon ".py"
                return string.format(py_icon .. " %s", env_cleanup(venv))
            end
        end
        return ""
    end,
    color = {
        fg = "#a3be8c",
        bg = "#434c5e"
    },
    cond = function()
        local window_width_limit = 100
        return vim.o.columns > window_width_limit
    end,
}

lualine.setup {
    options = {
        theme = 'nord',
        icons_enabled = true,
        component_separators = { left = sub_left_separator, right = sub_right_separator},
        section_separators = { left = left_separator, right = right_separator},
        globalstatus = true,
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
            python_env,
            'diff',
            {
                'diagnostics',
                symbols = {
                    error = " ",
                    warn = " ",
                    info = " ",
                    hint = " ",
                }
            }
        },
        lualine_c = {
            'filename',
            {
                "aerial",

                -- The separator to be used to separate symbols in status line.
                -- sep = ' ' .. sub_left_separator .. ' ',

                -- The number of symbols to render top-down. In order to render only 'N' last
                -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                -- be used in order to render only current symbol.
                depth = -1,

                -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                -- a single icon that represents the kind of current symbol is rendered at
                -- the beginning of status line.
                dense = true,

                -- The separator to be used to separate symbols in dense mode.
                dense_sep = '.',
            },
        },
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },

    extensions = {
        "nvim-tree",
        "toggleterm",
        "quickfix"
    }
}
