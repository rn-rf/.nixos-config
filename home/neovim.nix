{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    nixCats

    # LSP servers
    lua-language-server
    nil
    typescript-language-server
    vscode-langservers-extracted
    jdt-language-server

    # formatters
    stylua
    prettierd
    eslint_d
    black
    shfmt
  ];

  programs.nixCats = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
      nvim-lspconfig
      nvim-treesitter
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
    ];
  };

  xdg.configFile."nvim".source = ../dotfiles/nvim;
}
