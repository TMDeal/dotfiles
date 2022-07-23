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
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "cmp_pandoc" },
        { name = "luasnip" },
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
    filetypes = { "pandoc", "markdown", "rmd" },
}
