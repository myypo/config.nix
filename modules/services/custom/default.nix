{ lib, ... }:
{
  imports = lib.readFileModules ./.;
}
