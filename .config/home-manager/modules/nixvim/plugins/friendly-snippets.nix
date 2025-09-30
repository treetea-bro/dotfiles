{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      friendly-snippets = {
        enable = true;
      };
    };
  };
}
