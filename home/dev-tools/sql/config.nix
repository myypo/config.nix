{pkgs}: {
  home.packages = with pkgs; [
    sqls
    sqlfluff
  ];
}
