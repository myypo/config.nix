# After installing on a new PC I see there is quite a bit of stuff I need to improve

- `mkOutOfStoreSymlink` won't do its thing on a fresh install. Had to disable `nvim` module to install NixOS. But `aider` somehow worked fine - weird
- Find a proper `Hyprland` picker already
- Precreate directories in home I am using for projects etc.
- Unscuff the secret management. Had to nuke the repo because of `git-crypt`. There must be a less ridiculous way e.g. just use `gpg` keys for everything so I don't have to have age/ssh/gpg keys at the same time
- Get rid of modules that just install a package. There is bunch of them in `home`. For example the `other` directory is ridiculous
- Add some scripts thingy, like probably Nix apps but more convenient for easier installation and secret management
