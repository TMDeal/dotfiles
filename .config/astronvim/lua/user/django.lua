local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local django_grp = augroup("django-augroup", { clear = true })

-- Determine if we are in a django project
local is_django = function()
  local project_ok, project = pcall(require, "project_nvim.project")
  if not project_ok then return false end

  local rootdir = project.get_project_root()

  if not rootdir then return false end

  local is_django = vim.fn.filereadable(rootdir .. "/manage.py")
  return is_django == 1
end

-- Read html files as htmldjango
autocmd("BufEnter", {
  group = django_grp,
  pattern = "*.html",
  callback = function()
    if is_django() then vim.opt_local.filetype = "htmldjango" end
  end,
})
