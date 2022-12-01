local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")
local section = dashboard.section
local button = dashboard.button

section.buttons.val = {
    button("SPC a s", "  Open Session", ":Autosession search<CR>"),
    button("SPC p", "  Projects", ":Telescope projects<CR>"),
    button("SPC f f", "  Find file"),
    button("SPC f r", "  Recently opened files"),
    button("SPC P", "  Find project"),
    button("SPC s", "  Find text"),
    button("e", "  New file", ":ene<CR>"),
    button("c", "  Edit Configuration", ":e ~/.config/nvim/init.lua<CR>"),
    button("q", "  Quit", ":qa<CR>"),
}

local function footer()
    -- NOTE: requires the fortune-mod package to work
	local handle = io.popen("fortune")
    if handle == nil then
        return ""
    end

	local fortune = handle:read("*a")
	handle:close()
	return fortune
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

alpha.setup(dashboard.config)
