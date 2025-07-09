{
  lib,
  pkgs,
  flakePath,
  addons,
}:
let
  cfg = addons.quickshell;
in
(lib.mkIf cfg.enable {
  home.packages = with pkgs; [ quickshell ];

  xdg.configFile."quickshell".source =
    (lib.makeOutOfStore pkgs) "${flakePath}/profiles/hyprland/addons/quickshell/themes/${cfg.theme}";

  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    "${pkgs.quickshell}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml"
  ];
})
