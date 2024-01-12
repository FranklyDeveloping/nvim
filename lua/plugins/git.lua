local git_init = {}

local Plug = function(s)
	table.insert(git_init, s)
end

Plug({
	"tpope/vim-fugitive",
	cmd = "Git",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local autocmd = vim.api.nvim_create_autocmd

		local function augroup(name)
			return vim.api.nvim_create_augroup("fannyp_" .. name, { clear = true })
		end

		autocmd("BufWinEnter", {
			group = augroup("git"),
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, opts)

				vim.keymap.set("n", "<leader>gP", function()
					vim.cmd.Git({ "pull", "--rebase" })
				end, opts)

				vim.keymap.set("n", "<leader>gp", ":Git push -u origin ", opts)
			end,
		})
	end,
})

Plug({
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gitsign = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				vim.schedule(function()
					gitsign.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function()
					gitsign.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			map("n", "<leader>gs", gitsign.stage_hunk)
			map("n", "<leader>gr", gitsign.reset_hunk)
			map("v", "<leader>gs", function()
				gitsign.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("v", "<leader>gr", function()
				gitsign.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)
			map("n", "<leader>gS", gitsign.stage_buffer)
			map("n", "<leader>gu", gitsign.undo_stage_hunk)
			map("n", "<leader>gR", gitsign.reset_buffer)
			map("n", "<leader>gp", gitsign.preview_hunk)
			map("n", "<leader>gb", function()
				gitsign.blame_line({ full = true })
			end)
			map("n", "<leader>gb", gitsign.toggle_current_line_blame)
			map("n", "<leader>gd", gitsign.diffthis)
			map("n", "<leader>gD", function()
				gitsign.diffthis("~")
			end)
			map("n", "<leader>gd", gitsign.toggle_deleted)

			-- Text object
			map({ "o", "x" }, "gh", ":<C-U>Gitsigns select_hunk<cr>")
		end,
	},
})

return git_init
