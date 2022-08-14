local bqf_ok, bqf = pcall(require, "bqf")
if not bqf_ok then
    return
end

bqf.setup {
    auto_enable = true,
    magic_window = true,
    auto_resize_height = false,

    preview = {
        auto_preview = true,
        border_chars = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' },
        delay_syntax = 50,
        win_height = 15,
        win_vheight = 15,
        wrap = false,
        should_preview_cb = nil
    },

    func_map = {
        open = '<CR>',
        openc = 'o',
        drop = 'O',
        split = '<C-x>',
        vsplit = '<C-v>',
        tab = 't',
        tabb = 'T',
        tabc = '<C-t>',
        tabdrop = '',
        ptogglemode = 'zp',
        ptoggleitem = 'p',
        ptoggleauto = 'P',
        pscrollup = '<C-b>',
        pscrolldown = '<C-f>',
        pscrollorig = 'zo',
        prevfile = '<C-p>',
        nextfile = '<C-n>',
        prevhist = '<',
        nexthist = '>',
        lastleave = [['"]],
        stoggleup = '<S-Tab>',
        stoggledown = '<Tab>',
        stogglevm = '<Tab>',
        stogglebuf = [['<Tab>]],
        sclear = 'z<Tab>',
        filter = 'zn',
        filterr = 'zN',
        fzffilter = 'zF'
    },

    filter = {
        fzf = {
            action_for = {
                ['ctrl-t'] = 'tabedit',
                ['ctrl-v'] = 'vsplit',
                ['ctrl-x'] = 'split',
                ['ctrl-q'] = 'signtoggle',
                ['ctrl-c'] = 'closeall'
            },
            extra_opts = { '--bind', 'ctrl-o:toggle-all', "--delimiter", "|" }
        }
    }
}

-- Copied from https://github.com/kevinhwang91/nvim-bqf#format-new-quickfix
local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:match("[^/]*$")
                    -- fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
