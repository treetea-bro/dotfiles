{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
    ];

    plugins.trouble = {
      enable = true;
    };
  };
}
