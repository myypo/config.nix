function stash-flake
    git reset
    git add flake.nix flake.lock .envrc
    git stash push -m "Stash the Nix flake files" -- flake.nix flake.lock .envrc
end
