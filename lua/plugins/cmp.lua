local cmp_init = { "hrsh7th/nvim-cmp" }

cmp_init.dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
}
cmp_init.event = "InsertEnter"

function cmp_init.config()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "luasnip", keyword_length = 2 },
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { "abbr", "menu", "kind" },
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = "[lsp]",
                    luasnip = "[snip]",
                    path = "[path]",
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        },

        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
            ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),

            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),

            ["<C-f>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-b>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
    })
end

return cmp_init
