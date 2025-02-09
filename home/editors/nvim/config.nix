{
  lib,
  pkgs,
  flakePath,
  theme,
  isMainEditor,
  githubUserName,
  sourceNvimFiles,
}:
let
  sessionVariables =
    if isMainEditor then
      {
        EDITOR = "nvim";
        # Used by shell for editing command line, it is actually a minimal nvim config
        # that I have to alias as vim because of fish command editing having some behavior hardcoded
        VISUAL = "vim";
      }
    else
      null;

  cfg = { };
  kitty_pager = lib.writeScript {
    inherit pkgs cfg;
    name = "kitty_pager";
    src = ./scripts/kitty_pager.sh;
  };
  minvim = lib.writeScript {
    inherit pkgs cfg;
    name = "vim";
    src = ./scripts/minvim.sh;
  };
in
{
  home.sessionVariables = sessionVariables;

  programs = {
    neovim = {
      enable = true;
      plugins = with pkgs; [
        vimPlugins.telescope-fzf-native-nvim
        vimPlugins.nvim-treesitter.withAllGrammars
      ];
    };
  };
  xdg.configFile."nvim/parser".source = "${
    pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
    }
  }/parser";

  home = {
    packages = with pkgs; [
      # Minimal nvim to use as a pager/command editor
      kitty_pager
      minvim

      # Debug
      lldb
      vscode-extensions.vadimcn.vscode-lldb

      # Build
      gnumake
      deno
    ];
  };

  home.file =
    let
      mkOutOfStoreSymlink = lib.makeOutOfStore pkgs;
    in
    sourceNvimFiles {
      inherit mkOutOfStoreSymlink theme flakePath;

      subs = {
        # Putting underscore before all files with substitutions
        "_init.lua" = {
          github-username = githubUserName;
        };
        "_rustacean.lua" = {
          vscode-lldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
        };
      };

      extra =
        let
          baseDestPath = ".config/minvim";
          baseSrcPath = "${flakePath}/home/editors/nvim";
        in
        {
          # Minimal setup for kitty-pager and command editing
          "${baseDestPath}/init.lua".source = mkOutOfStoreSymlink "${baseSrcPath}/_init.lua";
          # TODO: doing it this way isn't really ergonomic for me
          # "${baseDestPath}/lazy-lock.json".source = mkOutOfStoreSymlink "${baseSrcPath}/lazy-lock.json";

          "${baseDestPath}/lua/kitty-pager.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/minvim/kitty-pager.lua";
          "${baseDestPath}/lua/base/init.lua".source = mkOutOfStoreSymlink "${baseSrcPath}/lua/base/init.lua";
          "${baseDestPath}/lua/base/mappings.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/lua/base/mappings.lua";
          "${baseDestPath}/lua/base/autocmd.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/minvim/base/min_autocmd.lua";
          "${baseDestPath}/lua/base/options.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/lua/base/options.lua";
          "${baseDestPath}/lua/plugins/leap.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/lua/plugins/leap.lua";
          "${baseDestPath}/lua/plugins/colorscheme.lua".source =
            mkOutOfStoreSymlink "${baseSrcPath}/lua/themes/${theme}/colorscheme.lua";
        };
    };
}
