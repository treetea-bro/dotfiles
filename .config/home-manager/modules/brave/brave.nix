{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  programs.brave = {
    enable = true;
  };
}
