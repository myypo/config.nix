{
  lib,
  inputs,
  self,
  ...
}: let
  extraPkgs = import "${self}/pkgs";

  modules = "${self}/modules";
  home = "${self}/home";
  profiles = "${self}/profiles";

  hosts = lib.attrsets.filterAttrs (_: v: v == "directory") (builtins.readDir "${self}/hosts");

  specialArgs = {
    inherit inputs self;

    lib = inputs.nixpkgs.lib.extend (
      final: prev: (import ../lib {lib = final;})
    );
  };
in {
  imports = specialArgs.lib.readFileModules ./.;

  config = {
    systems = ["x86_64-linux" "aarch64-linux"];

    flake = {
      overlays.default = extraPkgs.overlay;

      nixosConfigurations =
        builtins.mapAttrs (
          hostName: _: let
            host = "${self}/hosts/${hostName}";

            settings = {
              myypo = {inherit hostName;} // import "${host}/settings" {inherit lib;};
            };
          in
            lib.nixosSystem {
              specialArgs = settings // specialArgs;

              modules = [
                host

                modules

                profiles

                home
              ];
            }
        )
        hosts;
    };
  };
}