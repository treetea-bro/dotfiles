{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      bufferline = {
        enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        options.desc = "Toggle pin";
      }
      {
        mode = "n";
        key = "<leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        options.desc = "Delete non-pinned buffers";
      }
      {
        mode = "n";
        key = "<A-h>";
        action = "<Cmd>BufferLineMovePrev<CR>";
        options.desc = "Move buffer left";
      }
      {
        mode = "n";
        key = "<A-l>";
        action = "<Cmd>BufferLineMoveNext<CR>";
        options.desc = "Move buffer right";
      }
      {
        mode = "n";
        key = "H";
        action = "<Cmd>BufferLineCyclePrev<CR>";
        options.desc = "Cycle buffer left (UI order)";
      }
      {
        mode = "n";
        key = "L";
        action = "<Cmd>BufferLineCycleNext<CR>";
        options.desc = "Cycle buffer right (UI order)";
      }
    ];
  };
}
