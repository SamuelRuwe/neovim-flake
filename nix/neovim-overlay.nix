# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }

  all-plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    telescope-nvim
    tokyonight-nvim
    nvim-cmp
    luasnip
    cmp-path
    cmp-buffer
    cmp_luasnip
    cmp-nvim-lsp
    nvim-treesitter.withAllGrammars
    which-key-nvim
    plenary-nvim
    lazydev-nvim
    luvit-meta
    trouble-nvim
    nui-nvim
    nvim-lint
    rustaceanvim

    conform-nvim
    lualine-nvim

    # https://github.com/onsails/lspkind.nvim
    lspkind-nvim
    nvim-web-devicons
    neo-tree-nvim
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil # nix LSP
    lazygit
    fd
    ripgrep
    gcc
    luarocks
    stylua

    # packages with results in /lib/node_modules/.bin must come at the end
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
