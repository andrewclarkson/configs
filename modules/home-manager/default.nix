{ config, lib, pkgs, ... }:

let
  inherit (lib) optional flatten;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in {
  imports = flatten [
    (optional isDarwin <home-manager/nix-darwin>)
    # This assumes that linux means NixOS which isn't necessarily true
    (optional isLinux <home-manager/nixos>)
  ];

  home-manager.useUserPackages = true;
}
