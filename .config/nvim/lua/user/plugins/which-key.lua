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

    window = {
        border = "rounded", -- none, single, double, shadow, rounded
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },

    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
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

local function register_keymap(opts)
    local label = opts.label or ""
    local key = opts.key
    local cmd = opts.cmd

    if key == "" or cmd == "" then
        print("Missing required args")
        return
    end

    local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts.opts or {})
    local wk_keymap = { [key] = { cmd, label } }
    wk.register(wk_keymap, wk_opts)
end

local function register_group(opts)
    if type(opts.key) ~= "string" then
        print("key is required and must be a string!")
        return
    end

    local key = opts.key
    
    if type(opts.name) ~= "string" then
        print("name is required and must be a string")
        return
    end

    local name = opts.name

    local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts.opts or {})
    local wk_keymap = { [key] = { name = name } }
    wk.register(wk_keymap, wk_opts)
end

-- local function register_keymap(key, cmd, label, opts)
--     local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts or {})
--     local wk_keymap = { [key] = { cmd, label } }
--     wk.register(wk_keymap, wk_opts)
-- end
--
-- local function register_group(key, name, opts)
--     local wk_opts = vim.tbl_deep_extend("force", {}, register_opts, opts or {})
--     local wk_keymap = { [key] = { name = name } }
--     wk.register(wk_keymap, wk_opts)
-- end

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

-- Description for comment commands
local comments = {
    b = {
        name = "Toggle Block Comments",
        c = "Comment"
    },

    c = {
        name = "Toggle Line Comments",
        c = "Comment Line",
        o = "Comment Line Below" ,
        O = "Comment Line Above",
        A = "Comment at Line End"
    }
}

-- Descriptions for visual comments
local vcomments = {
    c = "Linewise Comment Selection",
    b = "Blockwise Comment Selection"
}

-- Descriptions for match-up text objects
local matchup = {
    a = {
        ["%"] = "Matchup Pair"
    },

    i = {
        ["%"] = "Matchup Pair"
    },

    g = {
        ["%"] = "Matchup Pair"
    },

    ["]"] = {
        name = "To Next",

        ["%"] = "Matchup Pair"
    },

    ["["] = {
        name = "To Previous",

        ["%"] = "Matchup Pair"
    },

    z = {
        ["%"] = "Matchup Pair"
    }
}

-- Description for commands under the "z" operator
local z = {
    ["%"] = "Jump to Begining of Next Pair"
}

-- Description for commands under the "z" operator in visual mode
local vz = {
    ["%"] = "Jump to Begining of Next Pair"
}

-- Descriptions for window commands
local windows = {
    o = "Focus Window"
}

wk.register(marks, { mode = "n", prefix = "d" })
wk.register(windows, { mode = "n", prefix = "<c-w>" })
wk.register(comments, { mode = "n", prefix = "g" })
wk.register(vcomments, { mode = "v", prefix = "g" })
wk.register(matchup, { mode = "o", prefix = "" })
wk.register(z, { mode = "n", prefix = "z" })
wk.register(vz, { mode = "v", prefix = "z" })

return {
    register_group = register_group,
    register_keymap = register_keymap
}
