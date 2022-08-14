local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
    return
end

bufferline.setup {
    options = {
        numbers = "none",

        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,

        diagnostics = "nvim_lsp",
        diagnostics_indicator = nil,

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        },
        sort_by = "id"
    },
}
