{ lib }:
{
  makeNullableEnableOption =
    name:
    lib.mkOption {
      default = null;
      example = true;
      description = "Whether to enable ${name}.";
      type = lib.types.nullOr lib.types.bool;
    };

  makeHomeOpts = userOpts: {
    myypo.users = lib.mkOption { type = lib.types.attrsOf (lib.types.submodule userOpts); };
  };
}
