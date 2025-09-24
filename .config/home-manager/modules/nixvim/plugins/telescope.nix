{ config, pkgs, ... }:

{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;

      keymaps = {
        # 파일 / 검색 관련
        "<leader><leader>" = "find_files";        # 프로젝트 내 파일 검색
        "<leader>/" = "live_grep";                # 전체 프로젝트에서 문자열 검색
        "<leader>fb" = "buffers";                 # 열린 버퍼 목록
        "<leader>fh" = "help_tags";               # Neovim 도움말 검색
        "<leader>fo" = "oldfiles";                # 최근 열었던 파일들

        # LSP 관련
        "gd" = "lsp_definitions";                 # 정의로 이동
        "gr" = "lsp_references";                  # 참조 찾기
        "gI" = "lsp_implementations";             # 구현부 찾기
        "gy" = "lsp_type_definitions";            # 타입 정의 찾기
        "<leader>ss" = "lsp_document_symbols";    # 현재 문서 함수/변수/클래스 목록
        "<leader>sS" = "lsp_workspace_symbols";   # 워크스페이스 전체 심볼 목록

        # 기타 유용한 기능
        "<leader>km" = "keymaps";                 # Neovim 키맵 검색
        "<leader>cm" = "commands";                # Ex 명령어 검색
      };

      settings = {
        # defaults = {
        #   file_ignore_patterns = [
        #     "node_modules/*"
        #     ".git/*"
        #     "*.pyc"
        #     "dist/*"
        #     "build/*"
        #   ];
        # };
      };
    };
  };
}
