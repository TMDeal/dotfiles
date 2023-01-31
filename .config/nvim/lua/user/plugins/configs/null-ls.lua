local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.diagnostics.flake8,

        null_ls.builtins.diagnostics.djlint
    }
}
