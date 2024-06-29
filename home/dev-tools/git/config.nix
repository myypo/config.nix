{
  lib,
  personalUserName,
  personal_email,
  personal_signing_key,
  alt_git_identity_list,
}: {
  programs.git = {
    enable = true;

    # Plugin for working with large files
    lfs.enable = true;

    userName = personalUserName;
    userEmail = personal_email;

    signing = {
      key = personal_signing_key;

      signByDefault = false;
    };

    includes =
      builtins.map (id: {
        condition = "gitdir:~/code/${id.alias}/**";
        contents = {
          user.name = id.username;
          user.email = id.email;
          user.key = id.signing_key;
        };
      })
      alt_git_identity_list;

    ignores = [
      "*~"
      "*.swp"
      "*result*"
      ".direnv"
      "node_modules"
      "target"
      ".luarc.json"
    ];

    extraConfig = {
      push = {autoSetupRemote = true;};
      init.defaultBranch = "main";

      branch.autosetupmerge = "true";
      merge.stat = "true";

      push.default = "current";
      pull.default = "current";

      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };
  };
}
