{ pkgs, ... }:
let
  pname = "Marisa-Kirisame";
in
{
  home.pointerCursor = {
    # TODO: sadly it is pretty broken, can't change cursor size and it leaves a trace
    package = pkgs.stdenvNoCC.mkDerivation rec {
      inherit pname;
      name = pname;

      nativeBuildInputs = with pkgs; [
        xcur2png
        hyprcursor
      ];

      src = ./.;

      installPhase = ''
        runHook preInstall

        local iconsDir="$out"/share/icons
        mkdir -p "$iconsDir"

        tar -xzvf marisa-kirisame-cursors.tar.gz
        mv Marisa-Kirisame "$iconsDir/Marisa-Kirisame"

        mkdir -p "$iconsDir/Marisa-Kirisame/hyprcursors"
        hyprcursor-util -x "$iconsDir/Marisa-Kirisame" -o "$iconsDir/Marisa-Kirisame"
        hyprcursor-util -c "$iconsDir/Marisa-Kirisame/extracted_Marisa-Kirisame" -o "$iconsDir/Marisa-Kirisame"
        mv "$iconsDir/Marisa-Kirisame/theme_Extracted Theme/hyprcursors" "$iconsDir/Marisa-Kirisame"

        echo "name = marisa-kirisame-cursors
        description = Touhou
        version = \"v0.1.0\"
        cursors_directory = hyprcursors" > "$iconsDir/Marisa-Kirisame/manifest.hl"
        rm -rf "$iconsDir/Marisa-Kirisame/extracted_Marisa-Kirisame"
        rm -rf "$iconsDir/Marisa-Kirisame/theme_Extracted Theme"


        runHook postInstall
      '';
    };

    name = pname;
  };

  home.sessionVariables = {
    HYPRCURSOR_THEME = pname;
  };
}
