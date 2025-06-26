{ inputs, pkgs }:
{
  # programs.bacon = {
  #   enable = true;
  #   settings = {
  #   };
  # };

  home.packages = with pkgs; [
    cargo-info

    rust-analyzer-nightly

    # (pkgs.callPackage (
    #   {
    #     lib,
    #     fetchFromGitHub,
    #     perl,
    #     openssl,
    #   }:
    #   rustPlatform.buildRustPackage (finalAttrs: {
    #     name = "bacon-ls";
    #
    #     src = fetchFromGitHub {
    #       owner = "crisidev";
    #       repo = finalAttrs.name;
    #       rev = "HEAD";
    #       hash = "sha256-E07muFF4/lsQosQ7k77eV7PKwo2aXDh2FhrwU2jTCBc=";
    #     };
    #
    #     useFetchCargoVendor = true;
    #     cargoHash = "sha256-BfEeFdeL2d9wJ6RJHRXmZKTP8aPmKK+FEAK0Bd4+idU=";
    #
    #     buildInputs = [
    #       perl
    #       openssl
    #     ];
    #     nativeBuildInputs = [
    #       perl
    #       openssl
    #     ];
    #
    #   })
    # ) { })

    pkg-config
    openssl

    (fenix.complete.withComponents [
      "cargo"
      "rust-src"
      "rust-std"
      "rustc"
      "rustfmt"
    ])
  ];
}
