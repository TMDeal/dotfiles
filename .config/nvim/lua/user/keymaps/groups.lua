local M = {}

local cmds = require("user.plugins.commands")
local telescope = cmds.telescope
local pandoc = cmds.pandoc

local c = function(c)
    return "<cmd>" .. c .. "<cr>"
end

local general = {
    ["Y"] = { "y$", "Yank Until End of Line" },

    ["<leader>"] = {
        q = { c[[ wqa! ]], "Save and Quit (no prompt)" },
        p = { telescope.projects, "Projects" },
        N = { telescope.notifications, "Notifications" },
        y = { telescope.neoclip, "Neoclip" },
        m = { telescope.macroscope, "Macros - (q)" },
        S = { c[[ setlocal spell! ]], "Toggle Spellcheck" },
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

local buffer = {
    ["<s-h>"] = { c[[ BufferLineCyclePrev ]], "Previous Buffer" },
    ["<s-l>"] = { c[[ BufferLineCycleNext ]], "Next Buffer" },

    ["<leader>b"] = {
        name = "Buffer",

        l = { telescope.buffers, "List Buffers" },
        s = { telescope.buffer_find, "Find in Current Buffer" },
        q = { cmds.close_buffer, "Close Current Buffer" },
        h = { cmds.close_hidden_buffers, "Close Hidden Buffers" },
        o = { cmds.close_other_buffers, "Close All Other Buffers" },
        ["["] = { c[[ BufferLineCyclePrev ]], "Previous Buffer" },
        ["]"] = { c[[ BufferLineCycleNext ]], "Next Buffer" }
    }
}

local file = {
    ["<leader>f"] = {
        name = "File",

        f = { telescope.files, "Find Files" },
        r = { telescope.mru, "Recently Used Files" },
        c = { c[[ e $MYVIMRC ]], "Edit vimrc" },
        R = { c[[ SudaRead ]], "Re-open With Sudo" },
        W = { c[[ SudaWrite ]], "Write With Sudo" },
        w = { c[[ w ]], "Save File" }
    },
}

local git = {
    ["<leader>g"] = {
        name = "Git",

        c = { telescope.git_commits, "Commits" },
        B = { telescope.git_branches, "Branches" },
        s = { telescope.git_status, "Status" },
        l = { cmds.lazygit, "Lazygit" },
        m = { c[[ Neogit kind=replace ]], "Neogit" },

        b = {
            name = "Git Blame",

            b = { c[[ GitBlameToggle ]], "Toggle Git Blame" },
            c = { c[[ GitBlameCopyCommitURL ]], "Copy Commit URL" },
            o = { c[[ GitBlameOpenCommitURl ]], "Open Commit URL" },
            h = { c[[ GitBlameCopySHA ]], "Copy Commit SHA" }
        }
    },
}

local nvim_tree = {
    ["<leader>n"] = {
        name = "NvimTree",

        t = { c[[ NvimTreeToggle ]], "Toggle" },
        f = { c[[ NvimTreeFocus ]], "Focus" },
        c = { c[[ NvimTreeCollapse ]], "Collapse" }
    },
}

local pandoc = {
    ["<leader>P"] = {
        name = "Pandoc",

        b = { pandoc.default_build, "Default Build" },
        ["1"] = { pandoc.build_one, "Build With 'eisvogel' Template" }
    },
}

local search = {
    ["<leader>s"] = {
        name = "Search",

        s = { telescope.grep, "Search" },
        w = { telescope.grep_string, "Search Under Cursor" },
        b = { telescope.buffer_find, "Search in Buffer" },
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
    buffer,
    file,
    git,
    nvim_tree,
    pandoc,
    search,
    trouble,
    window
}

M.aerial = {
    ["<leader>a"] = {
        name = "Aerial",

        a = { c[[ AerialToggle ]], "Sidebar" },
        t = { telescope.aerial, "Telescope" }
    },

    ["["] = {
        a = { c[[ AerialPrev ]], "Previous Symbol" },
        A = { c[[ AerialPrevUp ]], "Previous Tree" }
    },

    ["]"] = {
        a = { c[[ AerialNext ]], "Next Symbol" },
        A = { c[[ AerialNextUp ]], "Next Tree" }
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
            l = { c[[ lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) ]], "List Workspace Folders" }
        },

        s = { vim.lsp.buf.signature_help, "Signature Help" },
        d = { vim.lsp.buf.type_definition, "Type Definition" },
        r = { vim.lsp.buf.rename, "Rename" },
        a = { vim.lsp.buf.code_action, "Code Action" },
        e = { vim.diagnostic.open_float, "Show Diagnostics" },
        f = { vim.lsp.buf.formatting, "Format" }
    },

    ["g"] = {
        D = { vim.lsp.buf.declaration, "Goto Declaration" },
        d = { vim.lsp.buf.definition, "Goto Definition" },
        r = { c[[ TroubleToggle lsp_references ]], "Show References" },
        i = { c[[ TroubleToggle lsp_implementations ]], "Show Implementations" }
    },

    ["["] = {
        d = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
    },

    ["]"] = {
        d = { vim.diagnostic.goto_next, "Next Diagnostic" }
    }
}

return M
