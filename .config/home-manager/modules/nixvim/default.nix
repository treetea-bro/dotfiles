{ config, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./diagnostic.nix
    ./keymaps.nix
    ./colorschemes.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    globals.mapleader = " ";
  };
}
