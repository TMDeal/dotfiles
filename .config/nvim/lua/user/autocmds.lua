local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local remember_last_position = augroup("remember_last_position_group", { clear = true })
local yank_highlight = augroup("yank_highlight", { clear = true })
local markdown = augroup("markdown", { clear = true })

-- Remember where the curser was when reopening a file
autocmd("BufReadPost", {
    group = remember_last_position,
    callback = function()
        local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
        local end_line = vim.fn.line("$")
        if row ~= 0 and row <= end_line then
            vim.api.nvim_win_set_cursor(0, {row, col})
        end
    end
})

-- Highlight on yank
autocmd("TextYankPost", {
    group = yank_highlight,
    callback = function()
        vim.highlight.on_yank()
    end
})

-- enable word wrap and spellcheck for markdown/pandoc files
autocmd("FileType", {
    group = markdown,
    pattern = { "pandoc", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.autowriteall = true
        vim.opt_local.textwidth = 85
    end
})

-- Disable statusline in dashboard
autocmd("FileType", {
    pattern = "alpha",
    callback = function()
        vim.opt.laststatus = 0
    end,
})

autocmd("BufUnload", {
    buffer = 0,
    callback = function()
        vim.opt.laststatus = 3
    end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})
