{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      
      keymaps = {
        "<leader><leader>" = "find_files";
        "<leader>/" = "live_grep";
        "gd" = "lsp_definitions";
        "gr" = "lsp_references";
        "gI" = "lsp_implementations";
        "gy" = "lsp_type_definitions";
      };
      
      settings = {
        # defaults = {
        #   file_ignore_patterns = [
        #     "node_modules/*"
        #     ".git/*"
        #     "*.pyc"
        #     "dist/*"
        #     "build/*"
        #   ];
        # };
      };
    };
  };
}
