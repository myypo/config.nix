{ lib }:
with lib;
rec {
  readFileModules =
    path:
    builtins.map (file: path + "/${file}") (
      builtins.attrNames (
        attrsets.filterAttrs (n: v: n != "default.nix" && n != "meta.nix" && v == "regular") (
          builtins.readDir path
        )
      )
    );

  readDirModules =
    path:
    builtins.map (dir: path + "/${dir}") (
      builtins.attrNames (attrsets.filterAttrs (_: v: v == "directory") (builtins.readDir path))
    );

  readAllModules = path: (readFileModules path) ++ (readDirModules path);
}
