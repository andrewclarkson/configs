{ pkgs, ... }:
let
  secrets = (import /etc/nixos/secrets.nix);
in {
  users = {
    mutableUsers = true;
    users = {
      bitborn = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager" "video"];
        shell = pkgs.fish;
        group = "users";
        # hashedPassword = secrets.bitborn.hashedPassword;
        uid = 1000;
      };
    };
  };
}
