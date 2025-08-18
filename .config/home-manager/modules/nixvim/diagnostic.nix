{ config, pkgs, ... }:

{
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = {
        enabled = true;
        spacing = 0;
        prefix = "●";
      };
      signs = false;
      underline = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options.desc = "Show diagnostic details";
      }
    ];
  };
}
