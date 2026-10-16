{
  programs.nixvim = {
    plugins = {
      navic = {
        enable = true;
        settings = {
          lsp.auto_attach = true; # LSP 연결 시 자동 활성화
          highlight = true;       # 색상 하이라이트 활성화
        };
      };
    };
  };
}
