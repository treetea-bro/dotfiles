{ config, pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
  };
}

# {
#   home.packages = with pkgs; [
#     brave
#   ];
#   # programs.brave = {
#   #   enable = true;
#   # };
# }
