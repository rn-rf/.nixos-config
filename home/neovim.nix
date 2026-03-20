{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim

      harpoon2

      nvim-lspconfig

      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.python
        p.java
        p.lua
        p.bash
        p.json
        p.javascript
        p.typescript
        p.go
        p.gomod
      ]))

      blink-cmp
      luasnip
      friendly-snippets

      which-key-nvim
      gitsigns-nvim
      lualine-nvim
      nvim-web-devicons
      mini-nvim

      oil-nvim
      neo-tree-nvim

      rose-pine
      todo-comments-nvim
      undotree
      fidget-nvim

      obsidian-nvim
    ];
  };

  # LSP servers & tools (installed via Nix)
  home.packages = with pkgs; [
    lua-language-server
    gopls
    nil
    typescript-language-server
    vscode-langservers-extracted
    pyright
    jdt-language-server
    stylua
    prettierd
    eslint_d
    black
    shfmt
    clang-tools
  ];

  xdg.configFile."nvim".source = ../dotfiles/nvim;
}
