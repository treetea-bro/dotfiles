{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = { keymap_mode = "auto"; };
  };
}

