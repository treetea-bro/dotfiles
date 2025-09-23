{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = with pkgs; [ rectangle ];

  launchd.agents.rectangle = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs.rectangle}/Applications/Rectangle.app/Contents/MacOS/Rectangle" ];
      RunAtLoad = true;
      # KeepAlive = true;
    };
  };
}
