local M = {}

local bkeymap = vim.api.nvim_buf_set_keymap

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

local function lsp_keymaps(bufnr)
    local keymap = require("user.plugins.which-key").register_keymap
    local groupmap = require("user.plugins.which-key").register_group

    groupmap("l", "LSP", { buffer = bufnr })

    -- Display the documentation for item under cursor
    bkeymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

    -- Go to declaration under cursor
    keymap('D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', "Goto Declaration", { prefix = "g", buffer = bufnr })
    -- Use Trouble.nvim if it is installed
    local trouble_ok, _ = pcall(require, "trouble")
    if trouble_ok then
        -- List references to object under cursor
        keymap('r', '<cmd>TroubleToggle lsp_references<CR>', "Show References", { prefix = "g", buffer = bufnr })
        -- List references to object under cursor
        keymap('d', '<cmd>TroubleToggle lsp_definitions<CR>', "Show Definitions", { prefix = "g", buffer = bufnr })
        -- List references to object under cursor
        keymap('i', '<cmd>TroubleToggle lsp_implementations<CR>', "Show Implementation", { prefix = "g", buffer = bufnr })
    else
        -- List references to object under cursor
        keymap('r', '<cmd>lua vim.lsp.buf.references()<CR>', "Show References", { prefix = "g", buffer = bufnr })
        -- Go to definition under cursor
        keymap('d', '<Cmd>lua vim.lsp.buf.definition()<CR>', "Show definition", { prefix = "g", buffer = bufnr })
        -- Go to implementation under cursor
        keymap('i', '<cmd>lua vim.lsp.buf.implementation()<CR>', "Show Implementation", { prefix = "g", buffer = bufnr })
    end

    -- Go to next diagnostic
    keymap('d', '<cmd>lua vim.diagnostic.goto_next()<CR>', "Next Diagnostic", { prefix = "]", buffer = bufnr })
    -- Go to previous diagnostic
    keymap('d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', "Previous Diagnostic", { prefix = "[", buffer = bufnr })

    groupmap("lw", "Workspaces", { buffer = bufnr })
    -- Add a workspace folder
    keymap('lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', "Add Workspace Folder", { buffer = bufnr })
    -- Remove a workspace folder
    keymap('lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', "Remove Workspace Folder", { buffer = bufnr })
    -- List all workspaces
    keymap('lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', "List Workspace Folders", { buffer = bufnr })

    -- Display the signature of the function
    keymap('ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature Help", { buffer = bufnr })
    -- Display the type of the item under cursor
    keymap('ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', "Type Definition", { buffer = bufnr })
    -- Rename within the current buffer
    keymap('lr', '<cmd>lua vim.lsp.buf.rename()<CR>', "Rename", { buffer = bufnr })
    -- Perform code actions
    keymap('lc', '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Action", { buffer = bufnr })
    -- Open the diagnostic menu to show details
    keymap('le', '<cmd>lua vim.diagnostic.open_float()<CR>', "Show Diagnostics", { buffer = bufnr })

    -- Format buffer
    keymap('lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', "Format", { buffer = bufnr })
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)

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
