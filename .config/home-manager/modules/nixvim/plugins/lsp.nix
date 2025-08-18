{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        
        servers = {
          vtsls.enable = true;
          nil_ls.enable = true;
          pyright.enable = true;
          ruff.enable = true;
        };
        
        keymaps = {
          lspBuf = {
            # 정보 보기
            "K" = "hover";                 # 문서/타입 정보 보기
            "<C-k>" = "signature_help";    # 함수 시그니처 도움말
            
            # 편집 기능
            # "<leader>cr" = "rename";       # 변수/함수명 변경
            "<leader>ca" = "code_action";  # 코드 액션 (import 추가 등)
          };
        };
      };
    };
  };
}
