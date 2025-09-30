{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      copilot-cmp.enable = true;
    };
  };
}
