{
  lib,
  inputs,
  self,
  config,
  ...
}:
let
  cfg = config.myypo.users;

  usersPasswords = lib.trivial.pipe cfg [
    builtins.attrNames # Get usernames
    (n: n ++ [ "root" ])
    (builtins.map (userName: {
      name = "${userName}_password";
      value = {
        neededForUsers = true;
      };
    }))
    builtins.listToAttrs
  ];

  sopsFile = "${self}/hosts/${config.myypo.hostName}/.secrets.yaml";
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  config = {
    sops.defaultSopsFile = sopsFile;
    sops.secrets = usersPasswords;
  };
}
