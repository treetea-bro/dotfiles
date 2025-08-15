{ config, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "peco";
    userEmail = "sorpwjdafh@naver.com";
  };
}
