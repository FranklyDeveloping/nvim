local treesitter_init = { "nvim-treesitter/nvim-treesitter" }

treesitter_init.opts = {
	highlight = { enable = true },
	ensure_installed = {
		"bash",
		"awk",
		"c",
		"cpp",
		"lua",
		"latex",
		"python",
		"toml",
		"r",
		"sql",
		"go",
		"html",
		"htmldjango",
		"css",
		"javascript",
		"typescript",
		"vue",
		"svelte",
		"json",
	},
}

function treesitter_init.config(_, opts)
	require("nvim-treesitter.configs").setup(opts)
end

return treesitter_init
