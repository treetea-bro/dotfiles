{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        lsp = {
          hover = {
            enabled = true;
            silent = true;
          };
        };
        presets = {
          inc_rename = true;
          lsp_doc_border = true;
        };
        notify.enabled = true;
      };
    };
  };
}
