{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      
      servers = {
        ts_ls.enable = true;
        nil_ls.enable = true;
        
        # pyright.enable = true;      # Python
        # rust_analyzer.enable = true; # Rust
        # gopls.enable = true;        # Go
        # html.enable = true;         # HTML
        # cssls.enable = true;        # CSS
      };
      
      keymaps = {
        # 진단 (오류/경고) 탐색
        diagnostic = {
          "<leader>k" = "goto_prev";     # 이전 오류로
          "<leader>j" = "goto_next";     # 다음 오류로
          "<leader>e" = "open_float";    # 오류 메시지 팝업
          "<leader>q" = "setloclist";    # 로케이션 리스트에 오류 목록
        };
        
        lspBuf = {
          # 탐색 기능
          "gd" = "definition";           # 정의로 이동
          "gD" = "declaration";          # 선언으로 이동
          "gr" = "references";           # 참조 찾기
          "gi" = "implementation";       # 구현으로 이동
          "gt" = "type_definition";      # 타입 정의로 이동
          
          # 정보 보기
          "K" = "hover";                 # 문서/타입 정보 보기
          "<C-k>" = "signature_help";    # 함수 시그니처 도움말
          
          # 편집 기능
          "<leader>cr" = "rename";       # 변수/함수명 변경
          "<leader>ca" = "code_action";  # 코드 액션 (import 추가 등)
          "<leader>f" = "format";        # 코드 포맷팅
          
          # 작업공간 관리
          "<leader>wa" = "add_workspace_folder";     # 작업공간 폴더 추가
          "<leader>wr" = "remove_workspace_folder";  # 작업공간 폴더 제거
          "<leader>wl" = "list_workspace_folders";   # 작업공간 폴더 목록
        };
      };
    };
  };
}
