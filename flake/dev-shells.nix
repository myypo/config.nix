{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        git

        alejandra
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
      ];

      shellHook = ''
        export EDITOR=vim
      '';
    };
  };
}
