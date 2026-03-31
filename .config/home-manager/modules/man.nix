{ pkgs, ... }:

{
  programs.man.enable = true;
  programs.man.package = pkgs.man;
  programs.man.generateCaches = true;
}
