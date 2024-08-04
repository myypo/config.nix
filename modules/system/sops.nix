{
  lib,
  inputs,
  self,
  config,
  ...
}:
with lib; let
  cfg = config.myypo.users;

  usersPasswords = let
    userNames = builtins.attrNames cfg;
  in
    builtins.listToAttrs (
      builtins.map (userName: {
        name = "${userName}_password";
        value = {
          neededForUsers = true;
        };
      }) (userNames ++ ["root"])
    );

  usersTemplates = let
    cfgUserSecrets =
      attrsets.mapAttrs (
        _: userCfg:
          userCfg.secrets
      )
      cfg;

    listTempls = builtins.attrValues (
      builtins.mapAttrs (
        userName: secrCfg: let
          ownedNames = let
            plainNames = builtins.attrNames (attrsets.filterAttrs (_: v: v == true) secrCfg);

            listNames = let
              attrsCfgs = attrsets.filterAttrs (_: v: v ? count) secrCfg;
            in
              builtins.concatLists (builtins.attrValues (builtins.mapAttrs (
                  groupName: groupVals: let
                    enabled = builtins.attrNames (attrsets.filterAttrs (_: v: v == true) groupVals);

                    empty = builtins.genList (i: i) groupVals.count;

                    filled = builtins.map ({
                      nameSecr,
                      idxSecr,
                    }: "${groupName}_${nameSecr}${builtins.toString idxSecr}") (attrsets.cartesianProduct {
                      nameSecr = enabled;
                      idxSecr = empty;
                    });
                  in
                    filled
                )
                attrsCfgs));
          in
            builtins.map (secrName: "${userName}__${secrName}") (listNames ++ plainNames);
        in
          attrsets.genAttrs ownedNames (_: {owner = userName;})
      )
      cfgUserSecrets
    );
  in
    builtins.foldl' (acc: elem: acc // elem) {} listTempls;

  sopsFile = let
    hostName = config.myypo.hostName;
  in "${self}/secrets/.${hostName}.yaml";
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = {
    sops.defaultSopsFile = sopsFile;
    sops.secrets = usersPasswords // usersTemplates;
  };
}
