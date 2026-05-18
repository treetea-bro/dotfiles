{ config, lib, pkgs, ... }:

let
  npmPrefix = "${config.home.homeDirectory}/.npm-global";
  piPackages = [
    "npm:pi-web-access@0.10.7"
    "npm:context-mode@1.0.136"
  ];
  npmGlobalPackages = [
    "pi-web-access@0.10.7"
    "context-mode@1.0.136"
  ];
in
{
  home.packages = with pkgs.llm-agents; [
    pi
    claude-code
  ];

  home.file.".pi/agent/settings.json".text = builtins.toJSON {
    packages = piPackages;
  } + "\n";

  home.activation.installPiNpmPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export NPM_CONFIG_PREFIX="${npmPrefix}"
    export PATH="${npmPrefix}/bin:${pkgs.nodejs}/bin:$PATH"

    for pkg in ${lib.escapeShellArgs npmGlobalPackages}; do
      name="''${pkg%@*}"
      if ! ${pkgs.nodejs}/bin/npm list -g "$name" --depth=0 >/dev/null 2>&1; then
        echo "Installing Pi package $pkg"
        ${pkgs.nodejs}/bin/npm install -g "$pkg"
      fi
    done
  '';
}
