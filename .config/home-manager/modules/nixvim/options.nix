{ config, pkgs, ... }:

{
  programs.nixvim.opts = {
    clipboard = "unnamedplus";
    
    number = true;
    relativenumber = false;
    
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
  };
}
