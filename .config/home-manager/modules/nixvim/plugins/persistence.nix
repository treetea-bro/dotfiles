{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      persistence = {
        enable = true;
        settings = {
          options = [ "buffers" "curdir" "tabpages" "winsize" ];
        };
      };
    };

    extraConfigLua = ''
      -- 세션 저장: neo-tree 버퍼 제거 후 저장
      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("persistence_save", { clear = true }),
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "neo-tree" then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
          require("persistence").save()
        end,
      })

      -- 세션 자동 로드
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local persistence = require("persistence")
          if vim.fn.argc() == 0 and vim.bo.filetype ~= "alpha" and vim.bo.filetype ~= "dashboard" then
            persistence.load()
            vim.cmd("Neotree reveal")
          end
        end,
      })

      -- 세션 복원 후 filetype / syntax 다시 감지
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoadPost",
        callback = function()
          vim.cmd("silent! filetype detect")
          vim.cmd("silent! syntax enable")
        end,
      })

      -- commentstring 비어있으면 기본값 설정
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.commentstring == "" then
            vim.bo.commentstring = "# %s"
          end
        end,
      })
    '';
  };
}
