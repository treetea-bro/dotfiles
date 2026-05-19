{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    go
    air
    gopls
    (lib.lowPrio gotools)
    gofumpt
    golangci-lint
    delve
  ];
}
