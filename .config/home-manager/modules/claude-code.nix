{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "claude-code"
  ];

  programs.claude-code = {
    enable = true;
  };
}
