{ config, pkgs, lib, ... }:

lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  programs.brave = {
    enable = true;
    # The Brave dmg ships a `.background` directory next to the app, so
    # unpackPhase can no longer guess the source root on its own.
    package = pkgs.brave.overrideAttrs (_: { sourceRoot = "Brave Browser.app"; });
    extensions = [
      {
        id = "hfjbmagddngcpeloejdejnfgbamkjaeg";
      }
      {
        id = "aapbdbdomjkkjkaonfhkkikfgjllcleb";
      }
      {
        id = "fmkadmapgofadopljbjfkapdkoienihi";
      }
    ];
  };
}
