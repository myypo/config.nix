{ lib, ... }:
let
  dirModules = lib.readDirModules ./.;
in
{
  imports = dirModules;
}
