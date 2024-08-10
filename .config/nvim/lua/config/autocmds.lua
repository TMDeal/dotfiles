local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

autocmd("FileType", {
  desc = "Markdown specific settings",
  group = augroup("markdown"),
  pattern = { "pandoc", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.autowriteall = true
    vim.opt_local.textwidth = 85
    vim.opt_local.spell = false
  end,
})

autocmd("FileType", {
  desc = "HTML/CSS specific settings",
  group = augroup("webfiles"),
  pattern = { "html", "css", "scss", "htmldjango" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

autocmd("FileType", {
  desc = "Nix filetype specific settings",
  group = augroup("nix"),
  pattern = { "nix" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

local django_grp = augroup("django-augroup")

-- Determine if we are in a django project
local is_django = function()
  local project_ok, project = pcall(require, "project_nvim.project")
  if not project_ok then
    return false
  end

  local rootdir = project.get_project_root()

  if not rootdir then
    return false
  end

  local is_django = vim.fn.filereadable(rootdir .. "/manage.py")
  return is_django == 1
end

-- Determine if we are in a go module
local is_go = function()
  local project_ok, project = pcall(require, "project_nvim.project")
  if not project_ok then
    return false
  end

  local rootdir = project.get_project_root()

  if not rootdir then
    return false
  end

  local is_go = vim.fn.filereadable(rootdir .. "/go.mod")
  return is_go == 1
end

-- Read html files as htmldjango in django project
autocmd("BufEnter", {
  group = django_grp,
  pattern = "*.html",
  callback = function()
    if is_django() then
      vim.opt_local.filetype = "htmldjango"
    end
  end,
})
