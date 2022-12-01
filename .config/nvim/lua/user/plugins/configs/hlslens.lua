local hlslens_ok, hlslens = pcall(require, "hlslens")
if not hlslens_ok then
    return
end

hlslens.setup({
    calm_down = false
})

local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
