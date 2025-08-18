{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>cr";
        action = ":IncRename ";
        options.desc = "Rename (inc-rename)";
      }
    ];
    plugins = {
      inc-rename = {
        enable = true;
      };
    };
  };
}
