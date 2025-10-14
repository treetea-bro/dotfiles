{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins.yanky = {
      enable = true;
    };

    extraConfigLua = ''
      -- 여러 줄 yank 후 커서를 마지막 줄 아래로 이동
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          local event = vim.v.event
          -- "y" (yank)일 때만 실행 (delete나 change 제외)
          if event and event.operator == 'y' then
            local start_line = vim.fn.line("'[")
            local end_line = vim.fn.line("']")
            if end_line > start_line then
              vim.cmd("normal! `]")  -- 마지막 줄로 커서 이동
            end
          end
        end,
      })

      -- "p"나 "P"로 붙여넣을 때도 커서를 마지막 줄 아래로 이동
      vim.keymap.set({ "n", "x" }, "p", function()
        local start_line = vim.fn.line(".")
        vim.cmd("normal! p")
        local end_line = vim.fn.line("']")
        if end_line > start_line then
          vim.cmd("normal! `]") -- 붙여넣은 마지막 줄로 이동
        end
      end, { noremap = true, silent = true })

      vim.keymap.set({ "n", "x" }, "P", function()
        local start_line = vim.fn.line(".")
        vim.cmd("normal! P")
        local end_line = vim.fn.line("']")
        if end_line > start_line then
          vim.cmd("normal! `]") -- 붙여넣은 마지막 줄로 이동
        end
      end, { noremap = true, silent = true })
    '';
  };
}
