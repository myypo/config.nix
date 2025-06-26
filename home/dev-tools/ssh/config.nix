{ pkgs }:
{
  programs.sftpman = {
    enable = true;
  };

  services.ssh-agent.enable = true;

  home.packages = with pkgs; [ sshfs ];
}
