{pkgs}: {
  home.packages = with pkgs; [
    haskell-language-server
    stylish-haskell
  ];
}