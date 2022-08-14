local comment_ok, comment = pcall(require, "Comment")
if not comment_ok then
    return
end

comment.setup {
    hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
    end,
}
