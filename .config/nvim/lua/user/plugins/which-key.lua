local which_key_ok, wk = pcall(require, "which-key")
if not which_key_ok then
    return
end

wk.setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode

        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },

        presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },

    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = {
        gc = "Comments"
    },

    key_labels = {
        ["<space>"] = "SPC",
        ["<leader>"] = "SPC"
    },

    -- enable this to hide mappings for which you didn't specify a label
    ignore_missing = false,

    -- automatically setup triggers
    triggers = "auto",

    -- hide mapping boilerplate
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>", "require" }
}

-- Default options for the register_keymap/register_group functions
local register_opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false
}

local function register_keymap(key, cmd, label, opts)
    local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts or {})
    local wk_keymap = { [key] = { cmd, label } }
    wk.register(wk_keymap, wk_opts)
end

local function register_group(key, name, opts)
    local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts or {})
    local wk_keymap = { [key] = { name = name } }
    wk.register(wk_keymap, wk_opts)
end

-- Register groups not directly related to specific plugins
register_group("b", "Buffers")
register_group("g", "Git")

-- Descriptions for Mark commands
local marks = {
    m = {
        name = "marks",

        ["-"] = "Line",
        ["="] = "Bookmark on Cursor",
        ["<space>"] = "Buffer",
        ["0"] = "Bookmark 0",
        ["1"] = "Bookmark 1",
        ["2"] = "Bookmark 2",
        ["3"] = "Bookmark 3",
        ["4"] = "Bookmark 4",
        ["5"] = "Bookmark 5",
        ["6"] = "Bookmark 6",
        ["7"] = "Bookmark 7",
        ["8"] = "Bookmark 8",
        ["9"] = "Bookmark 9",
    }
}


    }



    }



wk.register(marks, { mode = "n", prefix = "d" })

return {
    register_group = register_group,
    register_keymap = register_keymap
}
