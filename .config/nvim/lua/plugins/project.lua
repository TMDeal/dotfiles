return {
  "ahmedkhalf/project.nvim",
  opts = {
    manual_mode = false,
    detection_methods = { "pattern", "lsp" },
    patterns = {
      ".git",
      "venv",
      ".venv",
      "uv.lock",
      "poetry.lock",
      "Makefile",
      "package.json",
      ".projectroot",
      "go.mod",
      "mix.exs",
      "mix.lock",
    },
  },
}
