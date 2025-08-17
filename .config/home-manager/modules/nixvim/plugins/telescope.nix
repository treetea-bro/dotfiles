{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      
      keymaps = {
        "<leader><leader>" = "find_files";
        "<leader>/" = "live_grep";
        # "<leader>fb" = "buffers";
        # "<leader>fh" = "help_tags";
        # "<leader>fc" = "current_buffer_fuzzy_find";
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
      
      extensions = {
        fzf-native = {
          enable = true;
          settings = {
            case_mode = "ignore_case";
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
          };
        };
        
        # 추가 유용한 확장들
        # file_browser.enable = true;
        # ui-select.enable = true;
      };
    };
  };
}
