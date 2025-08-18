{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            highlight = [
              "RainbowDelimiterRed"
              "RainbowDelimiterYellow"
              "RainbowDelimiterBlue"
              "RainbowDelimiterOrange"
              "RainbowDelimiterGreen"
              "RainbowDelimiterViolet"
              "RainbowDelimiterCyan"
            ];
          };
          scope = {
            enabled = true;
            show_start = true;
            show_end = true;
          };
        };
      };
    };
  };
}
