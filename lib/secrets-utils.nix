{lib}: {
  getUserSecret = {
    config,
    userName,
    secretName,
  }:
  # HACK: this is a source of impurity in this flake
    builtins.readFile config.sops.secrets."${userName}__${secretName}".path;

  getUserListSecret = {
    config,
    userName,
    listSecretName,
  }: let
    namesList = let
      templSecrets = config.myypo.users.${userName}.secrets.${listSecretName};

      namesSecrets = lib.attrsets.filterAttrs (_: v: v == true) templSecrets;
      indicesSecrets = builtins.genList (i: i) templSecrets.count;
    in
      builtins.map (i: namesSecrets) indicesSecrets;

    contents = let
      # HACK: this is a source of impurity in this flake
      readCont = name: index: builtins.readFile config.sops.secrets."${userName}__${listSecretName}_${name}${builtins.toString index}".path;
    in
      lib.lists.imap0 (i: set: builtins.mapAttrs (nameSecr: _: readCont nameSecr i) set) namesList;
  in
    contents;
}
