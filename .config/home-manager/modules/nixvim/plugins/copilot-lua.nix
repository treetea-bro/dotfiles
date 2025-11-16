{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = true;
            auto_trigger = true;
            debounce = 75;
            keymap = {
              accept = "<Tab>";
            };
          };
          panel = { enabled = false; };

          filetypes = {
            "*" = true;

            sh.__raw = ''
              function()
                if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
                  return false
                end
                return true
              end
            '';
          };
        };
      };
    };
  };
}
