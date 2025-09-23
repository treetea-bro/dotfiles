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
    ];
  };
}
