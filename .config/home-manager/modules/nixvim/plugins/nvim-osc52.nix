{ config, pkgs, ... }:

{
  programs.nixvim = {
    extraConfigLua = ''
      function my_paste(reg)
          return function(lines)
            local content = vim.fn.getreg('"')
            return vim.split(content, '\n')
          end
      end

      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ["+"] = my_paste("+"),
          ["*"] = my_paste("*"),
        },
      }
    '';
  };
}
