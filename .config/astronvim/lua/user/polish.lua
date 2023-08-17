require "user.django"
require("dap.ext.vscode").load_launchjs()

local notify = require "notify"
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local markdown = augroup("markdown", { clear = true })

-- enable word wrap and spellcheck for markdown/pandoc files
autocmd("FileType", {
  desc = "Markdown specific settings",
  group = markdown,
  pattern = { "pandoc", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.autowriteall = true
    vim.opt_local.textwidth = 85
  end,
})

autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*",
  callback = function()
    local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
    if venv ~= "" then require("venv-selector").retrieve_from_cache() end
    vim.api.nvim_command("LspRestart")
  end,
  once = true,
})
