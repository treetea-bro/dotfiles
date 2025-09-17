{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-osc52 = {
        enable = true;
        keymaps = {
          enable = true;
        };
      };
    };

    # extraConfigLua = ''
    #   local osc52 = require("osc52")
    #   osc52.setup { max_length = 0, silent = true, trim = false }
    #
    #   local function copy(lines, regtype)
    #     local text = table.concat(lines, "\n")
    #
    #     osc52.copy(text)
    #   end
    #
    #   local function paste()
    #     return vim.fn.getreg('"', 1, true), vim.fn.getregtype('"')
    #   end
    #
    #   vim.g.clipboard = {
    #     name = "osc52",
    #     copy = { ["+"] = copy, ["*"] = copy },
    #     paste = { ["+"] = paste, ["*"] = paste },
    #   }
    # '';
  };
}
