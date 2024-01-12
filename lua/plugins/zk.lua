local zk_init = { "mickael-menu/zk-nvim" }

function zk_init.config()
    local zk = require("zk")
    zk.setup({ picker = "telescope" })

    local util = require("zk.util")
    local commands = require("zk.commands")

    local function make_new_fn(defaults)
        return function(options)
            options = vim.tbl_extend("force", defaults, options or {})
            zk.new(options)
        end
    end

    local function make_edit_fn(defaults, picker_options)
        return function(options)
            options = vim.tbl_extend("force", defaults, options or {})
            zk.edit(options, picker_options)
        end
    end

    commands.add("ZkLit", make_new_fn({ dir = "Literature Notes" }))
    commands.add("ZkRecents", make_edit_fn({ createdAfter = "1 weeks ago" }, { title = "Zk Recents" }))
    commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
    commands.add("ZkLiveGrep", function(options)
        options = options or {}
        local notebook_path = options.notebook_path or util.resolve_notebook_path(0)
        local notebook_root = util.notebook_root(notebook_path)
        if notebook_root then
            require("telescope.builtin").live_grep({
                cwd = notebook_root,
                prompt_title = "Zk Live Grep",
            })
        else
            vim.notify("No notebook found", vim.log.levels.ERROR)
        end
    end)

    local map = function(mode, lhs, rhs)
        local opts = { silent = false, noremap = true }
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    map("n", "<leader>zc", "<cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<cr>")
    map("n", "<leader>zC", "<cmd>ZkLit<cr>")
    map("n", "<leader>zn", "<cmd>ZkNotes { sort = { 'modified' } }<cr>")
    map("n", "<leader>zg", "<cmd>ZkLiveGrep<cr>")
    map("v", "<leader>zm", ":'<,'>ZkMatch<cr>")
    map("n", "<leader>zr", "<cmd>ZkRecents<cr>")
    map("n", "<leader>zl", "<cmd>ZkLinks<cr>")
    map("n", "<leader>zL", "<cmd>ZkBacklinks<cr>")
    map("n", "<leader>zt", "<cmd>ZkTags<cr>")
    map("n", "<leader>zo", "<cmd>ZkOrphans<cr>")
end

return zk_init
