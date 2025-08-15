{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ starship ];

  xdg.configFile."starship.toml".source = ./starship.toml;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

}
