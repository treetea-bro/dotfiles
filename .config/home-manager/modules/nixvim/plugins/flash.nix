{ config, pkgs, lib, ... }:

{
  programs.nixvim = {
    plugins.flash = {
      enable = true;

      settings = {
        jump = {
          autojump = false;   # 매치가 하나뿐이면 자동으로 점프
          jumplist = true;   # 점프 위치를 jumplist에 저장
          history = false;    # 검색 히스토리(/)에 남김
          nohlsearch = true; # 점프 후 검색 하이라이트 지우기
        };

        label = {
          current = true;      # 현재 창 첫 매치에 라벨 붙임
          after = true;        # 매치 뒤에 라벨 표시
          before = false;      # 매치 앞에는 표시 안 함
          distance = true;     # 커서와 가까운 것 먼저 라벨링
          uppercase = true;    # 대문자 라벨 허용
          style = "overlay";   # 라벨 위치 스타일 (overlay/eol/right_align/inline)
        };

        highlight = {
          backdrop = true;  # 배경 어둡게
          matches = true;   # 매치 하이라이트
          priority = 5000;  # extmark priority
          groups = {
            backdrop = "FlashBackdrop";
            current  = "FlashCurrent";
            label    = "FlashLabel";
            match    = "FlashMatch";
          };
        };

        modes = {
          search = {
            enabled = true; # /, ? 입력 시 flash 활성화
          };
        };
      };
    };

    keymaps = [
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash jump";
      }
      {
        mode = [ "n" "x" "o" ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options.desc = "Flash Treesitter";
      }
    ];
  };
}
