{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [    
    # Home Manager
    home-manager
  ];
}
