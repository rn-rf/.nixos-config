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
      nvim-lspconfig
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.lua
        p.bash
        p.json
        p.javascript
        p.typescript
      ]))
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      which-key-nvim
      gitsigns-nvim
      lualine-nvim
      indent-blankline-nvim
      nvim-web-devicons
      neo-tree-nvim
      comment-nvim
      nvim-autopairs
      tokyonight-nvim
      todo-comments-nvim
      mini-nvim
      conform-nvim
      blink-cmp
      fidget-nvim
    ];
  };

  # LSP servers & tools (installed via Nix, not Mason)
  home.packages = with pkgs; [
    lua-language-server
    nil
    typescript-language-server
    vscode-langservers-extracted
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
