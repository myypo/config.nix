{lib}: let
  minLang = builtins.listToAttrs (builtins.map (n: lib.attrsets.nameValuePair n {format = "[\${symbol}](\${style})";}) [
    "bun"
    "buf"
    "c"
    "cmake"
    "cobol"
    "crystal"
    "daml"
    "dart"
    "deno"
    "dotnet"
    "elixir"
    "elm"
    "erlang"
    "fennel"
    "gleam"
    "golang"
    "gradle"
    "haxe"
    "helm"
    "java"
    "julia"
    "kotlin"
    "lua"
    "meson"
    "nim"
    "nix_shell"
    "nodejs"
    "ocaml"
    "opa"
    "perl"
    "php"
    "pulumi"
    "purescript"
    "python"
    "quarto"
    "raku"
    "red"
    "rlang"
    "ruby"
    "rust"
    "solidity"
    "typst"
    "swift"
    "vagrant"
    "vlang"
    "zig"
  ]);
in {
  programs.starship.settings =
    lib.attrsets.recursiveUpdate
    {
      character = {
        success_symbol = "🎀";
        error_symbol = "🎀";
      };
      directory = {
        fish_style_pwd_dir_length = 1;
        format = "[$path]($style)[$read_only]($read_only_style)";
        style = "bold purple";
        read_only_style = "bold red";
      };
      git_branch = {
        format = " [⟨](bold yellow)[$branch](bold red)";
      };
      git_status = {
        format = "[$modified](bold purple)$ahead_behind[⟩]($bold yellow) ";
        ahead = "[ ↑\${count}](bold green)";
        diverged = "[ \${ahead_count}](bold yellow) [↓\${behind_count}](bold red)";
        behind = "[ ↓\${count}](bold red)";
        modified = " 󰫢 ";
      };
      continuation_prompt = "[::: ](bold purple)";

      package.disabled = true;
      cmd_duration.disabled = true;
      battery.disabled = true;
      direnv.disabled = true;

      lua.symbol = " ";
      rust.symbol = "󱘗 ";
      nix_shell.symbol = "󱄅 ";
      golang.symbol = " ";
      c.symbol = " ";
    }
    minLang;
}
