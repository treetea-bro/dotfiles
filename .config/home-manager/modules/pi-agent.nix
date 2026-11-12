{ ... }:

{
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
