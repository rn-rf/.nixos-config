-- =============================
-- Basic Settings
-- =============================

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.tabstop = 4      -- Number of spaces a <Tab> counts for
vim.o.shiftwidth = 4   -- Size of an indent
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.softtabstop = 4  -- Number of spaces inserted when pressing Tab

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- =============================
-- Keymaps
-- =============================

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- =============================
-- Yank Highlight
-- =============================

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- =============================
-- Diagnostics
-- =============================

vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	virtual_text = true,
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- =============================
-- Plugin Configurations
-- =============================

-- Gitsigns
pcall(function()
	require('gitsigns').setup()
end)

-- Which-key
pcall(function()
	require('which-key').setup()
end)

-- Telescope
pcall(function()
	require('telescope').setup {
		extensions = {
			['ui-select'] = require('telescope.themes').get_dropdown(),
		},
	}
end)

-- Treesitter
require('nvim-treesitter.configs').setup {
	highlight = { enable = true },
	indent = { enable = true },
}

-- Lualine
pcall(function()
	require('lualine').setup()
end)

-- Autopairs
pcall(function()
	require('nvim-autopairs').setup()
end)

-- Comment.nvim
pcall(function()
	require('Comment').setup()
end)

-- Neo-tree
pcall(function()
	require('neo-tree').setup()
end)

-- Completion (blink.cmp)
pcall(function()
	require('blink.cmp').setup {}
end)

-- Conform (formatter)
pcall(function()
	require('conform').setup {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = 'fallback',
		},
	}
end)

-- Colorscheme
pcall(function()
	vim.cmd.colorscheme 'tokyonight-night'
end)



-- =====================================
-- Modern LSP Setup (Neovim 0.11+)
-- =====================================

-- Optional: nice LSP keymaps when server attaches
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})

local servers = {
	"clangd",
	"lua_ls",
	"nil_ls",
	"ts_ls",
	"jdtls",
}

for _, server in ipairs(servers) do
	vim.lsp.config(server, {})
	vim.lsp.enable(server)
end
