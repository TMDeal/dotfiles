local aerial = require "aerial"

return {
    n = {
        ["["] = {
            a = { aerial.prev, "Previous Symbol" },
            A = { aerial.prev_up, "Previous Tree" },
        },
        ["]"] = {
            a = { aerial.next, "Next Symbol" },
            A = { aerial.next_up, "Next Tree" },
        },
    },
}
