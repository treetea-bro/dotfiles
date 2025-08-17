{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
          { name = "cmdline"; }
        ];
        mapping = {
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          
          "<CR>" = "cmp.mapping.confirm({ select = true })";

          "<C-e>" = "cmp.mapping.abort()";
        };

        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
          };
          documentation = {
            border = "rounded";
          };
        };
      };
    };
  };
}
