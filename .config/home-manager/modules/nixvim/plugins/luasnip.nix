{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      luasnip = {
        enable = true;
      };
    };
  };
}
