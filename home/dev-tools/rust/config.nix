{ inputs, pkgs }:
{
  home.packages = with pkgs; [
    rust-analyzer-nightly

    pkg-config
    openssl

    leptosfmt
    (fenix.complete.withComponents [
      "cargo"
      "rust-src"
      "rust-std"
      "rustc"
      "rustfmt"
    ])
  ];
}
