{pkgs}: {
  home.packages = with pkgs; [
    slack
    postman
    buttercup-desktop

    restate
  ];
}
