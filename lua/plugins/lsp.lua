local lsp_init = { "neovim/nvim-lspconfig" }

lsp_init.event = { "BufReadPre", "BufNewFile" }
lsp_init.dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
}
lsp_init.cmd = { "LspInfo", "LspInstall", "LspUnInstall" }

local user = {}

function lsp_init.init()
    local sign = function(opts)
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
    end

    sign({ name = "DiagnosticSignError", text = "E" })
    sign({ name = "DiagnosticSignWarn", text = "W" })
    sign({ name = "DiagnosticSignHint", text = "H" })
    sign({ name = "DiagnosticSignInfo", text = "I" })

    vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

function lsp_init.config()
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("lspconfig.ui.windows").default_options.border = "rounded"

    local group = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = user.on_attach,
    })

    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "clangd",
            "pyright",
            "gopls",
            "html",
            "cssls",
            "emmet_language_server",
            "eslint",
            "tsserver",
        },
        handlers = {
            function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            ["tsserver"] = function()
                require("plugins.lsp.tsserver")
            end,

            ["lua_ls"] = function()
                require("plugins.lsp.lua_ls")
            end,
        },
    })
end

function user.on_attach()
    local map = function(mode, lhs, rhs)
        local opts = { buffer = true }
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    map("n", "<leader>vs", "<cmd>lua vim.lsp.buf.document_symbol()<cr>")
    map("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>")
    map("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<cr>")
    map("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    map("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<cr>")
    map({ "n", "x" }, "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true, timeout_ms=2000})<cr>")
    map("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    map("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>")
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

return lsp_init
