local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("fannyp_" .. name, { clear = true })
end

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

vim.cmd("hi! link netrwMarkFile Search")

autocmd("filetype", {
	group = augroup("netrw"),
	pattern = "netrw",
	callback = function()
		local map = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end

		map("H", "u")
		map("h", "-^")
		map("l", "<CR>")
		map(".", "gh")
		map("P", "<C-w>z")

		map("<TAB>", "mf")
		map("<S-TAB>", "mF")
		map("<Leader><TAB>", "mu")

		map("<C-n>", "d")
		map("I", "%:w<CR>:buffer #<CR>")
		map("A", "R")
		map("cp", "mc")
		map("mv", "mm")

		map("ft", "mtfq")
		map("fq", ":echo 'Target:' . netrw#Expose('netrwmftgt')<CR>")
		map("fl", ":echo join(netrw#Expose('netrwmarkfilelist'), '\\n')<CR>")
	end,
})

-- statusline
autocmd({ "DiagnosticChanged" }, {
	group = augroup("statusline"),
	callback = function()
		local count = {}

		local levels = {
			errors = "Error",
			warnings = "Warn",
			info = "Info",
			hints = "Hint",
		}

		for k, level in pairs(levels) do
			count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
		end

		local errors = count["errors"] ~= 0 and "E:" .. count["errors"] or ""
		local warnings = count["warnings"] ~= 0 and " W:" .. count["warnings"] or ""
		local hints = count["hints"] ~= 0 and " H:" .. count["hints"] or ""
		local info = count["info"] ~= 0 and " I:" .. count["info"] or ""

		vim.b.diag = errors .. warnings .. hints .. info
	end,
})

vim.opt.statusline = "[%{%v:lua.string.upper(v:lua.vim.fn.mode())%}] %t%-m %{get(b:, 'diag', '')} %= %([%l/%L%)]%4p%%"

-- save last loc
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- yank hl
autocmd("TextYankPost", {
	group = augroup("hl_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})

-- autoresize splits
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. vim.fn.tabpagenr())
	end,
})

-- remove whitespaces
autocmd({ "BufWritePre" }, {
	group = augroup("remove_whitespace"),
	pattern = "*",
	callback = function()
		local curpos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, curpos)
	end,
})

-- remove newlines
autocmd({ "BufWritePre" }, {
	group = augroup("remove_newline"),
	pattern = "*",
	callback = function()
		local n_lines = vim.api.nvim_buf_line_count(0)
		local last_nonblank = vim.fn.prevnonblank(n_lines)
		if last_nonblank < n_lines then
			vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
		end
	end,
})

-- cleanup .tex builds
autocmd({ "VimLeave" }, {
	group = augroup("clean_tex"),
	pattern = "*.tex",
	command = "!texclear %",
})

-- run shortcuts script
autocmd({ "BufWritePost" }, {
	group = augroup("shortcuts"),
	pattern = { "bm-files", "bm-dirs" },
	command = "!shortcuts",
})

-- load shortcuts
autocmd({ "VimEnter" }, {
	group = augroup("shortcuts_load"),
	pattern = "*",
	command = "silent! source ~/.config/nvim/shortcuts.vim",
})

-- xs ft
autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("Xresources_ft"),
	pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
	command = "set filetype=xdefaults",
})

-- run xrdb on xs
autocmd({ "BufWritePost" }, {
	group = augroup("Xresources_xrdb"),
	pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
	command = "!xrdb %",
})
