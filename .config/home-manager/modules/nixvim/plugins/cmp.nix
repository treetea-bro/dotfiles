{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;

    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "copilot"; }
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
