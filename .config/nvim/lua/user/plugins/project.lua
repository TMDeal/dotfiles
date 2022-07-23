local project_ok, project = pcall(require, "project_nvim")
if not project_ok then
    return
end

project.setup {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
}
