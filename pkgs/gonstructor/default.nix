{
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "gonstructor";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "moznion";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1MPZtYL7RpcLe4SqbswfJk2F64PzJ60znmtblLXBP8Y=";
  };

  vendorHash = "sha256-Gb4ULnS8divJo78NMdZL1yuFfh/2ww9JdaBl3ejTgFo=";

  subPackages = ["internal" "cmd/gonstructor"];
}
