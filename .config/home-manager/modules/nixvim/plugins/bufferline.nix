{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    bufferline.enable = true;
  };
}
