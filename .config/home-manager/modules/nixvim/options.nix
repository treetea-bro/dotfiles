{ config, pkgs, ... }:

{
  programs.nixvim.opts = {
    clipboard = "unnamedplus";
    undofile = true;

    number = true;
    relativenumber = false;

    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
  };

  # commentstring 이 비어 있는 버퍼에 기본값을 채워 둔다.
  programs.nixvim.autoCmd = [
    {
      event = [ "BufEnter" ];
      callback.__raw = ''
        function()
          if vim.bo.commentstring == "" then
            vim.bo.commentstring = "# %s"
          end
        end
      '';
      desc = "Fallback commentstring";
    }
  ];
}
