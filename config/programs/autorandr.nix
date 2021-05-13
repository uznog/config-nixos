{ config, pkgs, ... }:

let
  postswitch = ''
    dunstify "Autorandr" "Reloading wallpaper and polybar!"
    if [[ -e $HOME/.background-image ]]; then feh --bg-scale $HOME/.background-image ; fi
    systemctl --user restart polybar.service
  '';
in
with pkgs.lib;
{
  programs.autorandr = {
    enable = true;

    profiles = {

      "detached" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004d10d01400000000031e0104b52215780a641caa5235b9250e51560000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe003930543032814c513135365231000000000002410332011200000b010a2020013d02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "3840x2400";
            rotate = "normal";
            dpi = 192;
          };
        };
      };

      "home" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004d10d01400000000031e0104b52215780a641caa5235b9250e51560000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe003930543032814c513135365231000000000002410332011200000b010a2020013d02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
          DP-1 = "00ffffffffffff0009d1d67845540000331c0103803c2278260cd5a9554ca1250d5054a56b80818081c08100a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000ff004b434a30303039353031390a20000000fd00324c1e591b000a202020202020000000fc0042656e51204757323736350a2001cf020324f14f901f05140413031207161501061102230907078301000067030c0010003836023a801871382d40582c450056502100001e011d8018711c1620582c250056502100009e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e960056502100001800000000000000000000000000000000000000d7";
        };
        
        config = {
          eDP-1 = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "3840x2400";
            rotate = "normal";
            dpi = 192;
          };
          DP-1 = {
            enable = true;
            primary = true;
            position = "3840x0";
            mode = "2560x1440";
            rotate = "normal";
            dpi = 96;
          };
        };
        hooks.postswitch = toString "${postswitch}";
      };

      "work" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004d10d01400000000031e0104b52215780a641caa5235b9250e51560000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe003930543032814c513135365231000000000002410332011200000b010a2020013d02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
          DP-3 = "00ffffffffffff0009d1d67845540000331c0103803c2278260cd5a9554ca1250d5054a56b80818081c08100a9c0b300d1c001010101565e00a0a0a029503020350055502100001a000000ff004b434a30303131363031390a20000000fd00324c1e591b000a202020202020000000fc0042656e51204757323736350a2001d5020324f14f901f05140413031207161501061102230907078301000067030c0010003836023a801871382d40582c450056502100001e011d8018711c1620582c250056502100009e011d007251d01e206e28550056502100001e8c0ad08a20e02d10103e960056502100001800000000000000000000000000000000000000d7";
        };
        
        config = {
          eDP-1 = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "3840x2400";
            rotate = "normal";
            dpi = 192;
          };
          DP-3 = {
            enable = true;
            primary = true;
            position = "3840x0";
            mode = "2560x1440";
            rotate = "normal";
            dpi = 96;
          };
        };
        hooks.postswitch = toString "${postswitch}";
      };
    };
  };
}
