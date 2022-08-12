local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    return
end

--[[ local nvim_lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer") ]]
--[[ if not nvim_lsp_installer_ok then ]]
--[[     return ]]
--[[ end ]]

local mason_ok, mason = pcall(require, "mason-lspconfig")
if not mason_ok then
    return
end

mason.setup {}

local servers = mason.get_installed_servers()

-- Add necessary options for each installed server
for _, server in pairs(servers) do
    local opts = {
        on_attach = require("user.plugins.lsp.handlers").on_attach,
        capabilities = require("user.plugins.lsp.handlers").capabilities
    }

    -- Try to load any server specific options from the settings module
    -- Trys to load a module with the same name as the server
    local ok, extra = pcall(require, "user.plugins.lsp.settings." .. server)
    if ok then
        opts = vim.tbl_deep_extend("force", extra, opts)
    end

    lspconfig[server].setup(opts)
end

require("user.plugins.lsp.handlers").setup()
