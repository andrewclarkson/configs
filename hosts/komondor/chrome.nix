{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.chrome;

  configDir = if pkgs.stdenv.isDarwin then
    "Library/Application Support/Google/Chrome"
  else
    "${config.xdg.configHome}/Google Chrome";

  extensionJson = ext: {
    name = "${configDir}/External Extensions/${ext}.json";
    value.text = builtins.toJSON {
      external_update_url =
        "https://clients2.google.com/service/update2/crx";
    };
  };
in {
  meta.maintainers = [ maintainers.rycee ];

  options = {
    programs.chrome = {
      enable = mkEnableOption "chrome";
      extensions = mkOption {
        visible = true;
        type = types.listOf types.str;
        default = [ ];
        example = literalExample ''
          [
            "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
            "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
            "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
          ]
        '';
        description = ''
          List of chrome extensions to install.
          To find the extension ID, check its URL on the
          <link xlink:href="https://chrome.google.com/webstore/category/extensions">Chrome Web Store</link>.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.file = listToAttrs (map extensionJson cfg.extensions);
  };
}
