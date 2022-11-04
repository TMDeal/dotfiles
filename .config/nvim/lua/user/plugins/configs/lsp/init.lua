local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    return
end

local mason_ok, mason = pcall(require, "mason-lspconfig")
if not mason_ok then
    return
end

local default_opts = {
    on_attach = require("user.plugins.configs.lsp.handlers").on_attach,
    capabilities = require("user.plugins.configs.lsp.handlers").capabilities
}

local sumneko_lua = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true
                }
            }
        }
    }
}

mason.setup {
    ensure_installed = {}
}

mason.setup_handlers {
    function(server)
        lspconfig[server].setup(default_opts)
    end,

    ["sumneko_lua"] = function()
        local opts = vim.tbl_deep_extend("force", sumneko_lua, default_opts) 
        lspconfig.sumneko_lua.setup(opts)
    end
}

require("user.plugins.configs.lsp.handlers").setup()
