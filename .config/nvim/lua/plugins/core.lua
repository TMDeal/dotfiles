return {
  {
    "jay-babu/project.nvim",
    name = "project_nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      manual_mode = false,
      detection_methods = { "pattern", "lsp" },
      patterns = {
        ".git",
        "venv",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        ".projectroot",
        "go.mod",
      },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("lazyvim.util").on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = "toggleterm",
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#2e3440",
      fps = 30,
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 250,
    },
  },
  {
    "lambdalisue/suda.vim",
    cmd = "SudaWrite",
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = false }))
      end

      local Rule = require("nvim-autopairs.rule")
      local Cond = require("nvim-autopairs.conds")

      npairs.add_rules({
        Rule("<!--", "-->", "htmldjango"):with_cr(Cond.none()),
        -- Copied from https://github.com/windwp/nvim-autopairs/blob/master/lua/nvim-autopairs/rules/basic.lua
        -- makes html tags in htmldjango open nicely on <CR>
        Rule(">[%w%s]*$", "^%s*</", "htmldjango"):only_cr():use_regex(true),
        -- used to match '{%' '%}' in django templates
        -- should work if '%' is inside brackets, for example when adding '%'
        -- {|} -> {%%}
        -- | -> %
        Rule("%", "%", "htmldjango"):with_pair(function(rule_opts)
          local should_expand = rule_opts.text:sub(rule_opts.col - 1, rule_opts.col - 1) == "{"
          return should_expand
        end),
      })

      -- Copied from: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules
      -- should make it that when pressing <space> in between certain pairs, that it will add padding
      -- example:
      -- (|) -> ( | )
      local brackets = {
        { "(", ")" },
        { "[", "]" },
        { "{", "}" },
        { "%", "%" },
      }

      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(" ", " "):with_pair(function(rule_opts)
            local pair = rule_opts.line:sub(rule_opts.col - 1, rule_opts.col)
            return vim.tbl_contains({
              bracket[1] .. bracket[2],
            }, pair)
          end),

          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(function()
              return false
            end)
            :with_move(function(rule_opts)
              return rule_opts.prev_char:match(".%" .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        })
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            function()
              return " "
            end,
            padding = 0,
          },
        },
        lualine_z = {
          {
            function()
              return " "
            end,
            padding = 0,
          },
        },
      },
      winbar = {
        lualine_c = {
          {
            "aerial",
            sep = " > ",
            sep_icon = "",
            depth = 5,
            dense = false,
            dense_sep = ".",
            colored = true,
            draw_empty = true,
            color = {
              bg = "NONE",
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = {},
      },
    },
  },
}
