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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load plugins
require 'user.plugins'

-- Sets vim options
require 'user.options'

-- Keymaps not related to plugins
require 'user.keymaps'

-- Autocmds not related to plugins
require 'user.autocmds'

-- Files for specific custom functionality
require 'user.django'
