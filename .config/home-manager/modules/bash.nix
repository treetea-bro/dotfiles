{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      set -o vi
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'

      if [[ $- == *i* ]] && [[ -z "$FISH_VERSION" ]]; then
        exec ${pkgs.fish}/bin/fish
      fi
    '';

    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
  };
}
