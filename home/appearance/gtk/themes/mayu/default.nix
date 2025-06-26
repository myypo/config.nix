{ pkgs, fontSize }:
{
  gtk = {
    theme = {
      name = "Colloid-Pink-Dark";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = [ "pink" ];
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        tweaks = [ "black" ];
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "flamingo";
        flavor = "frappe";
      };
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.jetbrains-mono;
      size = fontSize;
    };
  };
}
