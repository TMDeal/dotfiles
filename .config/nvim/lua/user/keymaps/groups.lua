local M = {}

local cmds = require("user.plugins.commands")
local telescope = cmds.telescope
local pan = cmds.pandoc
local aerial = require("aerial")

local c = function(c)
    return "<cmd>" .. c .. "<cr>"
end

local general = {
    ["Y"] = { "y$", "Yank Until End of Line" },

    ["<leader>"] = {
        q = { c[[ q ]], "Quit" },
        p = { telescope.projects, "Projects" },
        N = { telescope.notifications, "Notifications" },
        y = { telescope.neoclip, "Neoclip" },
        S = { c[[ setlocal spell! ]], "Toggle Spellcheck" },
        n = { c[[ NvimTreeToggle ]], "NvimTree" },
        W = { c[[ SudaWrite ]], "Sudo Save" },
        w = { c[[ w ]], "Save" },
        f = { telescope.files, "Files" },
    },

    ["["] = {
        l = { c[[ lprev ]], "Previous Loclist Item" },
        q = { c[[ cprev ]], "Previous Quickfix Item" }
    },

    ["]"] = {
        l = { c[[ lnext ]], "Next Loclist Item" },
        q = { c[[ cnext ]], "Next Quickfix Item" }
    }
}

local sessions = {
    ["<leader>a"] = {
        name = "Sessions",

        s = { c[[ Autosession search ]], "Search Saved Sessions" },
        w = { c[[ SaveSession ]], "Save Current Session" },
        r = { c[[ RestoreSession ]], "Restore Current Session" },
        d = { c[[ Autosession delete ]], "Delete Sessions" }
    }
}

local buffer = {
    ["<s-h>"] = { c[[ BufferLineCyclePrev ]], "Previous Buffer" },
    ["<s-l>"] = { c[[ BufferLineCycleNext ]], "Next Buffer" },

    ["<leader>b"] = {
        name = "Buffer",

        j = { c[[ BufferLinePick ]], "Jump" },
        e = { c[[ BufferLinePickClose ]], "Pick Which Buffer to Close" },
        h = { c[[ BufferLineCloseLeft ]], "Close All to the Left" },
        l = { c[[ BufferLineCloseRight ]], "Close All to the Right" },
        ["["] = { c[[ BufferLineCyclePrev ]], "Previous Buffer" },
        ["]"] = { c[[ BufferLineCycleNext ]], "Next Buffer" },

        s = { telescope.buffer_find, "Find in Current Buffer" },
        L = { telescope.buffers, "List Buffers" },
        H = { cmds.close_hidden_buffers, "Close Hidden Buffers" },
        q = { cmds.close_buffer, "Close Current Buffer" },
        o = { cmds.close_other_buffers, "Close All Other Buffers" },
    }
}

local git = {
    ["<leader>g"] = {
        name = "Git",

        c = { telescope.git_commits, "Commits" },
        B = { telescope.git_branches, "Branches" },
        s = { telescope.git_status, "Status" },
        l = { cmds.lazygit, "Lazygit" },
        b = { require("gitsigns").blame_line, "Blame" },
        r = { require ("gitsigns").reset_buffer, "Reset Buffer" },
        d = { c[[ DiffviewOpen ]], "Diff" },
    },
}

local pandoc = {
    ["<leader>P"] = {
        name = "Pandoc",

        b = { pan.default_build, "Default Build" },
        ["1"] = { pan.build_one, "Build With 'eisvogel' Template" }
    },
}

local search = {
    ["<leader>s"] = {
        name = "Search",

        r = { telescope.mru, "Recently Used Files" },
        f = { telescope.files, "Files" },
        s = { telescope.grep, "Text" },
        l = { telescope.grep_string, "Line Under Cursor" },
    },
}

local trouble = {
    ["<leader>t"] = {
        name = "Trouble",

        t = { c[[ TroubleToggle ]], "Toggle" },
        w = { c[[ TroubleToggle workspace_diagnostics ]], "Workspace Diagnostics" },
        d = { c[[ TroubleToggle document_diagnostics ]], "Document Diagnostics" },
        q = { c[[ TroubleToggle quickfix ]], "Quickfix" },
        l = { c[[ TroubleToggle loclist ]], "Loclist" }
    },
}

local window = {
    ["<leader>w"] = {
        name = "Window",

        s = { c[[ split ]], "Split Window Horizontally" },
        v = { c[[ vsplit ]], "Split Window Vertically" },

        h = { require("tmux").move_left, "Move Left" },
        j = { require("tmux").move_bottom, "Move Down" },
        k = { require("tmux").move_top, "Move Up" },
        l = { require("tmux").move_right, "Move Right" },

        H = { "<c-w>H", "Move Window Far Left" },
        J = { "<c-w>J", "Move Window Far Down" },
        K = { "<c-w>K", "Move Window Far Up" },
        L = { "<c-w>L", "Move Window Far Right" },

        f = { "<c-w>o", "Focus Active Window" },

        ["+"] = { "<c-w>+", "Increase Height" },
        ["-"] = { "<c-w>-", "Decrease Height" },
        [">"] = { "<c-w>>", "Increase Width" },
        ["<lt>"] = { "<c-w><", "Decrease Width" },

        ["="] = { "<c-w>=", "Balance Windows" }
    }
}

M.global = {
    general,
    sessions,
    buffer,
    git,
    pandoc,
    search,
    trouble,
    window
}

M.aerial = {
    ["<leader>la"] = {
        name = "Symbols",

        a = { c[[ AerialToggle ]], "Sidebar" },
        t = { telescope.aerial, "Telescope" }
    },

    ["["] = {
        a = { aerial.prev, "Previous Symbol" },
        A = { aerial.prev_up, "Previous Tree" }
    },

    ["]"] = {
        a = { aerial.next, "Next Symbol" },
        A = { aerial.next_up, "Next Tree" }
    }
}

M.lsp = {
    ["K"] = { vim.lsp.buf.hover, "LSP Hover" },

    ["<leader>l"] = {
        name = "LSP",

        w = {
            name = "Workspaces",

            a = { vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
            r = { vim.lsp.buf.remove_workspace_folder, "Remove Wokspace Folder" },
            l = { c[[ lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) ]], "List Workspace Folders" },
            s = { telescope.workspace_symbols, "Symbols" }
        },

        s = { vim.lsp.buf.signature_help, "Signature Help" },
        d = { c[[ Telescope lsp_type_definitions ]], "Type Definition" },
        r = { vim.lsp.buf.rename, "Rename" },
        A = { vim.lsp.buf.code_action, "Code Action" },
        e = { vim.diagnostic.open_float, "Show Diagnostics" },
        f = { vim.lsp.buf.format, "Format" }
    },

    ["g"] = {
        D = { vim.lsp.buf.declaration, "Goto Declaration" },
        d = { vim.lsp.buf.definition, "Goto Definition" },
        r = { c[[ Telescope lsp_references ]], "Show References" },
        i = { c[[ Telescope lsp_implementations ]], "Show Implementations" }
    },

    ["["] = {
        d = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
    },

    ["]"] = {
        d = { vim.diagnostic.goto_next, "Next Diagnostic" }
    }
}

return M
