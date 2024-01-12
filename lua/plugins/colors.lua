local gruvbox_init = { "ellisonleao/gruvbox.nvim" }

gruvbox_init.priority = 1000
gruvbox_init.lazy = true
gruvbox_init.opts = {
	transparent_mode = true,
	overrides = {
		FloatBorder = { fg = "#a89984" },
		CursorLine = { bg = "" },
		CursorLineNr = { bg = "" },
	},
}
function gruvbox_init.config(_, opts)
	require("gruvbox").setup(opts)
end

return gruvbox_init
