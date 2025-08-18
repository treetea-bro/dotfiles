{ config, pkgs, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "LazyGit";
      }
    ];
    plugins = {
      lazygit.enable = true;
    };
  };

}
