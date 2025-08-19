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
        };
      };
    };
  };
}
