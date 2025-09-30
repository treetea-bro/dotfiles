{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      emmet = {
        enable = true;
        settings = {
          leader = "<C-y>";
        };
      };
    };
  };
}
