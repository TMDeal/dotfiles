return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
      reportMissingModuleSource = "none",
      reportMissingImports = "none",
      reportUndefinedVariable = "none",
    },
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}
