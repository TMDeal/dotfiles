return {
  {
    "windwp/nvim-autopairs",
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

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
        Rule("#", "#", "htmldjango"):with_pair(function(rule_opts)
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
        { "#", "#" },
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
  { "windwp/nvim-ts-autotag", enabled = false },
  {
    "TMDeal/nvim-ts-autotag",
    name = "TMDeal-nvim-ts-autotag",
    opts = { autotag = { enable_close_on_slash = false } },
  },
}
