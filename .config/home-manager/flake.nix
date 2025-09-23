{
  description = "Home Manager configuration of peco";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."peco" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nixvim.homeModules.nixvim
          ./home.nix
          ./modules/brave/brave.nix
          ./modules/fzf/bat.nix
          ./modules/fzf/fd.nix
          ./modules/fzf/fzf.nix
          ./modules/wezterm/wezterm.nix
          ./modules/atuin.nix
          ./modules/bash.nix
          ./modules/direnv.nix
          ./modules/eza.nix
          ./modules/fish.nix
          ./modules/ghq.nix
          ./modules/git-commitizen.nix
          ./modules/git.nix
          ./modules/google-cloud-sdk.nix
          ./modules/karabiner.nix
          ./modules/kubernetes-helm.nix
          ./modules/lazygit.nix
          ./modules/nixvim
          ./modules/nerd-font.nix
          ./modules/nodejs.nix
          ./modules/rectangle.nix
          ./modules/ripgrep.nix
          ./modules/yazi.nix
          ./modules/zoxide.nix
        ];
      };
    };
}
