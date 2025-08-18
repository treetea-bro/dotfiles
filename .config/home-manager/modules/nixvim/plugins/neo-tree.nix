{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree reveal<cr>";
        options = {
          desc = "File explorer reveal";
        };
      }
    ];

    plugins = {
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
