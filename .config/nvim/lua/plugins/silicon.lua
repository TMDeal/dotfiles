return {
  "krivahtoo/silicon.nvim",
  cmd = "Silicon",
  build = "./install.sh build",
  config = function()
    require("silicon").setup({
      font = "Inconsolata Nerd Font=26",
      output = {
        path = vim.fn.expand("$HOME") .. "/Pictures/screenshots",
      },
      theme = "Nord",
      background = "#4c566a",
      line_number = true,
      pad_vert = 80,
      pad_horiz = 50,
      watermark = {
        text = " @TMDeal",
        color = "#eceff4",
      },
      window_title = function()
        return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
      end,
    })
  end,
}
