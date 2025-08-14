{ config, pkgs, ... }:

{
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
