{
  description = ''
    Wen       ⠀⠀⢀⣀⠤⠤⢤⣄⡤⠤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀ rember
    day     ⢀⣠⠤⠀⡴⠋⠀⠀⠀⠀⠀⠉⠒⢌⠉⠛⣽⡲⣄⠀⠀⠀⠀happy
    dark  ⣠⠾⠉⠀⠀⠀⠀⣄⠀⠀⠀⠀⠀⢀⣀⠀⣥⡤⠜⠊⣈⢻⣆⠀⠀day
     ⠀⠀⠀⣠⠾⠁⠔⠨⠂⠀⢀⠘⡜⡦⣀⡴⡆⠛⠒⠙⡴⡀⠘⡆⠀⠀⠛⡙⢷⡀⠀⠀⠀
     ⠀⠀⡴⠃⠀⠀⠀⠀⢀⣠⡼⠟⡏⡏⠙⣇⢸⡄⠀⠀⢹⠏⠁⢹⡳⣤⠀⠘⡌⣷⠀⠀⠀
     ⠀⣸⠃⠀⡠⠖⢲⠀⠀⣸⠃⢰⡇⡇⠀⢸⣌⣇⢀⠀⣸⣷⣀⡼⢣⡇⠀⠀⢹⣹⠀⠀⠀
     ⠀⡏⠀⡜⠁⠀⠁⠀⡰⢃⣴⣷⢟⣿⡟⡲⠟⠻⠊⠙⠃⣼⣿⣻⣾⡇⠀⠀⢸⡿⠀⠀⠀
     ⠀⡇⠰⡇⠀⢀⡠⠞⡗⢩⡟⢸⡏⠀⢹⡇⠀⠀⠀⠀⠀⢸⣿⠉⢱⣿⠠⢤⣟⠁⠀⠀⠀
     ⠀⣧⠀⠉⠉⠉⠀⢸⠦⡸⡅⢸⣏⠒⣱⠇⠀⠀⠀⠀⠀⠀⢿⣅⡽⠙⢦⠀⢈⣳⡄⠀⠀
     ⠀⡟⠀⠀⠀⠀⠀⠘⠀⣘⡌⣀⡉⠉⠁⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠁⠀⡸⠛⠜⡷⣠⠀
     ⢸⠃⠀⠀⠀⠀⣀⡫⣿⣮⡀⠀⠀⠀⠀⠀⢠⠤⠶⡦⡤⠀⠀⠀⠀⠀⢠⠇⡀⠸⣧⣤⡆
     ⡟⠀⠀⠀⠀⠀⠀⡄⢠⠉⢇⠀⡄⠀⠀⠀⠘⢦⣀⡸⠃⠀⠀⠀⢀⡠⠋⠈⠛⢷⡖⠋⠀
     ⡇⢀⠀⠀⠀⠀⠀⢇⠀⢕⣺⣿⣅⡀⠀⠀⠀⠀⠀⠀⢀⣠⠤⠒⠉⠀⢠⣄⡶⠋⠀⠀⠀
     ⠻⢾⣼⣦⣀⠀⡄⠈⠓⢦⣼⣿⣍⠉⠻⣄⠀⢈⠏⠉⣿⣦⡀⠀⢀⣠⠾⠀⠀⠀⠀⠀⠀
     ⠀⠀⠈⠀⠉⠙⠓⠛⣦⡼⠘⣿⣿⣷⣤⣀⣹⠞⢤⣼⣿⣿⠈⢶⡋⠁⠀⠀⠀⠀⠀⠀⠀
  '';

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};

  inputs = {
    ### NixOS and home-manager ###
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ### Hyprland ###
    # TODO: temporary fix: https://github.com/hyprwm/Hyprland/issues/5891
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    ### Secrets ###
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    ### Neovim ###
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    ### Rust overlay ###
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    ### Dev ###
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";

    ### Utils ###
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };
}
