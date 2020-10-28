{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python
    python38Packages.bpython
    jupyter
  ];
}
