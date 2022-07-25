-- Generate a vimwiki config based on the name of the wiki
local function wiki_config(name)
    return {
        name = name,
        path = "~/vimwiki/" .. name,
        path_html = "~/vimwiki/" .. name .. "/html",
        template_path = "~/vimwiki/templates",
        template_default = "default",
        css_name = "css/styles.css",
        syntax = "default",
        ext = ".wiki",
        template_ext = ".html",
        auto_toc = 1
    }
end

-- Create a vimwiki config for every config listed in ~/vimwiki/wikis.txt
-- May want to change this to do some more in depth checks on the file read and
-- make sure that I get the input I expect
local get_wikis = function()
    local path = vim.env.HOME .. "/vimwiki/wikis.txt"
    local wikis = {
        wiki_config("default")
    }

    local f = io.open(path, "rb")
    if f then f:close() end

    if f == nil then
        return wikis
    end

    for wiki in io.lines(path) do
        table.insert(wikis, wiki_config(wiki))
    end

    return wikis
end

vim.g.vimwiki_list = get_wikis()
vim.g.vimwiki_ext2syntax = vim.empty_dict()

vim.g.vimwiki_key_mappings = {
    all_maps = 1,
    global = 1,
    headers = 1,
    text_objs = 1,
    table_format = 1,
    table_mappings = 1,
    lists = 1,
    links = 1,
    html = 0, -- Disable the html mappings, we will remap them ourselves
    mouse = 0
}

local vimwiki = vim.api.nvim_create_augroup("my-vimwiki", { clear = true })

-- Register the html mappings only when a vimwiki file is opened
vim.api.nvim_create_autocmd("FileType", {
    group = vimwiki,
    pattern = "vimwiki",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.textwidth = 80
        vim.opt_local.spell = true

        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>whh", ":Vimwiki2HTML<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>whb", ":Vimwiki2HTMLBrowse<CR>", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>wha", ":VimwikiAll2HTML<CR>", opts)

        local which_key_ok, wk = pcall(require, "which-key")
        if not which_key_ok then
            return
        end

        wk.register({
            w = {
                c = "Colorize Line/Selection",
                n = "Goto or Create New Page",
                d = "Delete Current Page",
                r = "Rename Current Page",

                h = {
                    name = "[HTML]",

                    h = "Convert Current Page",
                    b = "Convert and Browse Current Page"
                },

                ["<leader>"] = {
                    i = "Update Diary Section"
                }
            }
        }, { prefix = "<leader>", buffer = 0 })
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = vimwiki,
    pattern = "*.wiki",
    callback = function()
        vim.cmd [[silent! Vimwiki2HTML]]
    end
})

local which_key_ok, wk = pcall(require, "which-key")
if not which_key_ok then
    return
end

wk.register({
    w = {
        name = "[VimWiki]",

        w = "Open Wiki",
        t = "Open Wiki in New Tab",
        s = "List and Select Available Wikis",
        i = "Open Diary",

        ["<leader>"] = {
            name = "[Diary]",

            w = "Open Diary for Today",
            t = "Open Diary for Today in New Tab",
            y = "Open Diary for Yesterday",
            m = "Open Diary for Tomorrow",
        }
    }
}, { prefix = "<leader>" })
