return {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  on_attach = function(client, _)
    client.server_capabilities.codeActionProvider = false
  end,

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
