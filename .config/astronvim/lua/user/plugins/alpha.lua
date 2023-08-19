return {
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require "alpha.themes.dashboard"
      local button = require("astronvim.utils").alpha_button

      dashboard.section.buttons.val = {
        button("SPC n", "  new file"),
        button("SPC f f", "  Find File"),
        button("SPC f o", "  Recent Files"),
        button("SPC f w", "  Find Word"),
        button("SPC f '", "  Bookmarks"),
        button("SPC S l", "  Last Session"),
        button("SPC q", "  Quit"),
      }

      return dashboard
    end,
  },
}
