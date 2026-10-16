{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      ts-autotag = {
        enable = true;
      };
    };
  };
}
