-- =============================
-- Cross-Distro Plugin Support
--
-- sudo pacman -S \
-- git curl wget unzip tar \
-- gcc clang make \
-- nodejs npm \
-- python python-pip \
-- ripgrep fd \
-- tree-sitter \
-- luarocks \
-- stylua shellcheck shfmt \
-- xclip
--
--
--sudo apt install \
-- git curl wget unzip tar \
-- build-essential \
-- nodejs npm \
-- python3 python3-pip \
-- ripgrep fd-find \
-- tree-sitter-cli \
-- luarocks \
-- stylua shellcheck shfmt \
-- xclip
--
-- =============================
local v = vim
local is_nixos = v.fn.filereadable("/etc/NIXOS") == 1

if not is_nixos then
    local lazypath = v.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not v.loop.fs_stat(lazypath) then
        v.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end

    v.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        -- UI
        { "rose-pine/neovim", name = "rose-pine" },
        { "nvim-lualine/lualine.nvim" },

        -- Telescope
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Treesitter
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

        -- Git
        { "lewis6991/gitsigns.nvim" },
        { "tpope/vim-fugitive" },

        -- Navigation
        { "ThePrimeagen/harpoon" },

        -- File explorers
        {
            "nvim-neo-tree/neo-tree.nvim",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            }
        },
        { "stevearc/oil.nvim" },

        -- LSP
        { "neovim/nvim-lspconfig" },

        -- Mason
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Completion / snippets
        { "Saghen/blink.cmp" },
        { "L3MON4D3/LuaSnip" },

        -- Utilities
        { "folke/which-key.nvim" },
        { "j-hui/fidget.nvim" },
        { "folke/todo-comments.nvim" },

        -- Mini modules
        { "echasnovski/mini.ai" },
        { "echasnovski/mini.surround" },
        { "echasnovski/mini.indentscope" },
        { "echasnovski/mini.pairs" },

        -- Obsidian
        { "epwalsh/obsidian.nvim" },
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "clangd",
            "lua_ls",
            "nil_ls",
            "ts_ls",
            "jdtls",
            "pyright",
        }
    })
end
