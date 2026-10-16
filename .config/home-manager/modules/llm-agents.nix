{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs.llm-agents; [
    claude-code
  ];
}
