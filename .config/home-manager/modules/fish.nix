{ config, pkgs, lib, ... }: {

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      atuin init fish | source
    '';
  };
}

