{ config, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "C";
          command = "cz c";
          context = "files";
          output = "terminal";
          description = "Commitizen commit";
        }
      ];
    };
  };
}
