{ config, pkgs, ... }:

{
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "peco";
        email = "sorpwjdafh@naver.com";
      };
    };
  };
}
