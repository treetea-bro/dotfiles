{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      notify.enable = true;
    };
  };
}
