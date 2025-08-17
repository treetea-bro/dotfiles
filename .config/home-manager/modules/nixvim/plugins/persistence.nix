{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.persistence = {
      enable = true;
      settings = {
        options = ["buffers" "curdir" "tabpages" "winsize"];
      };
    };
    
    keymaps = [
      {
        mode = "n";
        key = "<leader>qs";
        action = {
          __raw = "function() require('persistence').load() end";
        };
        options.desc = "Restore Session";
      }
      {
        mode = "n";
        key = "<leader>qS";
        action = {
          __raw = "function() require('persistence').select() end";
        };
        options.desc = "Select Session";
      }
      {
        mode = "n";
        key = "<leader>ql";
        action = {
          __raw = "function() require('persistence').load({ last = true }) end";
        };
        options.desc = "Restore Last Session";
      }
      {
        mode = "n";
        key = "<leader>qd";
        action = {
          __raw = "function() require('persistence').stop() end";
        };
        options.desc = "Don't Save Current Session";
      }
    ];
    
    extraConfigLua = ''
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("persistence_save", { clear = true }),
        callback = function()
          if vim.bo.filetype ~= "alpha" and vim.bo.filetype ~= "dashboard" then
            require("persistence").save()
          end
        end,
      })
    '';
  };
}
