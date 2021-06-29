{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    kubernetes
    kubernetes-helm
    kind
    kubectl
  ];
}
