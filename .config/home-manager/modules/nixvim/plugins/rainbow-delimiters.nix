{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      rainbow-delimiters = {
        enable = true;
      };
    };
  };
}
