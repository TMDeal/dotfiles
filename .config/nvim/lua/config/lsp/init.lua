local pyright = require("config.lsp.pyright")
local html = require("config.lsp.html")
local lua_ls = require("config.lsp.lua_ls")

vim.lsp.config("pyright", pyright)
vim.lsp.config("html", html)
vim.lsp.config("lua_ls", lua_ls)
