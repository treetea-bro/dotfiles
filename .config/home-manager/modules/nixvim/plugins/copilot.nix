{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins = {
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = { enabled = false; };
          panel = { enabled = false; };

          filetypes = {
            "*" = true;

            # sh 파일이면서 이름이 .env* 이면 Copilot 비활성화
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
      copilot-cmp.enable = true;
    };
  };
}
