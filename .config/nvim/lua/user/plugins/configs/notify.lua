local notify_ok, notify = pcall(require, "notify")
if not notify_ok then
    return
end

notify.setup {
    background_colour = "#2e3440",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    timeout = 250
}

vim.notify = notify
