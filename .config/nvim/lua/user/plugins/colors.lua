local nord_ok, nord = pcall(require, "nord")
if not nord_ok then
    return
end

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_cursorline_transparent = false
vim.g.nord_enable_sidebar_background = false
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true

nord.set()
