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

  home.activation.wezterm-setup = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -e "/Applications/WezTerm.app" ]; then
      $DRY_RUN_CMD ln -sf ~/.nix-profile/Applications/WezTerm.app /Applications/WezTerm.app
    fi
  '';
}
