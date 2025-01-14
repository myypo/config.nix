{ lib }:
rec {
  getCfgs =
    {
      config,
      type,
      name,
    }:
    let
      typesList = if builtins.isList type then type else [ type ];
      cfgPath = typesList ++ [ name ];

      commonArgs = {
        hostName = config.myypo.hostName;
        escalCmd = config.myypo.security.privilege-elevation.cmd;
      };
      userArgs = builtins.mapAttrs (
        _: user:
        (lib.attrsets.attrByPath cfgPath { } user)
        // {
          _common = lib.attrsets.attrByPath (typesList ++ [ "common" ]) { } user;
        }
        // commonArgs
      ) config.myypo.users;
    in
    userArgs;

  cfgIsEnabled =
    {
      config,
      type,
      name,
    }:
    let
      enableVals =
        let
          cfgs = getCfgs { inherit config type name; };
        in
        builtins.attrValues (
          builtins.mapAttrs (
            _: cfg:
            (
              let
                enable = lib.attrsets.attrByPath [ "enable" ] null cfg;
                enableAll = lib.attrsets.attrByPath [ "_common" "enableAll" ] null cfg;
              in
              if ((enable == null) && (enableAll == null)) then
                false
              else if enable == null then
                enableAll
              else
                enable
            )
          ) cfgs
        );
    in
    builtins.length (builtins.filter (enable: enable == true) enableVals) > 0;

  getFullUserCfg =
    {
      userCfg,
      type,
      name,
    }:
    let
      typesList = if builtins.isList type then type else [ type ];

      cfgPath = typesList ++ [ name ];
    in
    with lib;
    (attrsets.attrByPath cfgPath { } userCfg)
    // {
      _common = attrsets.attrByPath (typesList ++ [ "common" ]) { } userCfg;
    };

  userCfgIsEnabled =
    {
      userCfg,
      type,
      name,
    }:
    let
      fullUserCfg = getFullUserCfg { inherit userCfg type name; };
      enable = lib.attrsets.attrByPath [ "enable" ] null fullUserCfg;
      enableAll = lib.attrsets.attrByPath [ "_common" "enableAll" ] null fullUserCfg;
    in
    if ((enable == null) && (enableAll == null)) then
      false
    else if enable == null then
      enableAll
    else
      enable;

  mkIfFall =
    cfg:
    let
      enable =
        if (builtins.hasAttr "enable" cfg) && (cfg.enable != null) then
          cfg.enable
        else if
          (lib.attrsets.hasAttrByPath [ "_common" "enableAll" ] cfg) && (cfg._common.enableAll != null)
        then
          cfg._common.enableAll
        else
          false;
    in
    lib.mkIf enable;

  makeHomeModule =
    {
      pkgs,
      config,
      configPath,
      type,
      name,
      addArgsFn ? userName: cfg: { },
      nixosConfig ? { },
      enable ? cfgIsEnabled { inherit config type name; },
      mkIfFn ? mkIfFall,
    }:
    let
      cfgs = getCfgs { inherit config type name; };

      hmConfig = {
        home-manager.users = builtins.mapAttrs (
          userName: cfg:
          mkIfFn cfg (
            let
              configArgs =
                let
                  requiredArgs = builtins.functionArgs (import configPath);
                  passedArgs = builtins.intersectAttrs requiredArgs (
                    {
                      inherit lib pkgs;
                    }
                    // (lib.attrsets.attrByPath [ "_common" ] { } cfg)
                    // cfg
                    // (addArgsFn userName cfg)
                  );
                  missingArgs = lib.attrsets.filterAttrs (
                    n: _: (!builtins.hasAttr n passedArgs || passedArgs.${n} == null)
                  ) requiredArgs;
                in
                passedArgs
                // (builtins.mapAttrs (
                  n: _: lib.attrsets.attrByPath [ n ] null config.myypo.users.${userName}
                ) missingArgs);
            in
            import configPath configArgs
          )
        ) cfgs;
      };
    in
    lib.mkIf enable (hmConfig // nixosConfig);

  # Because pkgs.substituteAll is weird
  writeScript =
    {
      pkgs,
      name,
      cfg,
      src,
    }:
    let
      settings = cfg.settings or { };

      from = builtins.map (s: "@${s}@") (builtins.attrNames settings);
      to = builtins.attrValues settings;

      check =
        let
          file = builtins.readFile src;
        in
        builtins.foldl'
          (
            acc: curr:
            if (builtins.match ".*?${curr}.*?" file) != null then
              acc
            else
              {
                found = false;
                missVals = acc.missVals ++ [ (builtins.replaceStrings [ "@" ] [ "" ] curr) ];
              }
          )
          {
            found = true;
            missVals = [ ];
          }
          from;

      finalScript = builtins.replaceStrings from to (builtins.readFile src);
    in
    if check.found then
      pkgs.writeShellScriptBin name finalScript
    else
      abort (
        "the following values to be replaced were not found in the script ${name}: "
        + (builtins.concatStringsSep ", " check.missVals)
      );

  valueOrUserDefault =
    {
      config,
      name,
      val,
      userName,
    }:
    if val == null then config.myypo.users.${userName}.${name} else val;

  getMeta = type: name: (import ../home/${type}/${name}/meta.nix);

  # Actually mkOutOfStoreSymlink copied from home-manager
  makeOutOfStore =
    pkgs: path:
    let
      pathStr = builtins.toString path;
      # Figures out a valid Nix store name for the given path.
      storeFileName =
        path:
        let
          # All characters that are considered safe. Note "-" is not
          # included to avoid "-" followed by digit being interpreted as a
          # version.
          safeChars =
            [
              "+"
              "."
              "_"
              "?"
              "="
            ]
            ++ lib.lowerChars
            ++ lib.upperChars
            ++ lib.stringToCharacters "0123456789";

          empties = l: lib.genList (x: "") (lib.length l);

          unsafeInName = lib.stringToCharacters (lib.replaceStrings safeChars (empties safeChars) path);

          safeName = lib.replaceStrings unsafeInName (empties unsafeInName) path;
        in
        "hm_" + safeName;

      name = storeFileName (builtins.baseNameOf pathStr);
    in
    pkgs.runCommandLocal name { } ''ln -s ${lib.strings.escapeShellArg pathStr} $out'';
}
