{pkgs}: let
  rescript-analysis = pkgs.ocamlPackages.buildDunePackage rec {
    pname = "analysis";
    version = "1.58.0";

    minimalOCamlVersion = "4.04";

    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "rescript-vscode";
      rev = version;
      hash = "sha256-v+qCVge57wvA97mtzbxAX9Fvi7ruo6ZyIC14O8uWl9Y=";
    };

    nativeBuildInputs = with pkgs; [ocamlPackages.cppo];
  };

  rescript-language-server = pkgs.buildNpmPackage rec {
    pname = "rescript-language-server";
    version = "1.58.0";

    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "rescript-vscode";
      rev = version;
      hash = "sha256-v+qCVge57wvA97mtzbxAX9Fvi7ruo6ZyIC14O8uWl9Y=";
    };

    sourceRoot = "${src.name}/server";
    npmDepsHash = "sha256-GXbYYtrNRbv/yl1U/171+I9+jwWDMA6ZA9lHvGAhM98=";

    nativeBuildInputs = [pkgs.esbuild];
    buildPhase = ''
      npm install
      mkdir analysis_binaries/linux
      cp ${rescript-analysis}/bin/rescript-editor-analysis analysis_binaries/linux/rescript-editor-analysis.exe
      esbuild src/cli.ts --bundle --sourcemap --outfile=out/cli.js --format=cjs --platform=node --loader:.node=file --minify
    '';
  };
in {
  home.packages = [
    rescript-analysis
    rescript-language-server
  ];
}
