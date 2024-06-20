return {
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
}
