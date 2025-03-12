return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },

      ["<UP>"] = { "scroll_documentation_up", "fallback" },
      ["<DOWN>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },

      ["<C-n>"] = { "snippet_forward", "fallback" },
      ["<C-p>"] = { "snippet_backward", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    },
  },
}
