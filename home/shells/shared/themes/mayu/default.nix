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
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold purple";
        read_only_style = "bold red";
      };
      git_branch = {
        format = "[⟨](bold yellow)[$branch](bold red)";
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

      aws.symbol = "  ";
      rust.symbol = "󱘗 ";
      purescript.symbol = " ";
      buf.symbol = " ";
      c.symbol = " ";
      conda.symbol = " ";
      crystal.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " 󰌾";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      fennel.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      guix_shell.symbol = " ";
      haskell.symbol = " ";
      haxe.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      ocaml.symbol = " ";
      package.symbol = "󰏗 ";
      perl.symbol = " ";
      php.symbol = " ";
      pijul_channel.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      ruby.symbol = " ";

      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        Arch = " ";
        Artix = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
      };
    }
    minLang;
}
