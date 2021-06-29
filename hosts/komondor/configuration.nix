{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager
    ../../modules/fonts
  ];

  users.users.aclarkson = {
    home = "/Users/aclarkson";
    description = "Andrew Clarkson";
    shell = pkgs.fish;
  };

  networking.hostName = "komondor";
  
  nixpkgs.config.allowUnfree = true;

  home-manager.users.aclarkson = {
    imports = [
      ../../profiles/common.nix
      ../../profiles/development.nix
    ];

    programs.home-manager.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [
      docker
      postgresql
      alacritty
    ];

  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = config.environment.systemPackages ++ config.home-manager.users.aclarkson.home.packages;
    pathsToLink = "/Applications";
  });

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/Code/configs/hosts/komondor/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # nix = {
  #   package = pkgs.nixFlakes;
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };

  # Create /etc/bashrc that loads the nix-darwin environment.
  environment.shells = [pkgs.fish];
  programs.fish.enable = true;

  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;


  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 1;
  nix.buildCores = 1;
}
