{ config, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;

      highlight-active-color = "#000000";
    };

    # 만약 기본 단축키(Ctrl+o)가 마음에 들지 않는다면 여기서 매핑을 바꿀 수도 있습니다.
    # extraConfig = ''
    #   map [카테고리] [키] [동작]
    # '';
  };
}
