{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      set -o vi
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'
    '';
    enableCompletion = true;
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };
}
