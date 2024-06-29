{pkgs}: {
  programs.sftpman = {
    enable = true;
  };

  home.packages = with pkgs; [
    sshfs
  ];
}
