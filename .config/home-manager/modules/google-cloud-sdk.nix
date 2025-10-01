{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  home.packages = with pkgs; [
    google-cloud-sdk
  ];
}
