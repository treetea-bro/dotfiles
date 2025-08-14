{ config, pkgs, ... }:

{
  programs.eza = {
    enable = true;
    git = true;
  };
}
