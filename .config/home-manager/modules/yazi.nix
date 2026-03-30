{ config, pkgs, ... }:

{
  programs.yazi = {
    shellWrapperName = "y";
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
