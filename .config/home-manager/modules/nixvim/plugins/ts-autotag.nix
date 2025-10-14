{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      ts-autotag = {
        enable = true;
      };
    };

    extraConfigLua = ''
      local valid_fts = { html = true, javascriptreact = true, typescriptreact = true }

      -- '>' 입력 후 닫는 태그가 자동 생성된 다음 줄바꿈
      vim.api.nvim_create_autocmd("TextChangedI", {
        callback = function()
          if not valid_fts[vim.bo.filetype] then return end

          local line = vim.api.nvim_get_current_line()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local before = line:sub(1, col)

          -- 방금 입력이 '>'이고, 자동 닫힌 태그 패턴이면
          if before:match(">$") and line:find("</%w+>$") then
            vim.schedule(function()
            local keys = vim.api.nvim_replace_termcodes(
              "<Left> className=\"\"<Right><CR><Up><End><Left><Left>",
              true,
              false,
              true
            )
              vim.api.nvim_feedkeys(keys, "n", false)
            end)
          end
        end,
      })
    '';
  };
}
