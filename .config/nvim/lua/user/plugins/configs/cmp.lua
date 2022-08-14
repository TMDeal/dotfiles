local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local snip_ok, luasnip = pcall(require, "luasnip")
if not snip_ok then
    return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
    return
end

-- Allows loading vscode plugin snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },

    mapping = {
        ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "c" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "c" }),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "cmp_pandoc" },
        { name = "luasnip" },
        { name = 'nvim_lsp_signature_help' },
        { name = "buffer" },
        { name = "path" }
    },

    formatting = {
        format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            before = function(entry, vim_item)
                return vim_item
            end
        }
    }
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})

local cmp_pandoc_ok, cmp_pandoc = pcall(require, "cmp_pandoc")
if not cmp_pandoc_ok then
    return
end


cmp_pandoc.setup {
    filetypes = { "pandoc", "markdown" },
}
