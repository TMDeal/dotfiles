local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local local_keymap = vim.api.nvim_buf_set_keymap

local remember_last_position = augroup("remember_last_position_group", { clear = true })
local yank_highlight = augroup("yank_highlight", { clear = true })
local terminal = augroup("terminal", { clear = true })
local markdown = augroup("markdown", { clear = true })

-- Remeber where the curser was when reopening a file
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

--Remap escape to leave terminal mode
autocmd("TermOpen", {
    group = terminal,
    callback = function()
        local opts = {noremap = true}
        local_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    end
})

-- Highlight on yank
autocmd("TextYankPost", {
    group = yank_highlight,
    callback = function()
        vim.highlight.on_yank()
    end
})

-- enable word wrap and spellcheck for markdown files
autocmd("FileType", {
    group = markdown,
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})

-- Treat markdown files as pandoc filetype
autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
    group = markdown,
    pattern = { "*.markdown", "*.mdown", "*.mkd", "*.mkdn", "*.mdwn", "*.md" },
    callback = function()
        vim.opt_local.filetype = "pandoc"
    end
})
