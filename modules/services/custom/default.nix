{lib, ...}: {
  imports = lib.readFileModules ./.;
}