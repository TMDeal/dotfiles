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
        lualine_c = {
            'filename',
            {
                "aerial",

                -- The separator to be used to separate symbols in status line.
                sep = '  ',

                -- The number of symbols to render top-down. In order to render only 'N' last
                -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                -- be used in order to render only current symbol.
                depth = nil,

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
