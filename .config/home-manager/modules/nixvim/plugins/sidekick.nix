{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    nixpkgs.config.allowUnfree = true;

    plugins = {
      snacks = {
        enable = true;
        settings = {
          toggle = { enabled = true; };
          notifier = { enabled = true; };
          picker = { enabled = true; };
        };
      };

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

      sidekick = {
        enable = true;
        settings = {
          nes = { enabled = true; };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<Tab>";
        action.__raw = ''
          function()
            local ok, nes = pcall(require, "sidekick.nes")
            if ok and nes.have() then
              if nes.jump() or nes.apply() then
                return ""
              end
            end
            -- 제안이 없을 경우 실제 Tab 키를 입력하도록 처리
            return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
          end
        '';

        options = {
          expr = true;
          replace_keycodes = true;
          desc = "Sidekick NES Jump/Apply";
        };
      }
      {
        mode = [ "n" "v" ];
        key = "<leader>a";
        action = "";
        options.desc = "+ai";
      }
      {
        mode = [ "n" "t" "i" "x" ];
        key = "<c-.>";
        action = ''<cmd>lua require("sidekick.cli").focus()<CR>'';
        options.desc = "Sidekick Focus";
      }
      {
        mode = "n";
        key = "<leader>aa";
        action = ''<cmd>lua require("sidekick.cli").toggle()<CR>'';
        options.desc = "Sidekick Toggle CLI";
      }
      {
        mode = "n";
        key = "<leader>as";
        action = ''<cmd>lua require("sidekick.cli").select()<CR>'';
        options.desc = "Select CLI";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action = ''<cmd>lua require("sidekick.cli").close()<CR>'';
        options.desc = "Detach a CLI Session";
      }
      {
        mode = [ "x" "n" ];
        key = "<leader>at";
        action = ''<cmd>lua require("sidekick.cli").send({ msg = "{this}" })<CR>'';
        options.desc = "Send This";
      }
      {
        mode = "n";
        key = "<leader>af";
        action = ''<cmd>lua require("sidekick.cli").send({ msg = "{file}" })<CR>'';
        options.desc = "Send File";
      }
      {
        mode = "x";
        key = "<leader>av";
        action = ''<cmd>lua require("sidekick.cli").send({ msg = "{selection}" })<CR>'';
        options.desc = "Send Visual Selection";
      }
      {
        mode = [ "n" "x" ];
        key = "<leader>ap";
        action = ''<cmd>lua require("sidekick.cli").prompt()<CR>'';
        options.desc = "Sidekick Select Prompt";
      }
    ];
  };
}
