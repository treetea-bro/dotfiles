{ config, pkgs, ... }:

{
  programs.nixvim = {
    extraConfigLua = ''
      -- 터미널로 OSC 52 를 보내 복사한다. 붙여넣기는 무명 레지스터에서 되돌린다.
      local function paste_from_unnamed()
        return vim.split(vim.fn.getreg('"'), "\n")
      end

      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ['+'] = paste_from_unnamed,
          ['*'] = paste_from_unnamed,
        },
      }
    '';
  };
}
