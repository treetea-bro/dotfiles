{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    rustc
    clippy
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
