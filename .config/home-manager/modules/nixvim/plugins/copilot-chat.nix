{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      copilot-chat = {
        enable = true;

        settings = {
          debug = false;
          show_help = false;

          window = {
            layout = "vertical";
            width = 0.3;
          };

          mappings = {
            reset = {
              insert = "<C-r>";
              normal = "<C-r>";
            };
            show_help = {
              normal = "gh";
            };
          };
        };
      };
    };

    extraConfigLua = ''
      local chat = require("CopilotChat")

      local old_open = chat.open

      chat.open = function(...)
        local result = old_open(...)

        vim.cmd("wincmd L")

        return result
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>cc";
        action = "<cmd>CopilotChat<CR>";
        options.desc = "Open Copilot Chat Sidebar";
      }
      {
        mode = "v";
        key = "<leader>ce";
        action = "<cmd>CopilotChatExplain<CR>";
        options.desc = "Explain selected code";
      }
      {
        mode = "v";
        key = "<leader>cf";
        action = "<cmd>CopilotChatFix<CR>";
        options.desc = "Fix selected code";
      }
    ];
  };
}
