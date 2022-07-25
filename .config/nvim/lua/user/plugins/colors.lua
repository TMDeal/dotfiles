local nord_ok, nord = pcall(require, "nord")
if nord_ok then
    vim.g.nord_contrast = true
    vim.g.nord_borders = true
    vim.g.nord_disable_background = true
    vim.g.nord_cursorline_transparent = false
    vim.g.nord_enable_sidebar_background = false
    vim.g.nord_italic = true
    vim.g.nord_uniform_diff_background = true

    nord.set()
end


local colorizer_ok, colorizer = pcall(require, "colorizer")
if colorizer_ok then
    colorizer.setup {
        ["*"] = {
            RGB = true,
            RRGGBB  = true,
            names = true,
            RRGGBBAA = true,
            rgb_fn = true,
            hsl_fn = true,
            css = true,
            css_fn  = true,
            mode = "background"
        }
    }
end

