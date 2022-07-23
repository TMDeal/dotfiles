_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}

local impatient_ok, impaitent = pcall(require, "impatient")
if not impatient_ok then
    return
end

impaitent.enable_profile()
