{ config, pkgs, ... }:

{
  programs.nixvim = {
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        # contrast_dark = "medium";  # "soft", "medium", "hard"
        # transparent_background = false;
      };
    };

    # colorschemes.catppuccin.enable = true;
    # colorschemes.tokyonight.enable = true;
    # colorschemes.nord.enable = true;
  };
}
