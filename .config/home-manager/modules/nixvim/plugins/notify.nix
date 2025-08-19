{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      notify = {
        enable = true;
        settings = {
          timeout = 1000;
          stages = "static";
        };
      };
    };
  };
}
