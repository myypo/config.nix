{
  lib,
  githubUserName,
  personalEmail,
  personalSigningKey,
  altGitIdentities,
}:
{
  programs.git = {
    enable = true;

    # Plugin for working with large files
    lfs.enable = true;

    userName = githubUserName;
    userEmail = personalEmail;

    signing = {
      key = personalSigningKey;

      signByDefault = false;
    };

    includes = lib.attrsets.mapAttrsToList (id: v: {
      condition = "gitdir:~/code/${id}/**";
      contents = {
        user.name = v.username;
        user.email = v.email;
        user.key = v.signingKey;
      };
    }) altGitIdentities;

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
      push = {
        autoSetupRemote = true;
      };
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
