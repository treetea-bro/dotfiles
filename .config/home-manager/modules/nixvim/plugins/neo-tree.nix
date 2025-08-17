{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle file explorer";
        };
      }
    ];

    plugins = {
      lualine = {
        enable = true;
      };
      
      neo-tree = {
        enable = true;
        
        window = {
          width = 30;
          position = "left";

          mappings = {
            "l" = "open";
            "h" = "close_node";
          };
        };
      };
    };
  };
}


