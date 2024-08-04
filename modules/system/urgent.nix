{
  pkgs,
  inputs,
  ...
}: {
  ### Place to put urgent fixes for all of the systems ###

  nixpkgs.overlays = [
    # TODO: https://github.com/hyprwm/xdg-desktop-portal-hyprland/releases/tag/v1.3.3
    (final: prev: {
      xdg-desktop-portal-hyprland = prev.xdg-desktop-portal-hyprland.overrideAttrs (old: rec {
        src = pkgs.fetchFromGitHub {
          owner = "hyprwm";
          repo = "xdg-desktop-portal-hyprland";
          rev = "v${version}";
          hash = "sha256-cyyxu/oj4QEFp3CVx2WeXa9T4OAUyynuBJHGkBZSxJI=";
        };
        patches = [];
        version = "1.3.3";
      });
    })
  ];
}
