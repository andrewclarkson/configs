Configs
=======

This repo represents the various nix configurations for all my various personal nixos installations.

How To Install
--------------

You'll need some secrets that shouldn't be published on the internet. First create `/etc/nixos/secrets.nix`. You can start with copying the template `./nix/secrets.template.nix`

```sh
# cp ./nix/secrets.template.nix /etc/nixos/secrets.nix
# chown root:root /etc/nixos/secrets.nix
# sudo $EDITOR /etc/nixos/secrets.nix
```

Actually, I'm now doing it via symlinks.

```sh
ln -s $CONFIG_REPO_PATH/nix/devices/$DEVICE/configuration.nix /mnt/etc/nixos/configuration.nix
```
