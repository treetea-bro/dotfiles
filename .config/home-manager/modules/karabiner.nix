{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = [ pkgs.karabiner-elements ];

  home.file.".config/karabiner/karabiner.json" = {
    text = builtins.toJSON {
      global = {
        check_for_updates_on_startup = true;
        show_in_menu_bar = true;
        show_profile_name_in_menu_bar = false;
      };
      profiles = [{
        name = "Default";
        selected = true;
        virtual_hid_keyboard = { keyboard_type_v2 = "ansi"; };
        complex_modifications = {
          rules = [
            {
              description = "Home to Fn key mapping";
              manipulators = [{
                type = "basic";
                from = { key_code = "home"; };
                to = [{ key_code = "fn"; }];
              }];
            }
            {
              description = "R_ALT to switch languages";
              manipulators = [{
                type = "basic";
                from = { key_code = "right_alt"; };
                to = [{
                  repeat = false;
                  key_code = "spacebar";
                  modifiers = [ "left_control" "left_alt" ];
                  lazy = true;
                }];
              }];
            }
          ];
        };
      }];
    };
  };
}

