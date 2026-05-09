{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isLinux {
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      highlight-active-color = "#000000";
    };

    # 추가적인 설정이 필요하다면 여기에 작성합니다.
    # extraConfig = ''
    #   map [카테고리] [키] [동작]
    # '';
  };
}
