{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
  };
}
