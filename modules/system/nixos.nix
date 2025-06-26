{
  lib,
  self,
  inputs,
  pkgs,
  ...
}:
let
  base = "/etc/nixpkgs/channels";
  nixpkgsPath = "${base}/nixpkgs";
in
{
  nix = {
    package = pkgs.nixVersions.latest;

    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      download-buffer-size = 500000000; # 500 MB
      keep-derivations = true;
      keep-outputs = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      # Make our overlays set in config.flake.overlays.default work
      self.overlays.default

      # Make pkgs from small-unstable accessible by referencing pkgs.small-unstable
      (final: _prev: {
        small-unstable = import inputs.small-unstable-nixpkgs { inherit (final) system config; };
      })
    ];
  };

  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = lib.mkDefault "23.05";
  };
}
