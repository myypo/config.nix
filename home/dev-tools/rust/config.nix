{
  inputs,
  pkgs,
}: {
  home.packages = with pkgs; [
    rust-analyzer-nightly

    pkg-config
    openssl

    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rust-std"
      "rustc"
      "rustfmt"
    ])
  ];
}
