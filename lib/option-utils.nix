{lib}:
with lib; {
  mkNullableEnableOption = name:
    mkOption {
      default = null;
      example = true;
      description = "Whether to enable ${name}.";
      type = lib.types.nullOr lib.types.bool;
    };

  setSubOpts = {userOpts}: {
    myypo.users = mkOption {
      type = types.attrsOf (types.submodule userOpts);
    };
  };
}
