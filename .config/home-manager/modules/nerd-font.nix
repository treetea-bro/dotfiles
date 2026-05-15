{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    pretendard
    nanum-gothic-coding
    noto-fonts-cjk-sans
  ];
}
