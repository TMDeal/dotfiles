local M = {}

-- pulled from astronvim repo
-- https://github.com/AstroNvim/AstroNvim/blob/e7483c864e67fed4d1737c3ba76fe9c50b50ad12/lua/astronvim/utils/init.lua#L57
function M.list_insert_unique(lst, vals)
  if not lst then
    lst = {}
  end
  assert(vim.tbl_islist(lst), "Provided table is not a list like table")
  if not vim.tbl_islist(vals) then
    vals = { vals }
  end
  local added = {}
  vim.tbl_map(function(v)
    added[v] = true
  end, lst)
  for _, val in ipairs(vals) do
    if not added[val] then
      table.insert(lst, val)
      added[val] = true
    end
  end
  return lst
end

return M
