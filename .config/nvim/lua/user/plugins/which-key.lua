local M = {}

local which_key_ok, wk = pcall(require, "which-key")
if not which_key_ok then
    return
end

wk.setup {
    plugins = {
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },

    key_labels = {
        ["<space>"] = "SPC",
        ["<leader>"] = "SPC"
    },

    triggers = { "<leader>", "`", "\"" }, -- input triggers

    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
}

wk.register({
    ["`"] = "Open Terminal",

    ["-"] = "Split Window Horizontally",
    ["\\"] = "Split Window Vertically",

    g = "Lazygit",

    n = {
        name = "NvimTree",

        t = "Toggle NvimTree",
        f = "Focus NvimTree",
        c = "Collapse NvimTree"
    },

    p = {
        name = "Pandoc",

        b = "Default Build",
        ["1"] = "Build with eisvogel template",
    },

    q = "Close current buffer",

    t = {
        name = "Telescope",

        f = "Find Files",
        ["<space>"] = "List Buffers",
        l = "Find in Current Buffer",
        t = "Tags",
        o = "Open Old Files",
        g = "Grep",
        G = {
            name = "Git",
            c = "Git Commits",
            b = "Git Branches",
            s = "Git Status",
        },
        p = "Projects"
    },

    T = {
        name = "Markdown Table Mode",

        m = "Toggle",
        t = "Tableize Selection",
        T = "Tableize Selection with Delimeter",
        r = "Realign Columns",
        ["?"] = "Echo Cell Representation",
        d = {
            name = "Delete",
            d = "Delete Row",
            c = "Delete Column"
        },
        i = {
            name = "Insert",
            C = "Insert Column Before",
            c = "Insert Column After"
        },
        f = {
            name = "Formulas",
            a = "Add Formula",
            e = "Evaluate Formula"
        },
        s = "Sort Column"
    },

    w = {
        name = "Vimwiki",

        w = "Open Wiki",
        t = "Open Wiki in New Tab",
        s = "List and Select Available Wikis",
        i = "Open Diary",

        ["<leader>"] = {
            name = "Diary",

            w = "Open Diary for Today",
            t = "Open Diary for Today in New Tab",
            y = "Open Diary for Yesterday",
            m = "Open Diary for Tomorrow",
        }
    }

}, { prefix = "<leader>" })

M.register_lsp = function(bufnr)
    wk.register({
        l = {
            name = "LSP",
            w = {
                name = "Workspaces",
                a = "Add Workspace Folder",
                r = "Remove Workspace Folder",
                l = "List Workspace Folders"
            },
            s = "Signature Help",
            d = "Type Definition",
            r = "Rename",
            c = "Code Action",
            e = "Show Diagnostics Popup",
            q = "Set Loclist",
            f = "Format File"
        }
    }, { prefix = "<leader>", buffer = bufnr })
end

M.register_vimwiki = function()
    wk.register({
        w = {
            name = "Vimwiki",

            c = "Colorize Line/Selection",
            n = "Goto or Create New Page",
            d = "Delete Current Page",
            r = "Rename Current Page",

            h = {
                name = "HTML",

                h = "Convert Current Page",
                b = "Convert and Browse Current Page"
            },

            ["<leader>"] = {
                name = "Diary",

                i = "Update Diary Section"
            }
        }
    }, { prefix = "<leader>", buffer = 0 }) 
end

return M
