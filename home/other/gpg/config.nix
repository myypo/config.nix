{ pkgs }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gtk2;
  };
}
