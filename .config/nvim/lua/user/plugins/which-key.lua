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

local function gen_table(key, opts)
    local char = string.sub(key, 0, 1)
    local rest = string.sub(key, 2, #key)

    local tbl = {}

    if rest == "" then
        tbl[char] = opts
        return tbl
    end

    tbl[char] = gen_table(rest, opts)
-- Register groups not directly related to specific plugins
register_group("b", "Buffers")
register_group("g", "Git")

    return tbl
end

local function register_keymap(key, cmd, label, opts)
    opts = opts or {}

    local wk_opts = {
        mode = opts.mode or "n",
        prefix = opts.prefix or "<leader>",
        buffer = opts.buffer or nil,
        silent = opts.silent or true,
        noremap = opts.noremap or true,
        nowait = opts.nowait or false
    }

    local wk_keymap = gen_table(key, { cmd, label })

    wk.register(wk_keymap, wk_opts)
end

local function register_group(key, name, opts)
    opts = opts or {}

    local wk_opts = {
        mode = opts.mode or "n",
        prefix = opts.prefix or "<leader>",
        buffer = opts.buffer or nil,
        silent = opts.silent or true,
        noremap = opts.noremap or true,
        nowait = opts.nowait or false
    }

    local wk_keymap = gen_table(key, { name = name })

    wk.register(wk_keymap, wk_opts)
end


return {
    register_group = register_group,
    register_keymap = register_keymap
}
