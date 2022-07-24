local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local keymap = vim.api.nvim_set_keymap

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

local opts = { noremap = true, silent = true }

-- Search files
keymap('n', '<leader>tf', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], opts)
-- Search recently used files
keymap('n', '<leader>to', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], opts)
-- Search buffers
keymap('n', '<leader>t<space>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opts)
-- Find in current buffer with fuzzy search
keymap('n', '<leader>tl', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], opts)
-- Search Tags
keymap('n', '<leader>tt', [[<cmd>lua require('telescope.builtin').tags()<cr>]], opts)
-- Grep within current project
keymap('n', '<leader>tg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], opts)
-- Check git commits
keymap('n', '<leader>tGc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], opts)
-- Check git branches
keymap('n', '<leader>tGb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], opts)
-- Check git status
keymap('n', '<leader>tGs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], opts)
-- Integrate with project.nvim
keymap('n', '<leader>tp', [[<cmd>lua require('telescope').extensions.projects.projects()<cr>]], opts)
