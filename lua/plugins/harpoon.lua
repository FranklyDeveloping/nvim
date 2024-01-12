local harpoon_init = { "ThePrimeagen/harpoon" }

harpoon_init.branch = "harpoon2"
harpoon_init.dependencies = { "nvim-lua/plenary.nvim" }

function harpoon_init.config()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
        harpoon:list():append()
    end)
    vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i = 1, 9 do
        vim.keymap.set("n", "<leader>" .. i, function()
            harpoon:list():select(i)
        end)
    end

    harpoon:extend({
        UI_CREATE = function(cx)
            vim.keymap.set("n", "<C-v>", function()
                harpoon.ui:select_menu_item({ vsplit = true })
            end, { buffer = cx.bufnr })

            vim.keymap.set("n", "<C-x>", function()
                harpoon.ui:select_menu_item({ split = true })
            end, { buffer = cx.bufnr })

            vim.keymap.set("n", "<C-t>", function()
                harpoon.ui:select_menu_item({ tabedit = true })
            end, { buffer = cx.bufnr })
        end,
    })
end

return harpoon_init
