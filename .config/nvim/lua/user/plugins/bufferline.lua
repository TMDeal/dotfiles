local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
    return
end

bufferline.setup {
    options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        },
        sort_by = "id"
    }
}
