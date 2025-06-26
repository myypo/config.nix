{
  pkgs,
  theme,
  fontSize,
}:
{
  imports = [ (import ./themes/${theme} { inherit pkgs fontSize; }) ];

  gtk = {
    enable = true;

    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;

      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };

    gtk2 = {
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };
  };
}
