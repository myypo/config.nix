{ pkgs }:
{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
