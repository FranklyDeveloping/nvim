local telescope_init = { "nvim-telescope/telescope.nvim" }

telescope_init.dependencies = {
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
telescope_init.cmd = "Telescope"

function telescope_init.init()
	local map = vim.keymap.set

	map("n", "<leader>ps", "<cmd>Telescope live_grep<cr>")
	map("n", "<leader>pS", "<cmd>Telescope grep_string<cr>")
	map("n", "<leader>p/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
	map("n", "<leader>pg", "<cmd>Telescope git_files<cr>")
	map("n", "<leader>pf", "<cmd>Telescope find_files<cr>")
	map("n", "<leader>pF", "<cmd>Telescope oldfiles<cr>")
	map("n", "<leader>pb", "<cmd>Telescope buffers<cr>")
	map("n", "<leader>pd", "<cmd>Telescope diagnostics<cr>")
end

function telescope_init.config()
	local telescope = require("telescope")
	local function defaults(title)
		return {
			prompt_title = title,
			results_title = false,
		}
	end
	local function dropdown(title, previewer)
		return {
			prompt_title = title,
			previewer = previewer or false,
			theme = "dropdown",
		}
	end
	local function ivy(title, previewer)
		return {
			prompt_title = title,
			previewer = previewer or false,
			theme = "ivy",
			initial_mode = "normal",
			layout_config = { height = 10 },
		}
	end

	telescope.setup({
		defaults = {
			prompt_prefix = " ",
			layout_strategy = "vertical",
			sorting_strategy = "ascending",
			layout_config = {
				preview_cutoff = 25,
				mirror = true,
				prompt_position = "top",
			},
		},
		pickers = {
			buffers = dropdown(),
			find_files = dropdown(),
			oldfiles = dropdown(),
			keymaps = dropdown(),
			command_history = dropdown(),

			grep_string = defaults(),
			treesitter = defaults(),
			current_buffer_fuzzy_find = defaults(),
			live_grep = defaults(),

			commands = defaults(),
			help_tags = defaults(),
			diagnostics = ivy(),
			quickfix = ivy(),
		},
		extensions = {
			fzf = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},
		},
		telescope.load_extension("fzf"),
	})
end

return telescope_init
