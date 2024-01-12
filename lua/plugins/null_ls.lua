local null_ls_init = { "jay-babu/mason-null-ls.nvim" }

null_ls_init.event = { "BufReadPre", "BufNewFile" }
null_ls_init.dependencies = {
    { "williamboman/mason.nvim" },
    { "nvimtools/none-ls.nvim" },
}
null_ls_init.cmd = { "NullLsInstall", "NullLsUninstall" }

function null_ls_init.config()
    require("mason-null-ls").setup({
        ensure_installed = {
            "black",
            "prettier",
        },
        automatic_installation = false,
        handlers = {},
    })

    require("null-ls").setup({
        border = "rounded",
        sources = {},
    })
end

return null_ls_init
