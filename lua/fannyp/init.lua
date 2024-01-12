require("fannyp.options")
require("fannyp.autocmds")
require("fannyp.keymaps")
require("fannyp.plugins")

function R(_)
    require("plenary.reload").reload_module(_)
end

vim.cmd.colorscheme("gruvbox")
