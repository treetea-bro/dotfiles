{ config, lib, pkgs, ... }:

let
  npmPrefix = "${config.home.homeDirectory}/.npm-global";
  piPackages = [
    "npm:pi-web-access@0.10.7"
    "npm:context-mode@1.0.136"
    "npm:pi-subagents"
  ];
  npmGlobalPackages = [
    "pi-web-access@0.10.7"
    "context-mode@1.0.136"
    "pi-subagents"
  ];
  piPackagesJson = builtins.toJSON piPackages;
in
{
  home.packages = with pkgs.llm-agents; [
    pi
    claude-code
  ];

  home.activation.writePiAgentSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settingsFile="${config.home.homeDirectory}/.pi/agent/settings.json"
    ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$settingsFile")"
    desired='${piPackagesJson}'
    if [ ! -f "$settingsFile" ]; then
      printf '%s\n' "{\"packages\":$desired}" > "$settingsFile"
    else
      tmp="$(${pkgs.coreutils}/bin/mktemp)"
      ${pkgs.jq}/bin/jq --argjson pkgs "$desired" '.packages = $pkgs' "$settingsFile" > "$tmp"
      ${pkgs.coreutils}/bin/mv "$tmp" "$settingsFile"
    fi
  '';

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
