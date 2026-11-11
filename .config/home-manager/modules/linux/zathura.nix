{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      highlight-active-color = "#000000";
    };
  };
}
