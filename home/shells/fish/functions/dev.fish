function dev --wraps='nix develop'
    env ANY_NIX_SHELL_PKGS=(basename (pwd))"#"(git describe --tags --dirty 2>/dev/null) (type -P nix) develop ".#$argv[1]" --command fish
end
