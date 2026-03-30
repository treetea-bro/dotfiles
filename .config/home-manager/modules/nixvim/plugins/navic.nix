{
  programs.nixvim = {
    plugins = {
      navic = {
        enable = true;
        settings = {
          lsp.auto_attach = true; # LSP 연결 시 자동 활성화
          highlight = true;       # 색상 하이라이트 활성화
          # separator = " > ";
          # 아이콘이 깨져 보인다면 아래 설정을 추가하세요 (Nerd Font 필요)
          # icons = { Function = "󰊕 "; Class = "󭵡 "; };
        };
      };
    };
  };
}
