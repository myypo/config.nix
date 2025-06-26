{
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          git

          nixfmt-rfc-style
          deadnix
          nil

          stylua
          nodePackages.prettier
          black
          shfmt
          shellcheck

          sops
          age
          ssh-to-age
          git-crypt
          gnupg
          pinentry-tty
        ];
      };
    };
}
