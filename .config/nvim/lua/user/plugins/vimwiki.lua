-- Generate a vimwiki config based on the name of the wiki
local function wiki_config(name)
    return {
        name = name,
        path = "~/vimwiki/" .. name,
        path_html = "~/vimwiki/" .. name .. "/html",
        template_path = "~/vimwiki/templates",
        syntax = "markdown",
        ext = ".wiki",
        template_ext = ".wiki",
        auto_toc = 1,
        custom_wiki2html = "vimwiki_markdown"
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
        require("user.plugins.which-key").register_vimwiki()

        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>whh", "<Plug>Vimwiki2HTML", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>whb", "<Plug>Vimwiki2HTMLBrowse", opts)
    end
})
