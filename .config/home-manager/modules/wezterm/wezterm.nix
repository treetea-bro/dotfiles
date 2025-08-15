{ config, pkgs, lib, ... }:

{
  programs.wezterm = {
    enable = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".source = ./wezterm.lua;
    "wezterm/backgrounds/stars.jpg".source = ./backgrounds/stars.jpg;
    "wezterm/colors/PecoArcade.toml".source = ./colors/PecoArcade.toml;
  };

  xdg.desktopEntries = lib.mkIf pkgs.stdenv.isLinux {
    wezterm = {
      name = "Wezterm";
      genericName = "Wezterm";
      exec = "wezterm %U";
      terminal = false;
      type = "Application";
      categories = [ "X-terminal" ];
    };
  };
}
