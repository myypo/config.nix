{ lib, ... }:
let
  allModules = lib.readFileModules ./.;
in
{
  imports = allModules;
}
