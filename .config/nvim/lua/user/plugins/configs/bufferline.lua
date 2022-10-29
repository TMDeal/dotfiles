local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
    return
end

bufferline.setup {
    options = {
        numbers = "none",
        sort_by = "id",

        indicator = {
            icon = '▎',
            style = 'icon'
        },

        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_buffer_default_icon = true,

        separator_style = "thin",

        diagnostics = "nvim_lsp",
        diagnostics_indicator = nil,

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }
    },
}
