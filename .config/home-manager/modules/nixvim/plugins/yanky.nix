{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      yanky.enable = true;
    };
  };
}
