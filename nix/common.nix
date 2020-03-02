{ config, pkgs, ... }:
{

  imports = [
    ./packages.nix
    ./emacs.nix
    ./fonts.nix
    ./programs.nix
    ./services.nix
    ./networking.nix
    ./users.nix
  ];
 
  # Select internationalisation properties.
  i18n = {
    # consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    XCURSOR_PATH = [ "${pkgs.gnome3.adwaita-icon-theme}/share/icons" ]; # Make sure firefox can load icons
  };
  
  # virtualisation.virtualbox.host.enable = true;  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable OpenGL
  hardware.opengl.enable = true;

  # Enable sway
  programs.sway.enable = true;
  programs.light.enable = true;
}
