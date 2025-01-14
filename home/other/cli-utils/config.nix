{ pkgs, theme }:
{
  home = {
    packages = with pkgs; [
      fd
      bat

      ripgrep
      repgrep

      eza
    ];

    file.".config/ripgrep".text = ''
      go.mod
      go.sum
      node_modules
    '';

    # Have to source it from a file because the prompt symbol padding
    # is not respected when set in hm module options
    sessionVariables.FZF_DEFAULT_OPTS_FILE = "$HOME/.config/fzf";
    file.".config/fzf".source = ./themes/fzf/${theme};
  };

  programs.fzf = {
    enable = true;
  };
}
