{ lib, ... }:
{
  imports = lib.readDirModules ./.;
}
