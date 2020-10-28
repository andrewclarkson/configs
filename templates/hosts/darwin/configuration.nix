{ config, pkgs, ... }:

{
  
  imports = [ <home-manager/nix-darwin>];
  
  users.users.a4wc6n = {
    home = "/Users/aclarkson";
    description = "Andrew Clarkson";
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
  
  home-manager.useUserPackages = true;

  home-manager.users.a4wc6n = {
    xdg.enable = true;
    programs = {
      home-manager.enable = true;
    };


    home.packages = with pkgs; [];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      docker
      postgresql
    ];

  # This allows us to run darwin-rebuild without "-I darwin-config=$PATH_TO_CONFIGS/hosts/$HOSTNAME/configuration.nix"
  environment.darwinConfig = "$HOME/Code/configs/hosts/$HOSTNAME/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.bash.enable = true;
  # programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
}
