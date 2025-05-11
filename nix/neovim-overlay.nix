{inputs}: final: prev:
with final.lib; let

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    final.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = final.callPackage ./mkNeovim.nix { pkgs = final.pkgs; lib = final.lib; stdenv = final.stdenv; };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }

  all-plugins = with final.vimPlugins; [
    nvim-lspconfig
    blink-cmp
    telescope-nvim
    tokyonight-nvim
    luasnip
    nvim-treesitter.withAllGrammars
    which-key-nvim
    plenary-nvim
    # lazydev-nvim
    luvit-meta
    trouble-nvim
    nui-nvim
    nvim-lint
    rustaceanvim
    fidget-nvim
    flash-nvim

    conform-nvim
    lualine-nvim
    neotest
    neotest-jest

    lspkind-nvim
    nvim-web-devicons
    neo-tree-nvim
    telescope-fzf-native-nvim
  ];

  extraPackages = with final; [
    lua-language-server
    nil
    lazygit
    fd
    ripgrep
    gcc
    luarocks
    stylua
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
in {
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };
}
