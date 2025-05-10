{ pkgs, lib, stdenv, }:
with lib;
  {
    appName ? null,
    plugins ? [], # List of plugins
    devPlugins ? [],
    extraPackages ? [], # Extra runtime dependencies (e.g. ripgrep, ...)
    extraLuaPackages ? p: [],
    extraPython3Packages ? p: [], # Additional python 3 packages
    withPython3 ? true, # Build Neovim with Python 3 support?
    withRuby ? false, # Build Neovim with Ruby support?
    withNodeJs ? false, # Build Neovim with NodeJS support?
    withSqlite ? true, # Add sqlite? This is a dependency for some plugins
    viAlias ? true,
    vimAlias ? true,
  }: let
    defaultPlugin = {
      plugin = null;
      config = null;
      optional = false;
      runtime = {};
    };

    externalPackages = extraPackages ++ (optionals withSqlite [pkgs.sqlite]);

    # Map all plugins to an attrset { plugin = <plugin>; config = <config>; optional = <tf>; ... }
    normalizedPlugins = map (x:
      defaultPlugin
      // (
        if x ? plugin
        then x
        else {plugin = x;}
      ))
    plugins;

    # This nixpkgs util function creates an attrset
    # that pkgs.wrapNeovimUnstable uses to configure the Neovim build.
    neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
      inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
      plugins = normalizedPlugins;
    };

    nvimRtp = stdenv.mkDerivation {
      name = "nvim-rtp";
      src = ../nvim;

      buildPhase = ''
        mkdir -p $out/nvim
        mkdir -p $out/lua
        rm init.lua
      '';

      installPhase = ''
        cp -r lua $out/lua
        rm -r lua
        cp -r after $out/after
        cp -r * $out/nvim
      '';
    };

  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else 
      drv;

   pluginPath = pkgs.linkFarm "plugin_path" (builtins.map mkEntryFromDrv plugins);
    
    # The final init.lua content that we pass to the Neovim wrapper.
    # It wraps the user init.lua, prepends the lua lib directory to the RTP
    # and prepends the nvim and after directory to the RTP
    # It also adds logic for bootstrapping dev plugins (for plugin developers)
    initLua =
      ''
        vim.loader.enable()
        -- prepend lua directory
        vim.opt.rtp:prepend('${nvimRtp}/lua')
      ''
      # Wrap init.lua
      + (builtins.readFile ../nvim/init.lua)
      + ''
        vim.opt.rtp:prepend('${nvimRtp}/nvim')
        vim.opt.rtp:prepend('${nvimRtp}/after')
        vim.g.sams_super_secret_plugin_path = '${pluginPath}'
      '';

    # Add arguments to the Neovim wrapper script
    extraMakeWrapperArgs = builtins.concatStringsSep " " (
      # Set the NVIM_APPNAME environment variable
      (optional (appName != "nvim" && appName != null && appName != "")
        ''--set NVIM_APPNAME "${appName}"'')
      ++ (optional (externalPackages != [])
        ''--prefix PATH : "${makeBinPath externalPackages}"'')
      ++ (optional withSqlite
        ''--set LIBSQLITE_CLIB_PATH "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
      ++ (optional withSqlite
        ''--set LIBSQLITE "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
    );

    luaPackages = neovim-unwrapped.lua.pkgs;
    resolvedExtraLuaPackages = extraLuaPackages luaPackages;

    # Native Lua libraries
    extraMakeWrapperLuaCArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''--suffix LUA_CPATH ";" "${concatMapStringsSep ";" luaPackages.getLuaCPath resolvedExtraLuaPackages}"'';

    # Lua libraries
    extraMakeWrapperLuaArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''--suffix LUA_PATH ";" "${concatMapStringsSep ";" luaPackages.getLuaPath resolvedExtraLuaPackages}"'';

    neovim-wrapped = pkgs.wrapNeovimUnstable pkgs.neovim (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs =
          escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs
          + " "
          + extraMakeWrapperLuaCArgs
          + " "
          + extraMakeWrapperLuaArgs;
        wrapRc = true;
      });

    isCustomAppName = appName != null && appName != "nvim";
  in
    neovim-wrapped.overrideAttrs (oa: {
      buildPhase =
        oa.buildPhase
        + lib.optionalString isCustomAppName ''
          mv $out/bin/nvim $out/bin/${lib.escapeShellArg appName}
        '';
      meta.mainProgram 
        = if isCustomAppName 
            then appName 
            else oa.meta.mainProgram;
    })
