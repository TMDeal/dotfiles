local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
    return
end

local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup {
    -- Use treesitter
    check_ts = true,

    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
    },

    -- Disable autopairs when using Telescope
    disable_filetypes = { "TelescopePrompt" },

    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    },
}


-- used to match '{%' '%}' in django templates
-- should work if '%' is inside brackets, for example when adding '%'
-- {|} -> {%%}
-- | -> %
npairs.add_rules {
  Rule("%", "%", { "html", "htmldjango" })
    :with_pair(function(opts)
      local should_expand = opts.text:sub(opts.col - 1, opts.col - 1) == '{'
      return should_expand
    end)
}


-- Copied from: https://github.com/windwp/nvim-autopairs/wiki/Custom-rules
-- should make it that when pressing <space> in between certain pairs, that it will add padding
-- example:
-- (|) -> ( | )
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '%', '%' } }

for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(' ', ' ')
      :with_pair(function (opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          bracket[1]..bracket[2],
        }, pair)
      end),

    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end

-- Integrate with nvim-cmp to add closing braces at end of function calls and stuff
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
