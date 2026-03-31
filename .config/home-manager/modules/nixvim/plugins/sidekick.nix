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

    # 4. Lua 커스텀 설정 & 버그 우회 패치 (이슈 적용)
    extraConfigLua = ''
      -- [버그 패치] Sidekick NES 동기화 응답 누락 버그 우회
      local ok, Nes = pcall(require, "sidekick.nes")
      if ok then
        local Config = require("sidekick.config")
        if not Nes._sync_safe_update_patched then
          Nes._sync_safe_update_patched = true
          Nes._request_generation = {}

          local handler = Nes._handler
          Nes._handler = function(err, res, ctx)
            if not ctx or not ctx.client_id then return end
            local generation = ctx._sidekick_generation
            if generation and Nes._request_generation[ctx.client_id] ~= generation then return end
            if ctx.request_id then Nes._requests[ctx.client_id] = ctx.request_id end
            return handler(err, res, ctx)
          end

          Nes.update = function()
            local buf = vim.api.nvim_get_current_buf()
            Nes.clear()

            local enabled = Nes.enabled and Config.nes.enabled or false
            if not (vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf)) then return end
            if type(enabled) == "function" then enabled = enabled(buf) or false else enabled = enabled ~= false end
            if not enabled then return end

            local client = Config.get_client(buf)
            if not client then return end

            local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
            params.textDocument.version = vim.lsp.util.buf_versions[buf]
            params.context = { triggerKind = 2 }

            local generation = (Nes._request_generation[client.id] or 0) + 1
            local pending
            local ok_req, request_id
            Nes._request_generation[client.id] = generation

            ok_req, request_id = client:request("textDocument/copilotInlineEdit", params, function(err, res, ctx)
              ctx = ctx or { client_id = client.id }
              ctx.client_id = ctx.client_id or client.id
              ctx.request_id = ctx.request_id or request_id
              ctx._sidekick_generation = generation

              if not request_id then
                pending = { err, res, ctx }
                return
              end
              Nes._handler(err, res, ctx)
            end)

            if ok_req and request_id then
              Nes._requests[client.id] = request_id
              if pending then
                pending[3].request_id = pending[3].request_id or request_id
                vim.schedule(function() Nes._handler(pending[1], pending[2], pending[3]) end)
              end
            end
          end
        end
      end

      -- [사용자 기능] Sidekick NES를 위한 커스텀 액션 정의
      _G.sidekick_ai_nes = function()
        local Nes = require("sidekick.nes")
        if Nes.have() and (Nes.jump() or Nes.apply()) then
          return "" -- 제안 적용 성공 시 빈 문자열 반환 (추가 탭 방지)
        end
        return "<Tab>" -- 제안이 없을 땐 일반 탭 작동
      end

      -- [사용자 기능] Snacks를 이용한 NES 토글 등록
      require("snacks").toggle({
        name = "Sidekick NES",
        get = function() return require("sidekick.nes").enabled end,
        set = function(state) require("sidekick.nes").enable(state) end,
      }):map("<leader>uN")
    '';

    # 5. 모든 단축키 매핑 복구
    keymaps = [
      {
        mode = "n";
        key = "<tab>";
        action = "v:lua.sidekick_ai_nes()";
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
