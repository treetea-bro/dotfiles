{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      noice = {
        enable = true;
        settings = {
          presets = {
            inc_rename = true;
            lsp_doc_border = true;
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
