{
  description = "Home Manager configuration of peco / seungmin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, llm-agents, ... }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [ llm-agents.overlays.default ];
        config.allowUnfree = true;
      };

      commonModules = [
        nixvim.homeModules.nixvim
        ./home.nix
        ./modules/brave/brave.nix
        ./modules/fzf/bat.nix
        ./modules/fzf/fd.nix
        ./modules/fzf/fzf.nix
        ./modules/wezterm/wezterm.nix
        ./modules/atuin.nix
        ./modules/bash.nix
        ./modules/carapace.nix
        ./modules/llm-agents.nix
        ./modules/direnv.nix
        ./modules/eza.nix
        ./modules/fish.nix
        ./modules/fx.nix
        ./modules/ghq.nix
        ./modules/git-commitizen.nix
        ./modules/git.nix
        ./modules/go.nix
        ./modules/karabiner.nix
        ./modules/kubernetes-helm.nix
        ./modules/lazygit.nix
        ./modules/nixvim
        ./modules/man.nix
        ./modules/nerd-font.nix
        ./modules/nodejs.nix
        ./modules/ripgrep.nix
        ./modules/yazi.nix
        ./modules/zathura.nix
        ./modules/zellij.nix
        ./modules/zoxide.nix
      ];
    in {
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
