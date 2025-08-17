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
        
        # mapping = {
        #   "<Tab>" = "cmp.mapping.select_next_item()";
        #   "<S-Tab>" = "cmp.mapping.select_prev_item()";
        #   "<CR>" = "cmp.mapping.confirm({ select = true })";
        #   "<C-Space>" = "cmp.mapping.complete()";
        # };
      };
    };
  };
}
