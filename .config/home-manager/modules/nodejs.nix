{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pnpm
    bun
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];

  home.file = {
    ".npmrc".text = ''
      prefix=${config.home.homeDirectory}/.npm-global
    '';

    ".npm-global/.keep".text = "";
  };
}
