{
  lib,
  self,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
  ];

  nix = {
    package = pkgs.nixVersions.git;

    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      keep-derivations = true;
      keep-outputs = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      # Make our overlays set in config.flake.overlays.default work
      self.overlays.default
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
