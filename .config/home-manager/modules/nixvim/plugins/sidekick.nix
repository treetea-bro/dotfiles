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
          debug = true;
          nes = {
            enabled = true;
          };
        };
      };
    };

    # 1. 커스텀 함수 및 Snacks 토글 설정 수정
    extraConfigLua = ''
      -- Sidekick NES를 위한 커스텀 액션 정의
      _G.sidekick_ai_nes = function()
        local Nes = require("sidekick.nes")
        -- NES 제안이 존재하고 적용 또는 점프에 성공했다면
        if Nes.have() and (Nes.jump() or Nes.apply()) then
          return "" -- 빈 문자열 반환 (추가 탭 입력 방지)
        end
        -- NES 제안이 없다면 일반적인 Tab 키 입력 반환
        return "<Tab>"
      end

      -- Snacks를 이용한 NES 토글 등록
      require("snacks").toggle({
        name = "Sidekick NES",
        get = function()
          return require("sidekick.nes").enabled
        end,
        set = function(state)
          require("sidekick.nes").enable(state)
        end,
      }):map("<leader>uN")
    '';

    # 2. 키맵 설정 수정
    keymaps = [
      {
        mode = "n";
        key = "<tab>";
        action = "v:lua.sidekick_ai_nes()"; # 삼항 연산자 제거, 함수에서 직접 키스트로크 반환
        options = {
          expr = true;
          replace_keycodes = true; # <Tab> 문자열을 실제 탭 키로 변환하기 위해 필수
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
