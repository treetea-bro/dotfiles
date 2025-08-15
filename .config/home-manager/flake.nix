{
  description = "Home Manager configuration of peco";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."peco" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          ./modules/brave/brave.nix
          ./modules/fzf/bat.nix
          ./modules/fzf/fd.nix
          ./modules/fzf/fzf.nix
          ./modules/starship/starship.nix
          ./modules/atuin.nix
          ./modules/bash.nix
          ./modules/direnv.nix
          ./modules/eza.nix
          ./modules/fish.nix
          ./modules/ghq.nix
          ./modules/git-commitizen.nix
          ./modules/git.nix
          ./modules/karabiner.nix
          ./modules/lazygit.nix
          ./modules/neovim.nix
          ./modules/nerd-font.nix
          ./modules/nodejs.nix
          ./modules/ripgrep.nix
          ./modules/rustup.nix
          ./modules/yazi.nix
          ./modules/zoxide.nix
        ];
      };
    };
}
