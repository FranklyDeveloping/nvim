vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<cmd>Ex<cr>")
vim.keymap.set("n", "<leader>cd", "<cmd>lcd %:p:h<cr><cmd>pwd<cr>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "=", "<cmd>vertical resize +5<cr>")
vim.keymap.set("n", "-", "<cmd>vertical resize -5<cr>")
vim.keymap.set("n", "+", "<cmd>horizontal resize +2<cr>")
vim.keymap.set("n", "_", "<cmd>horizontal resize -2<cr>")

vim.keymap.set("n", "tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "]c", "<cmd>cnext<cr>zz")
vim.keymap.set("n", "[c", "<cmd>cprev<cr>zz")

vim.keymap.set("n", "]l", "<cmd>lnext<cr>zz")
vim.keymap.set("n", "[l", "<cmd>lprev<cr>zz")

vim.keymap.set("n", "<leader>bb", ":vsp<space>~/2.Areas/Zettels/Skripsi/skripsi.bib<cr>")
vim.keymap.set("n", "<leader>rr", ":vsp<space>$HOME/3.Resource/Biblio<cr>")

vim.keymap.set("n", "<leader>ts", ":pu=strftime('%c')<cr>")
vim.keymap.set("n", "<leader>cl", [[:normal! i- [ ] ]], { silent = true })
vim.keymap.set("n", "<leader>ct", [[:s/\v\[([ x])\]/\=submatch(1)=='x'?'[ ]':'[x]'/<cr>]], { silent = true })

vim.keymap.set("c", ";cp", ":w! | !compiler '%:p'<cr>")
vim.keymap.set("c", ";co", ":!opout '%:p'<cr>")
vim.keymap.set("c", ";sc", ":!clear && shellcheck -x %<cr>")
vim.keymap.set("c", ";pt", ":!pytest %<cr>")

vim.keymap.set("c", ";nt", ":!st >/dev/null 2>&1 & disown<cr><cr>")
vim.keymap.set("c", ";w", "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!<cr>")
vim.keymap.set("c", ";cx", ":!chmod +x %<cr>")
