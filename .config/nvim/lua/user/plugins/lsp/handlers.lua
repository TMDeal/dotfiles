local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config({
        virtual_text = false, -- Do not show inline error messages
        signs = {
            active = signs -- Use my custom signs for diagnostic messages
        },
        update_in_insert = false -- Do not bother me in insert mode
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded"
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded"
    })
end

M.on_attach = function(client, bufnr)
    require("user.keymaps.lsp").keymaps(bufnr)

    local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
    if lsp_signature_ok then
        local opts = {
            hint_enable = false,
            hint_prefix = ""
        }

        lsp_signature.on_attach(opts, bufnr)
    end

    local aerial_ok, aerial = pcall(require, "aerial")
    if aerial_ok then
        aerial.on_attach(client, bufnr)
    end

end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_lsp_ok then
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
