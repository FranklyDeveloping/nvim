local trouble_init = { "folke/trouble.nvim" }

trouble_init.cmd = { "Trouble", "TroubleToggle", "TroubleClose", "TroubleRefresh" }
trouble_init.opts = {
    icons = false,
    indent_lines = false,
    use_diagnostic_signs = true,
}

function trouble_init.init()
    local map = vim.keymap.set
    map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
    map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
    map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
    map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
end

function trouble_init.config(_, opts)
    require("trouble").setup(opts)
end

return trouble_init
