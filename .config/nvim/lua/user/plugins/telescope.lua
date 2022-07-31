local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")

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

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                ["<C-t>"] = trouble_ok and trouble.open_with_trouble or nil
            },

            n = {
                ["<esc>"] = actions.close,
                ["<C-c>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,

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
                ["<C-t>"] = trouble_ok and trouble.open_with_trouble or nil
            },
        }
    },

    pickers = {
        find_files = {
            theme = "dropdown"
        },
        oldfiles = {
            theme = "dropdown"
        }
    },
}

-- Load extensions
require('telescope').load_extension('projects')
require("telescope").load_extension("notify")

local keymap = require("user.plugins.which-key").register_keymap

-- load nvim-neoclip extension
local neoclip_ok, _ = pcall(require, "neoclip")
if neoclip_ok then
    telescope.load_extension('neoclip')
    telescope.load_extension('macroscope')

    keymap('y', [[<cmd>:lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({}))<cr>]], "Neoclip")
    keymap('m', [[<cmd>:lua require('telescope').extensions.macroscope.default(require('telescope.themes').get_dropdown({}))<cr>]], "Macros - (q)")
end
-- Search files
keymap('f', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], "Find Files")
-- Search recently used files
keymap('O', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], "Recently Used Files")
-- Search buffers
keymap('bl', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], "List Buffers")
-- Find in current buffer with fuzzy search
keymap('bs', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], "Find in Current Buffer")
-- Search Tags
keymap('/', [[<cmd>lua require('telescope.builtin').tags()<cr>]], "Tags")
-- Grep within current project
keymap('s', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], "Search")

-- Check git commits
keymap('gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], "Git Commits")
-- Check git branches
keymap('gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], "Git Branches")
-- Check git status
keymap('gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], "Git Status")

-- Integrate with project.nvim
keymap('P', [[<cmd>lua require('telescope').extensions.projects.projects()<cr>]], "Projects")
-- Integrate with nvim-notify
keymap('N', [[<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({}))<cr>]], "Projects")
