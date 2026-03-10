local v = vim

local teleok, builtin = pcall(require, "telescope.builtin")
local harpoon = require("harpoon")
local data_path = v.fn.stdpath("data") .. "/harpoon_lists.json"
local current_list = "a"

-- =============================
-- Harpoon Setup
-- =============================

harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

local function load_lists()
    local f = io.open(data_path, "r")
    if not f then
        return {}
    end
    local content = f:read("*a")
    f:close()
    if not content or content == "" then
        return {}
    end
    local ok, decoded = pcall(v.json.decode, content)
    if ok then
        return decoded
    end
    return {}
end

local function save_lists(lists)
    local f = io.open(data_path, "w")
    if not f then
        return
    end
    f:write(v.json.encode(lists))
    f:close()
end

local lists = load_lists()

-- =============================
-- Basic Settings
-- =============================

v.g.mapleader = ' '
v.g.maplocalleader = ' '
v.g.have_nerd_font = true

v.o.number = true
v.o.mouse = 'a'
v.o.showmode = false
v.schedule(function() v.o.clipboard = 'unnamedplus' end)

v.o.tabstop = 4
v.o.shiftwidth = 4
v.o.expandtab = true
v.o.softtabstop = 4
v.o.fillchars = "eob: "

v.o.breakindent = true
v.o.undofile = true
v.o.ignorecase = true
v.o.smartcase = true
v.o.signcolumn = 'yes'
v.o.updatetime = 250
v.o.timeoutlen = 300
v.o.splitright = true
v.o.splitbelow = true
v.o.list = true
v.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
v.o.inccommand = 'split'
v.o.cursorline = true
v.o.scrolloff = 10
v.o.confirm = true

-- =============================
-- Keymaps
-- =============================

v.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
v.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
v.keymap.set('n', '<C-h>', '<C-w><C-h>')
v.keymap.set('n', '<C-l>', '<C-w><C-l>')
v.keymap.set('n', '<C-j>', '<C-w><C-j>')
v.keymap.set('n', '<C-k>', '<C-w><C-k>')
v.keymap.set('n', 'FF', '<cmd>w<CR>', { desc = "Save file" })

v.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<CR>")
v.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

if teleok then
    v.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    v.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    v.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    v.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    v.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    v.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    v.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    v.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    v.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    v.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
end

-- =============================
-- Harpoon Keymaps
-- =============================

v.keymap.set("n", "<leader>hh", function() harpoon:list(current_list):add() end)
v.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list(current_list)) end)

for i = 1, 7 do
    v.keymap.set("n", "<leader>" .. i, function()
        harpoon:list(current_list):select(i)
    end)
end

v.keymap.set("n", "<leader>ha", function()
    v.ui.input({ prompt = "Harpoon list name: " }, function(name)
        if not name or name == "" then return end
        lists[name] = true
        save_lists(lists)
        print("Created list: " .. name)
    end)
end)

v.keymap.set("n", "<leader>hs", function()
    local names = {}
    for name, _ in pairs(lists) do
        table.insert(names, name)
    end
    v.ui.select(names, { prompt = "Harpoon lists" }, function(choice)
        if choice then
            current_list = choice
        end
    end)
end)

-- =============================
-- Yank Highlight
-- =============================

v.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        v.hl.on_yank()
    end,
})

-- =============================
-- Diagnostics
-- =============================

v.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    virtual_text = true,
    underline = { severity = { min = v.diagnostic.severity.WARN } },
})

v.keymap.set('n', '<leader>q', v.diagnostic.setloclist)

-- =============================
-- Plugin Configurations
-- =============================

require("obsidian").setup({
    workspaces = {
        {
            name = "notes",
            path = "~/Canvas/notes",
        },
    },
    legacy_commands = false,
})

pcall(function()
    require("fidget").setup({})
end)

pcall(function()
    require("gitsigns").setup()
end)

pcall(function()
    require("which-key").setup()
end)

pcall(function()
    local telescope = require("telescope")

    telescope.setup({
        extensions = {
            ["ui-select"] = require("telescope.themes").get_dropdown(),
        },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
end)

require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})

pcall(function()
    require("lualine").setup()
end)

pcall(function()
    require("neo-tree").setup({
        filesystem = {
            follow_current_file = { enabled = true },
            hijack_netrw_behavior = "open_default",
            use_libuv_file_watcher = true,
        },
        window = {
            mappings = {
                ["E"] = "expand_all_nodes",
                ["C"] = "close_all_nodes",
            },
        },
    })
end)

pcall(function()
    require("luasnip.loaders.from_vscode").lazy_load()
end)

pcall(function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.indentscope").setup()
    require("mini.pairs").setup()
end)

pcall(function()
    require("todo-comments").setup()
end)

pcall(function()
    require("blink.cmp").setup({})
end)

-- =============================
-- Colorscheme
-- =============================

require("rose-pine").setup({
    disable_background = true,
})

v.cmd.colorscheme("rose-pine")

local transparent_groups = {
    "Normal",
    "NormalNC",
    "EndOfBuffer",
    "SignColumn",
    "NormalFloat",
    "FloatBorder",
}

for _, group in ipairs(transparent_groups) do
    v.api.nvim_set_hl(0, group, { bg = "none" })
end

-- =============================
-- Oil File Manager
-- =============================

pcall(function()
    require("oil").setup({
        default_file_explorer = false,
        columns = { "icon" },
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["q"] = "actions.close",
            ["<CR>"] = "actions.select",
        },
        float = {
            padding = 2,
            max_width = 80,
            max_height = 40,
        },
    })
end)

-- =============================
-- Modern LSP Setup
-- =============================

local capabilities = require("blink.cmp").get_lsp_capabilities()

v.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        v.keymap.set("n", "gd", v.lsp.buf.definition, opts)
        v.keymap.set("n", "gD", v.lsp.buf.declaration, opts)
        v.keymap.set("n", "gi", v.lsp.buf.implementation, opts)
        v.keymap.set("n", "gr", v.lsp.buf.references, opts)
        v.keymap.set("n", "K", v.lsp.buf.hover, opts)
        v.keymap.set("n", "<leader>rn", v.lsp.buf.rename, opts)
        v.keymap.set("n", "<leader>ca", v.lsp.buf.code_action, opts)
    end,
})

local servers = {
    "clangd",
    "lua_ls",
    "nil_ls",
    "ts_ls",
    "jdtls",
    "pyright",
}

for _, server in ipairs(servers) do
    v.lsp.config(server, {
        capabilities = capabilities,
    })
    v.lsp.enable(server)
end
