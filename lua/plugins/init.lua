local Plugins = {
	{ "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"tpope/vim-surround",
		keys = {
			"ds",
			"cs",
			"cS",
			"ys",
			"yS",
			"yss",
			"ySs",
			"ySS",
			{ "S", mode = "x" },
			{ "gS", mode = "x" },
		},
	},
	{
		"preservim/vim-markdown",
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_toml_frontmatter = 1
			vim.g.vim_markdown_json_frontmatter = 1
			vim.g.vim_markdown_borderless_table = 1
		end,
	},
}

return Plugins
