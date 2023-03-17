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

local lua_ls = {
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

local pyright = {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = 'off'
            }
        }
    }
}

local jsonls = {
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
}

local yamlls = {
    settings = {
        yaml = {
            schemas = require('schemastore').yaml.schemas(),
        },
    },
}

local html = {
    filetypes = { "html", "htmldjango" }
}

local tailwindcss = {
    init_options = { userLanguages = { htmldjango = "html" } }
}

mason.setup {
    ensure_installed = {}
}

mason.setup_handlers {
    function(server)
        lspconfig[server].setup(default_opts)
    end,

    ["lua_ls"] = function()
        local opts = vim.tbl_deep_extend("force", lua_ls, default_opts)
        lspconfig.lua_ls.setup(opts)
    end,

    ["html"] = function()
        local opts = vim.tbl_deep_extend("force", html, default_opts)
        lspconfig.html.setup(opts)
    end,

    ["tailwindcss"] = function()
        local opts = vim.tbl_deep_extend("force", tailwindcss, default_opts)
        lspconfig.tailwindcss.setup(opts)
    end,

    ["pyright"] = function()
        local opts = vim.tbl_deep_extend("force", pyright, default_opts)
        lspconfig.pyright.setup(opts)
    end,

    ["jsonls"] = function()
        local opts = vim.tbl_deep_extend("force", jsonls, default_opts)
        lspconfig.jsonls.setup(opts)
    end,

    ["yamlls"] = function()
        local opts = vim.tbl_deep_extend("force", yamlls, default_opts)
        lspconfig.yamlls.setup(opts)
    end
}

require("user.plugins.configs.lsp.handlers").setup()
