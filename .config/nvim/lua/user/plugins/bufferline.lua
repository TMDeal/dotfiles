local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
    return
end

local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
