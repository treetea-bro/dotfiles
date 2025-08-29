{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      mini-pairs = {
        enable = true;
      };
    };
  };
}
