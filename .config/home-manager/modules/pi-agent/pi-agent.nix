{ ... }:

{
  home.file.".pi/agent/extensions/notify.ts".source = ./notify.ts;

  programs.pi-coding-agent = {
    enable = true;

    settings = {
      packages = [
        "npm:billion-context-pi"
        "npm:pi-web-access"
      ];
    };
  };
}
