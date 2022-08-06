local M = {}

local bkeymap = vim.api.nvim_buf_set_keymap
local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

M.keymaps = function(bufnr)
    groupmap({
        key = "l",
        name = "LSP",
        opts = { buffer = bufnr }
    })

    -- Display the documentation for item under cursor
    bkeymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

    -- Go to declaration under cursor
    keymap({
        key = 'D',
        cmd = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
        label = "Goto Declaration",
        opts = { prefix = "g", buffer = bufnr }
    })
    -- Use Trouble.nvim if it is installed
    local trouble_ok, _ = pcall(require, "trouble")
    if trouble_ok then
        -- List references to object under cursor
        keymap({
            key = 'r',
            cmd = '<cmd>TroubleToggle lsp_references<CR>',
            label = "Show References",
            opts = { prefix = "g", buffer = bufnr }
        })
        -- List references to object under cursor
        -- Trouble version does not currently work very well, wait till this gets fixed
        -- keymap({
        --     key = 'd',
        --     cmd = '<cmd>TroubleToggle lsp_definitions<CR>',
        --     label = "Show Definitions",
        --     opts = { prefix = "g", buffer = bufnr }
        -- })
        keymap({
            key = 'd',
            cmd = '<Cmd>lua vim.lsp.buf.definition()<CR>',
            label = "Show definition",
            opts = { prefix = "g", buffer = bufnr }
        })
        -- List references to object under cursor
        keymap({
            key = 'i',
            cmd = '<cmd>TroubleToggle lsp_implementations<CR>',
            label = "Show Implementation",
            opts = { prefix = "g", buffer = bufnr }
        })
    else
        -- List references to object under cursor
        keymap({
            key = 'r',
            cmd = '<cmd>lua vim.lsp.buf.references()<CR>',
            label = "Show References",
            opts = { prefix = "g", buffer = bufnr }
        })
        -- Go to definition under cursor
        keymap({
            key = 'd',
            cmd = '<Cmd>lua vim.lsp.buf.definition()<CR>',
            label = "Show definition",
            opts = { prefix = "g", buffer = bufnr }
        })
        -- Go to implementation under cursor
        keymap({
            key = 'i',
            cmd = '<cmd>lua vim.lsp.buf.implementation()<CR>',
            label = "Show Implementation",
            opts = { prefix = "g", buffer = bufnr }
        })
    end

    -- Go to next diagnostic
    keymap({
        key = 'd',
        cmd = '<cmd>lua vim.diagnostic.goto_next()<CR>',
        label = "Next Diagnostic",
        opts = { prefix = "]", buffer = bufnr }
    })
    -- Go to previous diagnostic
    keymap({
        key = 'd',
        cmd = '<cmd>lua vim.diagnostic.goto_prev()<CR>',
        label = "Previous Diagnostic",
        opts = { prefix = "[", buffer = bufnr }
    })

    groupmap({
        key = "lw",
        name = "Workspaces",
        opts = { buffer = bufnr }
    })
    -- Add a workspace folder
    keymap({
        key = 'lwa',
        cmd = '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
        label = "Add Workspace Folder",
        opts = { buffer = bufnr }
    })
    -- Remove a workspace folder
    keymap({
        key = 'lwr',
        cmd = '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
        label = "Remove Workspace Folder",
        opts = { buffer = bufnr }
    })
    -- List all workspaces
    keymap({
        key = 'lwl',
        cmd = '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        label = "List Workspace Folders",
        opts = { buffer = bufnr }
    })

    -- Display the signature of the function
    keymap({
        key = 'ls',
        cmd = '<cmd>lua vim.lsp.buf.signature_help()<CR>',
        label = "Signature Help",
        opts = { buffer = bufnr }
    })
    -- Display the type of the item under cursor
    keymap({
        key = 'ld',
        cmd = '<cmd>lua vim.lsp.buf.type_definition()<CR>',
        label = "Type Definition",
        opts = { buffer = bufnr }
    })
    -- Rename within the current buffer
    keymap({
        key = 'lr',
        cmd = '<cmd>lua vim.lsp.buf.rename()<CR>',
        label = "Rename",
        opts = { buffer = bufnr }
    })
    -- Perform code actions
    keymap({
        key = 'la',
        cmd = '<cmd>lua vim.lsp.buf.code_action()<CR>',
        label = "Code Action",
        opts = { buffer = bufnr }
    })
    -- Open the diagnostic menu to show details
    keymap({
        key = 'le',
        cmd = '<cmd>lua vim.diagnostic.open_float()<CR>',
        label = "Show Diagnostics",
        opts = { buffer = bufnr }
    })

    -- Format buffer
    keymap({
        key = 'lf',
        cmd = '<cmd>lua vim.lsp.buf.formatting()<CR>',
        label = "Format",
        opts = { buffer = bufnr }
    })
end

return M
