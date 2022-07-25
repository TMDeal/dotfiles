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

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

