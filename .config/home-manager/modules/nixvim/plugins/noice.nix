{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      noice = {
        enable = true;
        settings = {
          presets = {
            inc_rename = true;
          };
          notify = {
            enabled = true;
          };
          views = {
            notify = {
              backend = "notify";
              fallback = "mini";
              format = "notify";
              replace = false;
              merge = false;
            };
          };
        };
      };
    };
  };
}
