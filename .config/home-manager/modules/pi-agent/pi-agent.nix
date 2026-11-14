{ pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  # Use Apple's signed built-in notifier on macOS: an ad-hoc signed Nix
  # terminal-notifier can be refused notification authorization as well.
  notifierPath = if isDarwin then "/usr/bin/osascript" else "${pkgs.libnotify}/bin/notify-send";
in
{
  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.libnotify ];

  # Embed the absolute path: notifications also work before a new login shell
  # picks up home.sessionVariables/PATH after home-manager switch.
  home.file.".pi/agent/extensions/notify.ts".text =
    lib.replaceStrings [ "@pi-notifier@" ] [ notifierPath ]
      (builtins.readFile ./notify.ts);

  programs.pi-coding-agent = {
    enable = true;

    settings = {
      packages = [
        "npm:billion-context-pi"
        "npm:pi-web-access"
        "npm:@tmustier/pi-ralph-wiggum"
      ];
    };
  };
}
