{ lib, ... }:
{
  imports = lib.readAllModules ./.;
}
