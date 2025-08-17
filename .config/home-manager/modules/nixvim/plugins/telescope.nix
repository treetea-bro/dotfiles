{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      
      keymaps = {
        "<leader><leader>" = "find_files";
        "<leader>/" = "live_grep";
      };
      
      settings = {
        defaults = {
          file_ignore_patterns = [
            "node_modules/*"
            ".git/*"
            "*.pyc"
            "dist/*"
            "build/*"
          ];
        };
      };
    };
  };
}
