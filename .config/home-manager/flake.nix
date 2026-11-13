{
  description = "Home Manager configuration of peco / seungmin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim/main";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };

      commonModules = [
        nixvim.homeModules.nixvim
        ./home.nix
        ./modules/linux/zathura.nix
        ./modules/mac/karabiner.nix
        ./modules/nixvim
        ./modules/wezterm/wezterm.nix
        ./modules/atuin.nix
        ./modules/bash.nix
        ./modules/bat.nix
        ./modules/carapace.nix
        ./modules/direnv.nix
        ./modules/eza.nix
        ./modules/fd.nix
        ./modules/fish.nix
        ./modules/fx.nix
        ./modules/fzf.nix
        ./modules/ghq.nix
        ./modules/git-commitizen.nix
        ./modules/git.nix
        ./modules/lazygit.nix
        ./modules/man.nix
        ./modules/nerd-font.nix
        ./modules/nodejs.nix
        ./modules/pi-agent/pi-agent.nix
        ./modules/ripgrep.nix
        ./modules/rust.nix
        ./modules/yazi.nix
        ./modules/zoxide.nix
      ];
    in
    {
      homeConfigurations = {
        "peco" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-darwin";
          modules = commonModules ++ [
            {
              home.username = "peco";
              home.homeDirectory = "/Users/peco";
            }
          ];
        };

        "seungmin" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "aarch64-linux";

          modules = commonModules ++ [
            {
              home.username = "seungmin";
              home.homeDirectory = "/home/seungmin";

              targets.genericLinux.enable = true;

              targets.genericLinux.gpu = {
                enable = true;

                nvidia = {
                  enable = true;
                  version = "580.173.02";
                  sha256 = "sha256-1lvVYIfvTXjwSoCNp4g8NaWQHF/TfpXRUKdgLrqXqoA=";
                };
              };
            }
          ];
        };

        "lsm" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs "x86_64-linux";
          modules = commonModules ++ [
            {
              home.username = "lsm";
              home.homeDirectory = "/home/lsm";
            }
          ];
        };
      };

      templates.default = {
        path = ./templates/default;
        description = "Basic Nix dev shell with direnv";
      };
    };
}
