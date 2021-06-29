{ config, lib, pkgs, ... }:

let 
    inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isDarwin;
in {
    home.packages = with pkgs; [
        docker
        docker-compose
        docker-machine
    ];
}