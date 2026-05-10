{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # bun
            # nodejs_25
            # (python313.withPackages (ps:
            #   with ps; [
            #     httpx
            #     requests
            #     jinja2
            #   ]))
            # clang
          ];

          shellHook = ''
            # echo "bun: $(bun --version)"
            # echo "node: $(node --version)"
            # echo "python: $(python --version)"
            echo ""
          '';
        };
      }
    );
}
