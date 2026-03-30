{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lualine = {
        enable = true;
        settings = {
          sections.lualine_c = [
            "filename" # 파일 이름 뒤에 위치가 나오면 읽기 편합니다.
            {
              # [핵심] __raw를 사용하여 매번 함수를 호출하도록 설정
              __raw = ''
                function()
                  local navic = require("nvim-navic")
                  if navic.is_available() then
                    return navic.get_location()
                  end
                  return ""
                end
              '';
            }
          ];
        };
      };
    };
  };
}
