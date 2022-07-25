local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        prompt_prefix = "> ",

        file_ignore_patterns = {
            "%.png",
            "%.jpg",
            "%.jpeg"
        },

        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                --["<C-u>"] = actions.preview_scrolling_up,
                --["<C-d>"] = actions.preview_scrolling_down,
                ["<C-u>"] = false,
                ["<C-d>"] = false,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>

                ['<esc>'] = actions.close
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        }
    }
}

-- Load projects extension for project.nvim
require('telescope').load_extension('projects')

local keymap = require("user.plugins.which-key").register_keymap
local groupmap = require("user.plugins.which-key").register_group

groupmap("t", "[Telescope]")
-- Search files
keymap('tf', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], "Find Files")
-- Search recently used files
keymap('to', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], "Recently Used Files")
-- Search buffers
keymap('t<space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], "List Buffers")
-- Find in current buffer with fuzzy search
keymap('tl', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], "Find in Current Buffer")
-- Search Tags
keymap('tt', [[<cmd>lua require('telescope.builtin').tags()<cr>]], "Tags")
-- Grep within current project
keymap('tg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], "Grep")

groupmap("tG", "[Git]")
-- Check git commits
keymap('tGc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], "Git Commits")
-- Check git branches
keymap('tGb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], "Git Branches")
-- Check git status
keymap('tGs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], "Git Status")

-- Integrate with project.nvim
keymap('tp', [[<cmd>lua require('telescope').extensions.projects.projects()<cr>]], "Projects")
