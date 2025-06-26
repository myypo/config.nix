{
  lib,
  inputs,
  pkgs,
  config,
  ...
}:
let
  userOpts = {
    options.editors.nvim = {
      enable = lib.makeNullableEnableOption "nvim";

      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
    };
  };
in
{
  options = lib.makeHomeOpts userOpts;

  config = lib.makeHomeModule {
    inherit pkgs config;
    configPath = ./config.nix;
    type = "editors";
    name = "nvim";
    nixosConfig = {
      sops.secrets = lib.trivial.pipe config.myypo.users [
        builtins.attrNames
        (builtins.concatMap (owner: [
          {
            name = "${owner}_OPENROUTER_API_KEY";
            value = {
              inherit owner;
            };
          }
          {
            name = "${owner}_GEMINI_API_KEY";
            value = {
              inherit owner;
            };
          }
          {
            name = "${owner}_TAVILY_API_KEY";
            value = {
              inherit owner;
            };
          }
        ]))
        builtins.listToAttrs
      ];

      nixpkgs.overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    };
    addArgsFn = userName: cfg: {
      inherit userName;
      secrets = config.sops.secrets;
      isMainEditor = config.myypo.users.${userName}.mainEditor == "nvim";
      mainShell = config.myypo.users.${userName}.mainShell;
      githubUserName = config.myypo.users.${userName}.githubUserName;

      sourceNvimFiles =
        {
          mkOutOfStoreSymlink,
          flakePath,
          subs,
          theme,
          extra,
        }:
        let
          plugins =
            let
              fromFn = fsubs: builtins.map (s: "@${s}@") (builtins.attrNames fsubs);
              toFn = fsubs: builtins.attrValues fsubs;

              baseDestPath = ".config/nvim";
              baseSrcPath = "${flakePath}/home/editors/nvim";

              pluginsPath = "${baseSrcPath}/lua/plugins";

              pluginsFiles =
                let
                  filesPluginsFolder = builtins.attrNames (
                    lib.attrsets.filterAttrs (_: v: v == "regular") (builtins.readDir pluginsPath)
                  );
                  luaFiles = builtins.filter (f: lib.strings.hasSuffix ".lua" f) filesPluginsFolder;
                  plugins = lib.lists.partition (f: lib.strings.hasPrefix "_" f) luaFiles;
                in
                {
                  plain = plugins.wrong;
                  subst = plugins.right;
                };
            in
            lib.attrsets.foldlAttrs
              (
                acc: _: v:
                acc // v
              )
              { }
              {
                setup = {
                  "${baseDestPath}/init.lua".text = builtins.replaceStrings (fromFn subs."_init.lua") (toFn
                    subs."_init.lua"
                  ) (builtins.readFile "${baseSrcPath}/_init.lua");
                  "${baseDestPath}/lazy-lock.json".source = mkOutOfStoreSymlink "${baseSrcPath}/lazy-lock.json";

                  "${baseDestPath}/lua/base".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/base";
                  "${baseDestPath}/lua/luasnip".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/luasnip";

                  "${baseDestPath}/lua/plugins/colorscheme.lua".source =
                    mkOutOfStoreSymlink "${baseSrcPath}/lua/themes/${theme}/colorscheme.lua";
                  "${baseDestPath}/lua/plugins/lualine.lua".source =
                    mkOutOfStoreSymlink "${baseSrcPath}/lua/themes/${theme}/lualine.lua";

                  "${baseDestPath}/after".source = mkOutOfStoreSymlink "${baseSrcPath}/after";
                };

                substPlugins = builtins.listToAttrs (
                  builtins.map (
                    f:
                    let
                      from = fromFn subs.${f};
                      to = toFn subs.${f};
                      contents = builtins.readFile "${pluginsPath}/${f}";
                    in
                    {
                      name = "${baseDestPath}/lua/plugins/${f}";
                      value = {
                        text = builtins.replaceStrings from to contents;
                      };
                    }
                  ) pluginsFiles.subst
                );

                plainPlugins = builtins.listToAttrs (
                  builtins.map (f: {
                    name = "${baseDestPath}/lua/plugins/${f}";
                    value = {
                      source = mkOutOfStoreSymlink "${pluginsPath}/${f}";
                    };
                  }) pluginsFiles.plain
                );
              };
        in
        plugins // extra;
    };
  };
}
