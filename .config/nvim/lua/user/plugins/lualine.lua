local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
    return
end

lualine.setup {
    options = {
        theme = 'nord',
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        globalstatus = true,
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            'branch',
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
