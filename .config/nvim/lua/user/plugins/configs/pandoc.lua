vim.g["pandoc#syntax#conceal#blacklist"] = { "image" }

local pandoc_ok, pandoc = pcall(require, "pandoc")
if not pandoc_ok then
    return
end

pandoc.setup {
    commands = {
        enable = true,
        extended = false
    },

    default = {
        output = "%s.pdf",
        args = {
            { "--standalone" }
        }
    },

    equation = {
        border = "rounded"
    },
}
