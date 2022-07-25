local close_buffers_ok, close_buffers = pcall(require, "close_buffers")
if not close_buffers_ok then
    return
end

local keymap = require("user.plugins.which-key").register_keymap
-- Buffer mappings
keymap("bq", function() require('close_buffers').delete({ type = 'this' }) end, "Close Current Buffer")
keymap("bh", function() require('close_buffers').delete({ type = 'hidden', force = true }) end, "Close Hidden Buffers")
keymap("bo", function() require('close_buffers').delete({ type = 'other', force = true }) end, "Close All Other Buffers")
