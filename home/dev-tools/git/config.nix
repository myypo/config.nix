{
  lib,
  githubUserName,
  personal_email,
  personal_signing_key,
  alt_git_identity_list,
}: {
  programs.git = {
    enable = true;

    # Plugin for working with large files
    lfs.enable = true;

    userName = githubUserName;
    userEmail = personal_email;

    signing = {
      key = personal_signing_key;

      signByDefault = false;
    };

    includes =
      builtins.map (id: {
        condition = "gitdir:~/code/${id.alias}/**";
        contents = {
          user.name =
            if id ? username
            then id.username
            else null;
          user.email =
            if id ? email
            then id.email
            else null;
          user.key =
            if id ? signing_key
            then id.signing_key
            else null;
        };
      })
      alt_git_identity_list;

    ignores = [
      "*~"
      "*.swp"
      "result"
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
