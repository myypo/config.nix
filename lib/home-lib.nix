{lib}: rec {
  getCfgs = {
    config,
    type,
    name,
  }: let
    typesList =
      if builtins.isList type
      then type
      else [type];

    cfgPath = typesList ++ [name];
  in
    with lib;
      builtins.mapAttrs (
        _: user:
          (attrsets.attrByPath cfgPath {} user)
          // {_common = attrsets.attrByPath (typesList ++ ["common"]) {} user;}
      )
      config.myypo.users;

  cfgIsEnabled = {
    config,
    type,
    name,
  }: let
    enableVals = let
      cfgs = getCfgs {inherit config type name;};
    in
      builtins.attrValues (builtins.mapAttrs (_: cfg: (
          let
            enable = lib.attrsets.attrByPath ["enable"] null cfg;
            enableAll = lib.attrsets.attrByPath ["_common" "enableAll"] null cfg;
          in
            if ((enable == null) && (enableAll == null))
            then false
            else if enable == null
            then enableAll
            else enable
        ))
        cfgs);
  in
    builtins.length (builtins.filter (enable: enable == true) enableVals) > 0;

  getFullUserCfg = {
    userCfg,
    type,
    name,
  }: let
    typesList =
      if builtins.isList type
      then type
      else [type];

    cfgPath = typesList ++ [name];
  in
    with lib;
      (attrsets.attrByPath cfgPath {} userCfg)
      // {_common = attrsets.attrByPath (typesList ++ ["common"]) {} userCfg;};

  userCfgIsEnabled = {
    userCfg,
    type,
    name,
  }: let
    fullUserCfg = getFullUserCfg {
      inherit userCfg type name;
    };
    enable = lib.attrsets.attrByPath ["enable"] null fullUserCfg;
    enableAll = lib.attrsets.attrByPath ["_common" "enableAll"] null fullUserCfg;
  in
    if ((enable == null) && (enableAll == null))
    then false
    else if enable == null
    then enableAll
    else enable;

  mkIfFall = cfg: let
    enable =
      if (builtins.hasAttr "enable" cfg) && (cfg.enable != null)
      then cfg.enable
      else if (lib.attrsets.hasAttrByPath ["_common" "enableAll"] cfg) && (cfg._common.enableAll != null)
      then cfg._common.enableAll
      else false;
  in
    if enable
    then lib.mkIf true
    else lib.mkIf false;

  # Because pkgs.substituteAll is weird
  writeScript = {
    pkgs,
    name,
    cfg,
    src,
  }: let
    settings = cfg.settings or {};

    from = builtins.map (s: "@${s}@") (builtins.attrNames settings);
    to = builtins.attrValues settings;

    check = let
      file = builtins.readFile src;
    in
      builtins.foldl' (
        acc: curr:
          if (builtins.match ".*?${curr}.*?" file) != null
          then acc
          else {
            found = false;
            missVals = acc.missVals ++ [(builtins.replaceStrings ["@"] [""] curr)];
          }
      )
      {
        found = true;
        missVals = [];
      }
      from;

    finalScript = builtins.replaceStrings from to (builtins.readFile src);
  in
    if check.found
    then pkgs.writeShellScriptBin name finalScript
    else abort ("the following values to be replaced were not found in the script ${name}: " + (builtins.concatStringsSep ", " check.missVals));

  valueOrUserDefault = {
    config,
    name,
    val,
    userName,
  }:
    if val == null
    then config.myypo.users.${userName}.${name}
    else val;

  getMeta = type: name: (import ../home/${type}/${name}/meta.nix);

  sourceNvimFiles = {
    mkOutOfStoreSymlink,
    flake_path,
    subs,
    theme,
    extra,
  }: let
    plugins = let
      fromFn = fsubs: builtins.map (s: "@${s}@") (builtins.attrNames fsubs);
      toFn = fsubs: builtins.attrValues fsubs;

      baseDestPath = ".config/nvim";
      baseSrcPath = "${flake_path}/home/editors/nvim";

      pluginsPath = "${baseSrcPath}/lua/plugins";

      pluginsFiles = let
        filesPluginsFolder = builtins.attrNames (lib.attrsets.filterAttrs (_: v: v == "regular") (builtins.readDir pluginsPath));
        luaFiles = builtins.filter (f: lib.strings.hasSuffix ".lua" f) filesPluginsFolder;
        plugins = lib.lists.partition (f: lib.strings.hasPrefix "_" f) luaFiles;
      in {
        plain = plugins.wrong;
        subst = plugins.right;
      };
    in
      lib.attrsets.foldlAttrs (acc: _: v: acc // v) {} {
        setup = {
          "${baseDestPath}/init.lua".text = builtins.replaceStrings (fromFn subs."_init.lua") (toFn subs."_init.lua") (builtins.readFile "${baseSrcPath}/_init.lua");
          # TODO: doing it this way isn't really ergonomic for me
          # "${baseDestPath}/lazy-lock.json".source = "${baseSrcPath}/lazy-lock.json";

          "${baseDestPath}/lua/base".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/base";
          "${baseDestPath}/lua/luasnip".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/luasnip";

          "${baseDestPath}/lua/plugins/colorscheme.lua".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/themes/${theme}/colorscheme.lua";
          "${baseDestPath}/lua/plugins/lualine.lua".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/themes/${theme}/lualine.lua";
        };

        substPlugins = builtins.listToAttrs (builtins.map (f: let
            from = fromFn subs.${f};
            to = toFn subs.${f};
            contents = builtins.readFile "${pluginsPath}/${f}";
          in {
            name = "${baseDestPath}/lua/plugins/${f}";
            value = {text = builtins.replaceStrings from to contents;};
          })
          pluginsFiles.subst);

        plainPlugins = builtins.listToAttrs (builtins.map (f: {
            name = "${baseDestPath}/lua/plugins/${f}";
            value = {source = mkOutOfStoreSymlink "${pluginsPath}/${f}";};
          })
          pluginsFiles.plain);
      };
  in
    plugins // extra;
}
