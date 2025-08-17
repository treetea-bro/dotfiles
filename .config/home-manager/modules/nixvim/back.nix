{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals.mapleader = " ";

    colorschemes.gruvbox.enable = true;

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

    opts = {
      clipboard = "unnamedplus";
    	number = true;
      relativenumber = false;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    plugins = {
      lualine.enable = true;

      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          nil_ls.enable = true;
        };
      };

      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "cmdliine"; }
          ];
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader><leader>" = "find_files";
          "<leader>/" = "live_grep";
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
        };
      };

      neo-tree = {
        enable = true;
      };
    };
  };
}
